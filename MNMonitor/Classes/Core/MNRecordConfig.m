//
//  MNRecordConfig.m
//  MNMonitor
//
//  Created by 刘楠 on 2018/7/17.
//

#import "MNRecordConfig.h"

@implementation MNRecordConfig
+ (instancetype) defaultConfiguration {
    MNRecordConfig *config = [[self.class alloc] init];
    config.cpuConfig = [MNCPURecordConfig defaultConfiguration];
    config.memoryConfig = [MNMemoryRecordConfig defaultConfiguration];
    return config;
}
@end

@implementation MNBaseRecordConfig
+ (instancetype) defaultConfiguration {
    MNBaseRecordConfig *config = [[self.class alloc] init];
    config.recordTimeInterval = 0.3f;
    return config;
}
@end


@implementation MNCPURecordConfig

@end

@implementation MNMemoryRecordConfig

@end
