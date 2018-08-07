//
//  MNMonitorTracker.m
//  Pods-MNMonitor_Example
//
//  Created by 刘楠 on 2018/7/19.
//

#import "MNMonitorTracker.h"
#import "MNCPURecorder.h"
#import "MNMemoryRecorder.h"

@interface MNMonitorTracker()
@property (nonatomic, strong) MNMonitorTrackerConfig *config;
@property (nonatomic, strong) NSMutableArray *timerAry;
@property (atomic, strong) NSRunLoop *runningLoop;
@property (atomic, strong) dispatch_queue_t runningQueue;
@end

@implementation MNMonitorTracker

+ (instancetype)sharedTracker {
    static MNMonitorTracker *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self.class alloc] init];
    });
    return instance;
}

- (void)startWithConfig:(MNMonitorTrackerConfig *)config {
    //先停掉原有的
    [self stop];
    _config = config;
    //启动新的runloop
    [self _startThread];
}

- (void)stop {
    [self.timerAry enumerateObjectsUsingBlock:^(NSTimer*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj invalidate];
    }];
    [self.timerAry removeAllObjects];
//    [self _stopThreadAndSetNil];
}

#pragma mark - Private Method
- (void)_startThread {
    
    dispatch_async(self.runningQueue, ^{
        [self _runThreadAndKeep];
    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"thread:%@",self.runningThread);
//    });
}

- (void)_runThreadAndKeep {
    @autoreleasepool {
        NSRunLoop *curLoop = [NSRunLoop currentRunLoop];
        _runningLoop = curLoop;
//        [self addObserver];

    
        //生成新的timer
        [self _generateTimeAndSetToRunloopWithConfig:self.config];
        [curLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
//        [curLoop run];
//    BOOL abc = [curLoop runMode:NSRunLoopCommonModes beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    
//    while (1) {
        BOOL result = [curLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        NSLog(@"run result %d",result);
//    }
    
    }
}

- (void)_stopThreadAndSetNil {
    if (self.runningQueue) {
        dispatch_async(self.runningQueue, ^{
            [self _stopCurrentRunloop];
            self.runningQueue = nil;
        });
    }
}

- (void)_stopCurrentRunloop {
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)_generateTimeAndSetToRunloopWithConfig:(MNMonitorTrackerConfig *)config {
    if (config.cpuConfig) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:config.cpuConfig.timeInterval target:self selector:@selector(_startCPUTrack) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    
    if (config.memConfig) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:config.memConfig.timeInterval target:self selector:@selector(_startMemoryTrack) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

- (void)_startCPUTrack {
    BOOL succeed = YES;
    double usage = [MNCPURecorder currentCPUUsage:&succeed];
    if (succeed && self.config.cpuConfig.completion) {
        self.config.cpuConfig.completion(usage, succeed);
    }
}

- (void)_startMemoryTrack {
    BOOL succeed = YES;
    double usage = [MNMemoryRecorder currentMemoryUsage:&succeed];
    if (succeed && self.config.memConfig.completion) {
        self.config.memConfig.completion(usage, succeed);
    }
}
#pragma mark - getter and setter

- (dispatch_queue_t)runningQueue {
    if (!_runningQueue) {
        NSString *queueID = [[[NSBundle mainBundle].bundleIdentifier stringByAppendingPathExtension:@"MNTracker"] stringByAppendingPathExtension:[[NSUUID UUID] UUIDString]];
        _runningQueue = dispatch_queue_create([queueID cStringUsingEncoding:NSUTF8StringEncoding], DISPATCH_QUEUE_SERIAL);
    }
    return _runningQueue;
}

// 添加一个监听者
- (void)addObserver {
    
    // 1. 创建监听者
    /**
     *  创建监听者
     *
     *  @param allocator#>  分配存储空间
     *  @param activities#> 要监听的状态
     *  @param repeats#>    是否持续监听
     *  @param order#>      优先级, 默认为0
     *  @param observer     观察者
     *  @param activity     监听回调的当前状态
     */
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        /*
         kCFRunLoopEntry = (1UL << 0),          进入工作
         kCFRunLoopBeforeTimers = (1UL << 1),   即将处理Timers事件
         kCFRunLoopBeforeSources = (1UL << 2),  即将处理Source事件
         kCFRunLoopBeforeWaiting = (1UL << 5),  即将休眠
         kCFRunLoopAfterWaiting = (1UL << 6),   被唤醒
         kCFRunLoopExit = (1UL << 7),           退出RunLoop
         kCFRunLoopAllActivities = 0x0FFFFFFFU  监听所有事件
         */
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"runloop 进入");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"runloop 即将处理Timer事件");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"runloop 即将处理Source事件");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"runloop 即将休眠");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"runloop 被唤醒");
                break;
            case kCFRunLoopExit:
                NSLog(@"runloop 退出RunLoop");
                break;
            default:
                break;
        }
    });
    
    // 2. 添加监听者
    /**
     *  给指定的RunLoop添加监听者
     *
     *  @param rl#>       要添加监听者的RunLoop
     *  @param observer#> 监听者对象
     *  @param mode#>     RunLoop的运行模式, 填写默认模式即可
     */
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
}
@end
