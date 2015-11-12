//
//  NHUtils.h
//  NHUtilSetsPro
//
//  Created by hu jiaju on 15/11/2.
//  Copyright © 2015年 hu jiaju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

#ifndef WEAKSELF
#define WEAKSELF       __weak typeof(&*self) weakSelf = self;
#endif
#define NHMAIN(block)  dispatch_async(dispatch_get_main_queue(),block)
#define NHMAINDelay(block, x) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(x * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
#define NHBACK(block)  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

@interface NHUtils : NSObject

@end

@interface NSArray (Helper)

/**
 *	@brief	Judging method
 *
 *	@return	whether the array is empty
 */
- (BOOL)isEmpty;

@end

@interface NSDictionary (Helper)

/**
 *	@brief	Judging method
 *
 *	@return	whether the map is empty
 */
- (BOOL)isEmpty;

@end

@interface NSString (Helper)

/**
 *	@brief	Judging method
 *
 *	@return	whether the string is empty
 */
- (BOOL)isEmpty;

/**
 *	@brief	Judging method
 *
 *	@return	whether only contain numbers
 */
- (BOOL)isOnlyNumbers;

/**
 *	@brief	Judging method
 *
 *	@return	wheter only contain letters
 */
- (BOOL)isOnlyLetters;

/**
 *	@brief	Judging method
 *
 *	@return	whether only contain number or letter
 */
- (BOOL)isNumberOrLetter;

/**
 *	@brief	Hash
 *
 *	@return	md5 hash value
 */
- (NSString *)MD5Hash;

/**
 *	@brief	Hash
 *
 *	@return	sha1 hash value
 */
- (NSString *)SHA1Hash;

/**
 *	@brief	caculate string's size
 *
 *	@param 	font 	string's font
 *	@param 	width 	string's width
 *
 *	@return	the adjust size of string
 */
- (CGSize)sizeThatFitsaWithFont:(UIFont *)font width:(CGFloat)width;

@end

@interface UIImage (Helper)

/**
 *	@brief	Judging Method
 *
 *	@param 	image 	other image
 *
 *	@return	whether only the two image is equal
 */
- (BOOL)isEqualTo:(UIImage *)image;


/**
 *	@brief	generate image
 *
 *	@param 	color 	the image's color
 *
 *	@return	the image from color
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *	@brief	generate small image
 *
 *	@param 	bounds 	the destnation image's frame
 *
 *	@return	the cropped image
 */
- (UIImage *)croppedImage:(CGRect)bounds;

/**
 *	@brief	scale image
 *
 *	@param 	dstSize 	the destnation size
 *
 *	@return	the scaled image
 */
- (UIImage*)scaleImageToSize:(CGSize)dstSize;

/**
 *	@brief	create round corner image
 *
 *	@param 	image 	the origin image
 *	@param 	size 	destnation size
 *	@param 	radius 	destnation radius
 *
 *	@return	the round image
 */
- (UIImage *)createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius;

/**
 *	@brief	generate dark image
 *
 *	@param 	color 	dark color
 *	@param 	level 	dark level
 *
 *	@return	the dark image
 */
- (UIImage *)darkColor:(UIColor *)color lightLevel:(CGFloat)level;


@end

@interface UIColor (Helper)

/**
 *	@brief	generate color
 *
 *	@return	random color instance
 */
+ (UIColor *)randomColor;

/**
 *	@brief	generate color
 *
 *	@param 	hexString 	eg:#34DE8A
 *
 *	@return	color's instance
 */

+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end

@interface UIView (Helper)

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat centerX,centerY;
@property (nonatomic, assign) CGFloat width,height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@end
