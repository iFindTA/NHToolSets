//
//  NSObject+PBHelper.m
//  NHUtilSetsPro
//
//  Created by nanhu on 2016/12/13.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import "NSObject+PBHelper.h"
#import <mach/mach_time.h>

@implementation NSObject (PBHelper)

- (void)pb_measureBlock:(void (^)(void))block {
    NSLog(@"------------------------measure block excute time start...------------------------");
    uint64_t start = mach_absolute_time();
    if (block) {
        block();
    }
    uint64_t end = mach_absolute_time();
    uint64_t elapsed = end-start;
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS) {
        printf("mach_timebase_info failed!\n");
    }
    uint64_t nanosecs = elapsed * info.numer / info.denom;
    uint64_t millisecs = nanosecs / 1000000;
    NSLog(@"------------------------measure block excute time end for:%lld ms------------------------", millisecs);
}

@end
