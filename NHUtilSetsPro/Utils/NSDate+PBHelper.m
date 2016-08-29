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

+ (NSDate *)pb_dateFromString:(NSString *)time {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });
    return [dateFormatter dateFromString:time];
}

+ (NSString *)pb_chatTimeStamp:(long long)stamp {
    
    //    NSLog(@"%f", different);
    NSDate *mNow = [NSDate date];
    NSTimeInterval interval = [mNow timeIntervalSince1970];
    if (interval < stamp) {
        return @"哈哈 穿越了";
    } else {
        
        // 当前时间
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *currentComps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:mNow];
        NSInteger currentYear = [currentComps year];
        NSInteger currentMonth = [currentComps month];
        NSInteger currentDay = [currentComps day];
        
        // 传入时间
        NSDate *disDate = [NSDate dateWithTimeIntervalSince1970:stamp];
        NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:disDate];
        NSInteger year = [comps year];
        NSInteger month = [comps month];
        NSInteger day = [comps day];
        NSInteger weekday = [comps weekday];
        //        NSLog(@"year:%ld month: %ld, day: %ld", year, month, day);
        
        // 传入时间的时分
        comps =[calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute)
                           fromDate:disDate];
        NSUInteger hour = [comps hour];
        NSUInteger minute = [comps minute];
        
        NSString *todayStr = [NSString stringWithFormat:@"%zd-%zd-%zd 23:59:59", currentYear, currentMonth, currentDay];
        float different = - [disDate timeIntervalSinceDate:[NSDate pb_dateFromString:todayStr]];
        float dayDifferent = floor(different / 86400);
        
        if (dayDifferent < 1) {
            return [NSString stringWithFormat:@"%.2zd:%.2zd", hour, minute];
        } else if (dayDifferent < 2) {
            return [NSString stringWithFormat:@"昨天 %.2zd:%.2zd", hour, minute];
        } else if (dayDifferent < 7) {
            NSString *weekdayStr = [NSString string];
            switch (weekday) {
                case 1:
                    weekdayStr = @"星期日";
                    break;
                case 2:
                    weekdayStr = @"星期一";
                    break;
                case 3:
                    weekdayStr = @"星期二";
                    break;
                case 4:
                    weekdayStr = @"星期三";
                    break;
                case 5:
                    weekdayStr = @"星期四";
                    break;
                case 6:
                    weekdayStr = @"星期五";
                    break;
                case 7:
                    weekdayStr = @"星期六";
                    break;
                default:
                    break;
            }
            return [NSString stringWithFormat:@"%@ %.2zd:%.2zd", weekdayStr, hour, minute];
        } else if (year == currentYear) {
            return [NSString stringWithFormat:@"%zd-%zd %.2zd:%.2zd", month, day, hour, minute];
        } else {
            return [NSString stringWithFormat:@"%zd-%zd-%zd %.2zd:%.2zd", year, month, day, hour, minute];
        }
    }
    
    return nil;
}

@end
