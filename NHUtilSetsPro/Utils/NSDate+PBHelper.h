//
//  NSDate+PBHelper.h
//  NHUtilSetsPro
//
//  Created by hu jiaju on 16/6/29.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (PBHelper)

/**
 *  @brief simple date time ago from now
 *
 *  @return the dest ago time
 */
- (NSString *)pb_timeAgo;

/**
 *  @brief <#Description#>
 *
 *  @param limit     second timeinterval
 *  @param formatter such as 'yyyy-MM-dd HH:mm:ss'
 *
 *  @return the dest ago time
 */
- (NSString *)pb_timeAgoWithLimit:(NSTimeInterval)limit dateFormatterString:(NSString *)formatter;

@end
