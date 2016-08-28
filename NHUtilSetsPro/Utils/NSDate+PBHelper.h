//
//  NSDate+PBHelper.h
//  NHUtilSetsPro
//
//  Created by hu jiaju on 16/6/29.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (PBHelper)

/**
 *  @brief simple date time ago from now
 *
 *  @return the dest ago time
 */
- (NSString *)pb_timeAgo;

/**
 *  @brief simple date time ago from now or with max interval
 *
 *  @param limit     second timeinterval
 *  @param formatter such as 'yyyy-MM-dd HH:mm:ss'
 *
 *  @return the dest ago time
 */
- (NSString *)pb_timeAgoWithLimit:(NSTimeInterval)limit dateFormatterString:(NSString *)formatter;

/**
 *  @brief chat style time stamp 2 string
 *
 *  @param stamp time interval since now
 *
 *  @return readable time formatter
 */
+ (NSString *)pb_chatTimeStamp:(long long)stamp;

NS_ASSUME_NONNULL_END

@end
