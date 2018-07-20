//
//  MNBaseTrackerConfig.h
//  Pods-MNMonitor_Example
//
//  Created by 刘楠 on 2018/7/19.
//

#import <Foundation/Foundation.h>
#import "MNTrackerConfigHeader.h"

@interface MNBaseTrackerConfig : NSObject
@property (nonatomic, assign, readonly) double timeInterval;
@property (nonatomic, copy, readonly) MNTrackerCompletionBlock completion;

+ (instancetype)instanceWithTimeInterval:(double)timeInterval completionBlock:(MNTrackerCompletionBlock)completion;
@end
