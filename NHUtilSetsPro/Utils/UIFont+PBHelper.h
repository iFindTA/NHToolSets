//
//  UIFont+PBHelper.h
//  NHUtilSetsPro
//
//  Created by hu jiaju on 16/4/14.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (PBHelper)

/**
 *	@brief	system's title font
 *
 *	@return	return the title's font
 */
+ (UIFont *)pb_deviceFontForTitle;

/**
 *	@brief	navigation title
 *
 *	@return	the title default font
 */
+ (UIFont *)pb_navigationTitle;

/**
 register user-defined font

 @param fontPath the font file path
 */
+ (void)registerFontPath:(NSString *)fontPath;

NS_ASSUME_NONNULL_END

@end
