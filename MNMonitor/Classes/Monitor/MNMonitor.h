//
//  MNMonitor.h
//  MNMonitor
//
//  Created by 刘楠 on 2018/7/17.
//

#import <Foundation/Foundation.h>
#import "MNRecordConfig.h"

@interface MNMonitor : NSObject
+ (instancetype)sharedInstance;
- (void)startMonitoringWithConfig:(MNRecordConfig *)config;
- (void)stopMonitoring;
@end
