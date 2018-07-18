//
//  MNRecordConfig.h
//  MNMonitor
//
//  Created by 刘楠 on 2018/7/17.
//

#import <Foundation/Foundation.h>

@interface MNBaseRecordConfig : NSObject
@property (nonatomic, assign) CGFloat recordTimeInterval;
+ (instancetype) defaultConfiguration;
@end


@interface MNCPURecordConfig : MNBaseRecordConfig

@end

@interface MNMemoryRecordConfig : MNBaseRecordConfig

@end

@interface MNRecordConfig : NSObject
@property (nonatomic, strong) MNCPURecordConfig *cpuConfig;
@property (nonatomic, strong) MNMemoryRecordConfig *memoryConfig;
@end

