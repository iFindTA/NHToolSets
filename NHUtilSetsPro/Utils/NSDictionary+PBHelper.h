//
//  NSDictionary+PBHelper.h
//  NHUtilSetsPro
//
//  Created by hu jiaju on 16/4/14.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (PBHelper)

/**
 *	@brief	Judging method
 *
 *	@return	whether the map is empty
 */
- (BOOL)pb_isEmpty NS_DEPRECATED_IOS(2_0, 7_0, "PBIsEmpty()");

///////////////// NSDictionary Safe Accessors ///////////////
/// home page: https://github.com/allenhsu/NSDictionary-Accessors

- (BOOL)isArrayForKey:(NSString *)key;
- (BOOL)isDictionaryForKey:(NSString *)key;
- (BOOL)isStringForKey:(NSString *)key;
- (BOOL)isNumberForKey:(NSString *)key;

- (NSArray * _Nullable )pb_arrayForKey:(NSString *)key;
- (NSDictionary * _Nullable )pb_dictionaryForKey:(NSString *)key;
- (NSString * _Nullable )pb_stringForKey:(NSString *)key;
- (NSNumber * _Nullable )pb_numberForKey:(NSString *)key;
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

NS_ASSUME_NONNULL_END

@end
