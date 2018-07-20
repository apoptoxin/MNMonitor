//
//  MNMonitorTrackerConfig.m
//  Pods-MNMonitor_Example
//
//  Created by 刘楠 on 2018/7/19.
//

#import "MNMonitorTrackerConfig.h"

@interface MNMonitorTrackerConfig()
@property (nonatomic, strong, readwrite) MNCPUTrackerConfig *cpuConfig;
@property (nonatomic, strong, readwrite) MNMemoryTrackerConfig *memConfig;
@property (nonatomic, strong, readwrite) MNMainRunloopTrackerConfig *runloopConfig;
@end

@implementation MNMonitorTrackerConfig
+ (instancetype)configWithCPUConfig:(MNCPUTrackerConfig *)cpuConfig
                          memConfig:(MNMemoryTrackerConfig *)memConfig
                      runloopConfig:(MNMainRunloopTrackerConfig *)runloopConfig
{
    MNMonitorTrackerConfig *config = [MNMonitorTrackerConfig new];
    config.cpuConfig = cpuConfig;
    config.memConfig = memConfig;
    config.runloopConfig = runloopConfig;
    return config;
}
@end
