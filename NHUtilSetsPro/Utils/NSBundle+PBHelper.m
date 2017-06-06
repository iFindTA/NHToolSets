//
//  NSBundle+PBHelper.m
//  NHUtilSetsPro
//
//  Created by hu jiaju on 16/4/14.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import "NSBundle+PBHelper.h"
#import "PBKits.h"
#import "NSDictionary+PBHelper.h"

@implementation NSBundle (PBHelper)

+ (NSString *)pb_buildVersion {
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    return [bundleInfo pb_stringForKey:(NSString *)kCFBundleVersionKey];
}

+ (NSString *)pb_releaseVersion {
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    return [bundleInfo pb_stringForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)pb_displayName {
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *m_name = [bundleInfo pb_stringForKey:@"CFBundleDisplayName"];
    if (PBIsEmpty(m_name)) {
        m_name = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey];
    }
    return m_name;
}

+ (id _Nullable)pb_mainBundle4Key:(NSString *)key {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:key];
}

+ (id _Nullable)pb_mainBundle4key:(NSString *)key atPlist:(NSString *)pName {
    NSString *fileName = pName.copy;
    NSRange sepRange = [fileName rangeOfString:@"."];
    if (sepRange.location != NSNotFound) {
        fileName = [fileName substringToIndex:sepRange.location];
    }
    NSString *fPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSDictionary *infoMap = [NSDictionary dictionaryWithContentsOfFile:fPath];
    return [infoMap objectForKey:key];
}

@end
