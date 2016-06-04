//
//  UIDevice+PBHelper.h
//  NHUtilSetsPro
//
//  Created by hu jiaju on 16/4/14.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (PBHelper)

/**
 *  @brief platform
 *
 *  @return the device's platform eg. iPhone6s
 */
+(NSString *)pb_platform;

NS_ASSUME_NONNULL_END

@end
