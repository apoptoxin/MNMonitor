//
//  MNMonitorTracker.h
//  Pods-MNMonitor_Example
//
//  Created by 刘楠 on 2018/7/19.
//

#import <Foundation/Foundation.h>
#import "MNMonitorTrackerConfig.h"

@interface MNMonitorTracker : NSObject
+ (instancetype)sharedTracker;
- (void)startWithConfig:(MNMonitorTrackerConfig *)config;
- (void)stop;
@end
