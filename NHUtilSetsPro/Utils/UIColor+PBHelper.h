//
//  UIColor+PBHelper.h
//  NHUtilSetsPro
//
//  Created by hu jiaju on 16/4/14.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

struct PBRGBA {
    CGFloat r;
    CGFloat g;
    CGFloat b;
    CGFloat a;
};

typedef struct PBRGBA PBRGBA;

@interface UIColor (PBHelper)

/**
 *	@brief	generate color
 *
 *	@return	random color instance
 */
+ (UIColor *)pb_randomColor;

/**
 *	@brief	generate color
 *
 *	@param 	hexString 	eg:#34DE8A
 *
 *	@return	color's instance
 */

+ (UIColor *)pb_colorWithHexString:(NSString *)hexString;

/**
 *  @brief get rgba value from color
 *
 *  @param color the source color
 *
 *  @return the rgba value
 */
+ (PBRGBA)pb_rgbaFromUIColor:(UIColor *)color;

NS_ASSUME_NONNULL_END

@end
