//
//  NSString+PBHelper.h
//  NHUtilSetsPro
//
//  Created by hu jiaju on 16/4/14.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

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

/**
 *  @brief transform zhHans to ascii charaters
 *
 *  @param zhHans origin hans
 *
 *  @return asicc char
 */
- (NSString *)pb_zhHansTransform2Ascii;

/**
 md5 hash
 
 @return result
 */
- (NSString * _Nullable)pb_MD5Hash;

/**
 sha1 hash
 
 @return result
 */
- (NSString * _Nullable)pb_SHA1Hash;

/**
 sha256 mechanism for string

 @return result
 */
- (NSString * _Nullable)pb_SHA256 /*NS_DEPRECATED_IOS(7_0, 8_0, "pod lint with dylib error!")*/;

/**
 generate uuid string

 @return result
 */
+ (NSString *)UUIDString;

/**
 URL encode function

 @return encoded url
 */
- (NSString *)pb_urlEncoding;

/**
 generate random string

 @param length string's length
 @return the random string, null for len == 0
 */
+ (NSString * _Nullable)pb_randomString4Length:(NSUInteger)length;

NS_ASSUME_NONNULL_END

@end
