//
//  NSData+PBHelper.h
//  NHUtilSetsPro
//
//  Created by nanhujiaju on 2017/3/19.
//  Copyright © 2017年 hu jiaju. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (PBHelper)

/**
 encrypt data with AES-256 method

 @param key for AES-256
 @param error for encrypt
 @return result
 */
- (NSData *)pb_encryptedAES256DataUsingKey:(NSString *)key withError:(NSError  * _Nullable *)error;

/**
 decrypt data with AES-256 method

 @param key for AES-256
 @param error for decrypt
 @return result
 */
- (NSData *)pb_decryptedAES256DataUsingKey:(NSString *)key withError:(NSError  * _Nullable *)error;

@end

NS_ASSUME_NONNULL_END
