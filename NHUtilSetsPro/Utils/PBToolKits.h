//
//  PBToolKits.h
//  NHUtilSetsPro
//
//  Created by hu jiaju on 15/11/14.
//  Copyright © 2015年 hu jiaju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>

#ifndef WEAKSELFPB
#define WEAKSELFPB       __weak typeof(&*self) weakSelfPB = self;
#endif
#define PBMAIN(block)  if ([NSThread isMainThread]) {\
block();\
}else{\
dispatch_async(dispatch_get_main_queue(),block);\
}
#define PBMAINDelay(x, block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(x * NSEC_PER_SEC)), dispatch_get_main_queue(), block)
#define PBBACK(block)  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

@interface PBToolKits : NSObject

@end

@interface NSArray (PBHelper)

/**
 *	@brief	Judging method
 *
 *	@return	whether the array is empty
 */
- (BOOL)pb_isEmpty;

@end

@interface NSDictionary (PBHelper)

/**
 *	@brief	Judging method
 *
 *	@return	whether the map is empty
 */
- (BOOL)pb_isEmpty;

@end

@interface NSString (PBHelper)

/**
 *	@brief	Judging method
 *
 *	@return	whether the string is empty
 */
- (BOOL)pb_isEmpty;

/**
 *	@brief	Judging method
 *
 *	@return	whether only contain numbers
 */
- (BOOL)pb_isOnlyNumbers;

/**
 *	@brief	Judging method
 *
 *	@return	wheter only contain letters
 */
- (BOOL)pb_isOnlyLetters;

/**
 *	@brief	Judging method
 *
 *	@return	whether only contain number or letter
 */
- (BOOL)pb_isNumberOrLetter;

/**
 *	@brief	caculate string's size
 *
 *	@param 	font 	string's font
 *	@param 	width 	string's width
 *
 *	@return	the adjust size of string
 */
- (CGSize)pb_sizeThatFitsaWithFont:(UIFont *)font width:(CGFloat)width;

@end

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

@end

@interface UIImage (PBHelper)

/**
 *	@brief	Judging Method
 *
 *	@param 	image 	other image
 *
 *	@return	whether only the two image is equal
 */
- (BOOL)pb_isEqualTo:(UIImage *)image;


/**
 *	@brief	generate image
 *
 *	@param 	color 	the image's color
 *
 *	@return	the image from color
 */
+ (UIImage *)pb_imageWithColor:(UIColor *)color;

/**
 *	@brief	blur image
 *
 *	@param 	blurAmount 	blur level, default is 0.5
 *
 *	@return	the blured image
 */
- (UIImage *)pb_blurredImage:(CGFloat)level;

/**
 *	@brief	generate small image
 *
 *	@param 	bounds 	the destnation image's frame
 *
 *	@return	the cropped image
 */
- (UIImage *)pb_croppedBounds:(CGRect)bounds;

/**
 *	@brief	scale image
 *
 *	@param 	dstSize 	the destnation size
 *
 *	@return	the scaled image
 */
- (UIImage*)pb_scaleToSize:(CGSize)dstSize;

/**
 *	@brief	create round corner image
 *
 *	@param 	size 	destnation size
 *	@param 	radius 	destnation radius
 *
 *	@return	the round image
 */
- (UIImage *)pb_roundCornerWithSize:(CGSize)size withRadius:(NSInteger)radius;

/**
 *	@brief	generate dark image
 *
 *	@param 	color 	dark color
 *	@param 	level 	dark level
 *
 *	@return	the dark image
 */
- (UIImage *)pb_darkColor:(UIColor *)color lightLevel:(CGFloat)level;


@end
