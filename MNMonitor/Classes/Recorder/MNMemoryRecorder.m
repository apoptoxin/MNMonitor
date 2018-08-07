//
//  MNMemoryRecorder.m
//  AWECloudCommand-iOS8.0
//
//  Created by 刘楠 on 2018/8/7.
//

#import "MNMemoryRecorder.h"
#import <mach/mach.h>

@implementation MNMemoryRecorder
+ (double)currentMemoryUsage:(BOOL *)succeed {
    kern_return_t status;
    mach_msg_type_number_t infoCount;
    
    struct task_basic_info basicInfo;
    infoCount = TASK_BASIC_INFO_COUNT;
    status = task_info(current_task(),
                       TASK_BASIC_INFO,
                       (task_info_t)&basicInfo,
                       &infoCount);
    if (status != KERN_SUCCESS) {
        if (succeed) {
            *succeed = NO;
        }
        return -1;
    }
    vm_size_t memSize = basicInfo.resident_size;    // Memory usage [bytes]
    if (succeed) {
        *succeed = YES;
    }
    return memSize / 1024.0;
}
@end
