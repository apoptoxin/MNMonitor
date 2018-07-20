//
//  MNBaseTrackerConfig.m
//  Pods-MNMonitor_Example
//
//  Created by 刘楠 on 2018/7/19.
//

#import "MNBaseTrackerConfig.h"

@interface MNBaseTrackerConfig()
@property (nonatomic, assign, readwrite) double timeInterval;
@property (nonatomic, copy, readwrite) MNTrackerCompletionBlock completion;
@end

@implementation MNBaseTrackerConfig

+ (instancetype)instanceWithTimeInterval:(double)timeInterval completionBlock:(MNTrackerCompletionBlock)completion {
    return [[self.class alloc] initWithTimeInterval:timeInterval completion:completion];
}

- (instancetype)initWithTimeInterval:(double)timeInterval completion:(MNTrackerCompletionBlock)completion {
    if (self = [super init]) {
        self.timeInterval = timeInterval;
        self.completion = completion;
    }
    return self;
}

- (id)init {
    return [self initWithTimeInterval:3.0 completion:nil];
}
@end
