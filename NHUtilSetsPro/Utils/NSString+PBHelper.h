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
 sha256 mechanism for string

 @return result
 */
- (NSString *)pb_SHA256;

/**
 md5 hash

 @return result
 */
- (NSString *)pb_MD5Hash;

/**
 sha1 hash

 @return result
 */
- (NSString *)pb_SHA1Hash;

NS_ASSUME_NONNULL_END

@end
