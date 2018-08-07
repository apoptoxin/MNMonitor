//
//  MNMemoryRecorder.h
//  AWECloudCommand-iOS8.0
//
//  Created by 刘楠 on 2018/8/7.
//

#import <Foundation/Foundation.h>

@interface MNMemoryRecorder : NSObject

/**
 calculate memory usage

 @param succeed
 @return memory usage(KB)
 */
+ (double)currentMemoryUsage:(BOOL *)succeed;
@end
