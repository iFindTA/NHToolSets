//
//  UIImage+PBHelper.h
//  NHUtilSetsPro
//
//  Created by hu jiaju on 16/4/14.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (PBHelper)

/**
 *  @brief load image from content path that not cached in memory
 *
 *  @param name the image's name
 *
 *  @attention: it will not work if you set imageassets!!!
 *
 *  @return the image
 */
+ (nullable UIImage *)pb_imagePathed:(NSString *)name;

/**
 *  @brief load image from content path that not cached in memory
 *
 *  @param name the image's name
 *  @param ext  jpg or png, default is png
 *
 *  @attention: it will not work if you set imageassets!!!
 *
 *  @return the image
 */
+ (nullable UIImage *)pb_imagePathed:(NSString *)name extention:(nullable NSString *)ext;

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
- (UIImage *)pb_scaleToSize:(CGSize)dstSize DEPRECATED_MSG_ATTRIBUTE("use pb_scaleToSize: keepAspect: method instead");

/**
 *	@brief	scale image
 *
 *	@param 	dstSize 	the destnation size
 *	@param 	keep 	whether keep image's width/height scale info
 *
 *	@return	the scaled image
 */
- (UIImage *)pb_scaleToSize:(CGSize)dstSize keepAspect:(BOOL)keep;

/**
 *	@brief	generate round image
 *
 *	@return	the round image
 */
- (UIImage *)pb_roundImage;

/**
 *	@brief	generate round image
 *
 *	@param 	bWidth 	the round image's border width
 *	@param 	color 	the round image's border color
 *
 *	@return	the round image
 */
- (UIImage *)pb_roundImageWithBorderWidth:(int)bWidth withColor:(UIColor *)color;

/**
 *	@brief	generate round corner image
 *
 *	@param 	radius 	the round corner radius
 *
 *	@return	the round corner image
 */
- (UIImage *)pb_roundCornerWithRadius:(int)radius;

/**
 *	@brief	generate round corner image
 *
 *	@param 	radius 	the round corner redius
 *	@param 	bWidth 	the border width
 *	@param 	bColor 	the border color default is white
 *
 *	@return	the round corner image
 */
- (UIImage *)pb_roundCornerWithRadius:(int)radius withBorderWidth:(int)bWidth withBorderColor:(UIColor *)bColor;

/**
 *	@brief	generate dark image
 *
 *	@param 	color 	dark color
 *	@param 	level 	dark level
 *
 *	@return	the dark image
 */
- (UIImage *)pb_darkColor:(UIColor *)color lightLevel:(CGFloat)level;

/**
 *	@brief	generate image for iconfont
 *
 * To use this function you must add custom icon font into your plist file
 * for the key 'Fonts provided by application : iconfont.ttf'
 *
 *	@param 	fontName 	iconfont name default is named of 'iconfont'
 *	@param 	name        icon name
 *	@param 	size        the image's size
 *	@param 	color       the image's color default is white color
 *
 *	@return	the icon image
 */
+ (UIImage *)pb_iconFont:(NSString * _Nullable)fontName withName:(NSString *)name withSize:(NSInteger)size withColor:(UIColor *)color;

/*!
 *  @brief generate round corner image
 *
 *  @param radius the corner's size
 *  @param size   the image's new size
 *
 *  @return the round corner image
 */
- (UIImage *)pb_drawRoundCornerWithRadius:(CGFloat)radius toSize:(CGSize)size;

NS_ASSUME_NONNULL_END

@end
