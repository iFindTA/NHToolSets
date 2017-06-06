//
//  NSBundle+PBHelper.h
//  NHUtilSetsPro
//
//  Created by hu jiaju on 16/4/14.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

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

/**
 objectForKey: for infoDictinary in mainBundle

 @param key for mainBundle
 @return result
 */
+ (id _Nullable)pb_mainBundle4Key:(NSString *)key;

/**
 objectForKey: in main bundle

 @param key for main bundle
 @param pName name of plist
 @return result
 */
+ (id _Nullable)pb_mainBundle4key:(NSString *)key atPlist:(NSString *)pName;

NS_ASSUME_NONNULL_END

@end
