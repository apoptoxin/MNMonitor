//
//  MNMonitorTrackerConfig.h
//  Pods-MNMonitor_Example
//
//  Created by 刘楠 on 2018/7/19.
//

#import <Foundation/Foundation.h>
#import "MNCPUTrackerConfig.h"
#import "MNMemoryTrackerConfig.h"
#import "MNMainRunloopTrackerConfig.h"

@interface MNMonitorTrackerConfig : NSObject
@property (nonatomic, strong, readonly) MNCPUTrackerConfig *cpuConfig;
@property (nonatomic, strong, readonly) MNMemoryTrackerConfig *memConfig;
@property (nonatomic, strong, readonly) MNMainRunloopTrackerConfig *runloopConfig;

+ (instancetype)configWithCPUConfig:(MNCPUTrackerConfig *)cpuConfig
                          memConfig:(MNMemoryTrackerConfig *)memConfig
                      runloopConfig:(MNMainRunloopTrackerConfig *)runloopConfig;
@end
 
