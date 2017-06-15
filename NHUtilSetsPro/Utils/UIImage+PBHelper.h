//
//  UIImage+PBHelper.h
//  NHUtilSetsPro
//
//  Created by hu jiaju on 16/4/14.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

struct PBImgTextInfo {
    unsigned int                        fontSize;
    const char                         *fontName;
    const char                         *textColor; //image font color
    const char                         *bgColor; //image background color
    unsigned int                        width; //image size width
    unsigned int                        height;//image size height
};
typedef struct PBImgTextInfo PBImgTextInfo;

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
 generate image

 @param text that draw on the image
 @param info of the dest-img
 @return image
 */
+ (UIImage *)pb_imageWithText:(NSString *)text withInfo:(PBImgTextInfo)info;

/**
 convert image to color from a CGPoint

 @param pt point for destnation
 @return color
 */
- (UIColor * _Nullable)pb_image2Color4Point:(CGPoint)pt;

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
 adjust the alphe property of the image

 @param alpha channel
 @return image
 */
- (UIImage *)pb_imageWithAlpha:(CGFloat)alpha;

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

/**
 *	@brief	generate qr code
 *
 *	@param 	code 	info string
 *	@param 	size 	image size
 *
 *	@return	the info qr code image
 */
+ (UIImage *)pb_generateQRCode:(NSString *)code size:(CGSize)size;

/**
 *	@brief	generate bar code
 *
 *	@param 	code 	info string
 *	@param 	size 	image size
 *
 *	@return	the info bar code image
 */
+ (UIImage *)pb_generateBarCode:(NSString *)code size:(CGSize)size;

/**
 *	@brief	merge image
 *
 *	@param 	icon 	the small icon image to merge in center
 *	@param 	size 	meger size, should not more than origin image's 25%
 *
 *	@return	merged image
 */
- (UIImage *)pb_mergeImage:(UIImage *)icon size:(CGSize)size;

/**
 assemble group chat avatar

 @param avatars :group member's avatars
 @param size :destnation avatar size
 @param bgColor :avatar's bg color
 @return group avatar
 */
+ (UIImage *)pb_assembleGroupAvatarWithUsrAvatars:(NSArray *)avatars forAvatarSize:(CGSize)size forBgColor:(UIColor *)bgColor;

NS_ASSUME_NONNULL_END

@end
