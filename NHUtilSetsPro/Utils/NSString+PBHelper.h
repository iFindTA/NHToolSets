//
//  NSString+PBHelper.h
//  NHUtilSetsPro
//
//  Created by hu jiaju on 16/4/14.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PBZHHans2AsciiType) {
    PBZHHans2AsciiTypeAll                               =   1   <<  0,//全拼 eg 曾魁：zengkui
    PBZHHans2AsciiTypeLastChar                          =   1   <<  1,//姓氏 eg 曾魁：z
    PBZHHans2AsciiTypeCharSets                          =   1   <<  2,//首字母组合 eg 曾魁：zk
};

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
 whether self match the regex
 
 @param pattern usr-custom regex
 @return result
 */
- (BOOL)pb_isMatchRegexPattern:(NSString *)pattern;

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
 transform zhHans to ascii charaters

 @return ascii chars
 */
- (NSString *)pb_zhHans2Ascii;

/**
 transform zhHans-name to ascii charaters

 @param type for result
 @return asicc char
 */
- (NSString *)pb_zhHansName2Ascii4Type:(PBZHHans2AsciiType)type;

/**
 md5 hash
 
 @return result
 */
- (NSString * _Nullable)pb_MD5Hash __attribute((deprecated(("not safe anymore!"))));

/**
 sha1 hash
 
 @return result
 */
- (NSString * _Nullable)pb_SHA1Hash __attribute((deprecated(("not safe anymore!"))));

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
