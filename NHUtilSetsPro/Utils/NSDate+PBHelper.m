//
//  NSDate+PBHelper.m
//  NHUtilSetsPro
//
//  Created by hu jiaju on 16/6/29.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import "NSDate+PBHelper.h"

@implementation NSDate (PBHelper)

- (NSString *)pb_timeAgo {
    NSDate *now = [NSDate date];
    double deltaSeconds = fabs([self timeIntervalSinceDate:now]);
    double deltaMinutes = deltaSeconds / 60.0f;
    
    int minutes;
    
    /*if(deltaSeconds < 5)
     {
     return NSDateTimeAgoLocalizedStrings(@"Just now");
     }
     else*/ if(deltaSeconds < 60)
     {
         return @"刚刚";
     }/*
       else if(deltaSeconds < 120)
       {
       return @"一分钟前";
       }*/
     else if (deltaMinutes < 60)
     {
         return [NSString stringWithFormat:@"%d分钟前",(int)deltaMinutes];
     }
     else if (deltaMinutes < 120)
     {
         return @"1小时前";
     }
     else if (deltaMinutes < (24 * 60))
     {
         minutes = (int)floor(deltaMinutes/60);
         return [NSString stringWithFormat:@"%d小时前",minutes];
     }/*
       else if (deltaMinutes < (24 * 60 * 2))
       {
       return @"昨天";
       }
       else if (deltaMinutes < (24 * 60 * 7))
       {
       minutes = (int)floor(deltaMinutes/(60 * 24));
       return [self stringFromFormat:@"%d天前" withValue:minutes];
       }
       else if (deltaMinutes < (24 * 60 * 14))
       {
       return NSDateTimeAgoLocalizedStrings(@"Last week");
       }*/
     else if (deltaMinutes < (24 * 60 * 31))
     {
         minutes = (int)floor(deltaMinutes/(60 * 24));
         return [NSString stringWithFormat:@"%d天前",minutes];
     }/*
       else if (deltaMinutes < (24 * 60 * 61))
       {
       return NSDateTimeAgoLocalizedStrings(@"Last month");
       }*/
     else if (deltaMinutes < (24 * 60 * 365.25))
     {
         minutes = (int)floor(deltaMinutes/(60 * 24 * 30));
         return [NSString stringWithFormat:@"%d个月前",minutes];
     }/*
       else if (deltaMinutes < (24 * 60 * 731))
       {
       return NSDateTimeAgoLocalizedStrings(@"Last year");
       }*/
    
    minutes = (int)floor(deltaMinutes/(60 * 24 * 365));
    return [NSString stringWithFormat:@"%d年前",minutes];
}

- (NSString *)pb_timeAgoWithLimit:(NSTimeInterval)limit dateFormatterString:(NSString *)formatter {
    if (fabs([self timeIntervalSinceDate:[NSDate date]]) <= limit)
        return [self pb_timeAgo];
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = formatter;
    });
    return [dateFormatter stringFromDate:self];
}

@end
