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

/// weak self reference
#define weakify(var) __weak typeof(var) PBWeak_##var = var;
#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = PBWeak_##var; \
_Pragma("clang diagnostic pop")
/// screen size
#ifndef PBSCREEN_WIDTH
#define PBSCREEN_WIDTH   ([[UIScreen mainScreen]bounds].size.width)
#endif
#ifndef PBSCREEN_HEIGHT
#define PBSCREEN_HEIGHT  ([[UIScreen mainScreen]bounds].size.height)
#endif
/// system version
#ifndef PBIOS8_ABOVE
#define PBIOS8_ABOVE   ([[UIDevice currentDevice].systemVersion compare:@"8.0"] != NSOrderedDescending)
#endif
/// animation custom duration
#ifndef PBANIMATE_DURATION
#define PBANIMATE_DURATION                        0.25f
#endif
/// main / background thead
#define PBMAIN(block)  if ([NSThread isMainThread]) {\
block();\
}else{\
dispatch_async(dispatch_get_main_queue(),block);\
}
#define PBMAINDelay(x, block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(x * NSEC_PER_SEC)), dispatch_get_main_queue(), block)
#define PBBACK(block)  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#define PBFormat(format, ...) [NSString stringWithFormat:format, ##__VA_ARGS__]

static inline BOOL PBIsEmpty(id obj) {
    return obj == nil
    || (NSNull *)obj == [NSNull null]
    || ([obj respondsToSelector:@selector(length)] && [obj length] == 0)
    || ([obj respondsToSelector:@selector(count)] && [obj count] == 0);
}

static inline NSString *PBAvailableString (NSString *obj) {
    return PBIsEmpty(obj)?@"":obj;
}

static inline NSNumber *PBAvailableNumber (NSNumber *obj) {
    return PBIsEmpty(obj)?[NSNumber numberWithInt:0]:obj;
}

static inline NSArray *PBAvailableArray (NSArray *obj) {
    return PBIsEmpty(obj)?[NSArray array]:obj;
}

static inline NSDictionary *PBAvailableDictionary (NSDictionary *obj) {
    return PBIsEmpty(obj)?[NSDictionary dictionary]:obj;
}

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

///////////////// NSDictionary Safe Accessors ///////////////
/// home page: https://github.com/allenhsu/NSDictionary-Accessors

- (BOOL)isArrayForKey:(NSString *)key;
- (BOOL)isDictionaryForKey:(NSString *)key;
- (BOOL)isStringForKey:(NSString *)key;
- (BOOL)isNumberForKey:(NSString *)key;

- (NSArray *)pb_arrayForKey:(NSString *)key;
- (NSDictionary *)pb_dictionaryForKey:(NSString *)key;
- (NSString *)pb_stringForKey:(NSString *)key;
- (NSNumber *)pb_numberForKey:(NSString *)key;
- (double)pb_doubleForKey:(NSString *)key;
- (float)pb_floatForKey:(NSString *)key;
- (int)pb_intForKey:(NSString *)key;
- (unsigned int)pb_unsignedIntForKey:(NSString *)key;
- (NSInteger)pb_integerForKey:(NSString *)key;
- (NSUInteger)pb_unsignedIntegerForKey:(NSString *)key;
- (long long)pb_longLongForKey:(NSString *)key;
- (unsigned long long)pb_unsignedLongLongForKey:(NSString *)key;
- (BOOL)pb_boolForKey:(NSString *)key;
////////////////// NSDictionary Safe Accessors ///////////////

@end

@interface NSString (PBHelper)

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
- (CGSize)pb_sizeThatFitsWithFont:(UIFont *)font width:(CGFloat)width;

@end

@interface NSBundle (PBHelper)

/**
 *	@brief	get build version
 *
 *	@return	return the build version
 */
+ (NSString *)pb_buildVersion;

/**
 *	@brief	get the release version
 *
 *	@return	return the release version
 */
+ (NSString *)pb_releaseVersion;

/**
 *	@brief	get app's display name
 *
 *	@return	return app's display name
 */
+ (NSString *)pb_displayName;

@end

@interface UIDevice (PBHelper)

/**
 *  @brief platform
 *
 *  @return the device's platform eg. iPhone6s
 */
+(NSString *)pb_platform;

@end

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
- (UIImage*)pb_scaleToSize:(CGSize)dstSize DEPRECATED_MSG_ATTRIBUTE("use pb_scaleToSize: keepAspect: method instead");

/**
 *	@brief	scale image
 *
 *	@param 	dstSize 	the destnation size
 *	@param 	keep 	whether keep image's width/height scale info
 *
 *	@return	the scaled image
 */
- (UIImage*)pb_scaleToSize:(CGSize)dstSize keepAspect:(BOOL)keep;

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
+ (UIImage *)pb_iconFont:(NSString *)fontName withName:(NSString *)name withSize:(NSInteger)size withColor:(UIColor *)color;

/*!
 *  @brief generate round corner image
 *
 *  @param radius the corner's size
 *  @param size   the image's new size
 *
 *  @return the round corner image
 */
- (UIImage *)pb_drawRoundCornerWithRadius:(CGFloat)radius toSize:(CGSize)size;

@end

struct CGBWidthColor {
    CGFloat width;
    unsigned long color;
};
typedef struct CGBWidthColor CGBWidthColor;

struct CGBCornerColor {
    CGFloat radius;
    unsigned long color;
};
typedef struct CGBCornerColor CGBCornerColor;

@interface UIView (PBHelper)

- (void)pb_addRound:(CGBCornerColor)corner;

- (void)pb_addRound:(CGBCornerColor)corner withBorder:(CGBWidthColor)border;

@end
