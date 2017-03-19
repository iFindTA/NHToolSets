//
//  PBKits.h
//  NHUtilSetsPro
//
//  Created by hu jiaju on 16/4/14.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#ifndef PBKits_h
#define PBKits_h

#import "UIFont+PBHelper.h"
#import "UIView+PBHelper.h"
#import "UIColor+PBHelper.h"
#import "UIImage+PBHelper.h"
#import "UIDevice+PBHelper.h"

#import "NSData+PBHelper.h"
#import "NSDate+PBHelper.h"
#import "NSArray+PBHelper.h"
#import "NSString+PBHelper.h"
#import "NSBundle+PBHelper.h"
#import "NSObject+PBHelper.h"
#import "NSDictionary+PBHelper.h"

#import "PBDependency.h"

#endif /* PBKits_h */

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
#ifndef PBSCREEN_SCALE
#define PBSCREEN_SCALE  ([UIScreen mainScreen].scale)
#endif

/// animation custom duration
static const CGFloat PBANIMATE_DURATION                     =       0.25f;
/// font offset
static const CGFloat PBFONT_OFFSET                          =       2.f;

/// main / background thead
#define PBMAIN(block)  if ([NSThread isMainThread]) {\
block();\
}else{\
dispatch_async(dispatch_get_main_queue(),block);\
}
#define PBMAINDelay(x, block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(x * NSEC_PER_SEC)), dispatch_get_main_queue(), block)
#define PBBACK(block)  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define PBBACKDelay(x, block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(x * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#ifndef PBFormat
#define PBFormat(format, ...) [NSString stringWithFormat:format, ##__VA_ARGS__]
#endif

#ifndef PBLocalized
#define PBLocalized(a)        NSLocalizedString(a, nil)
#endif

#ifndef PBSysHighThan
#define PBSysHighThan(a)   ([[UIDevice currentDevice].systemVersion compare:a] != NSOrderedDescending)
#endif
#ifndef PBSysFont
#define PBSysFont(a)        [UIFont systemFontOfSize:a]
#endif
#ifndef PBSysBoldFont
#define PBSysBoldFont(a)    [UIFont boldSystemFontOfSize:a]
#endif
#ifndef PBFont
#define PBFont(n,s)         [UIFont fontWithName:n size:s]
#endif

NS_ASSUME_NONNULL_BEGIN

static inline BOOL PBIsEmpty(id _Nullable obj) {
    return obj == nil
    || (NSNull *)obj == [NSNull null]
    || ([obj respondsToSelector:@selector(length)] && [obj length] == 0)
    || ([obj respondsToSelector:@selector(count)] && [obj count] == 0);
}

static inline NSString * PBAvailableString (NSString * _Nullable obj) {
    return PBIsEmpty(obj)?@"":obj;
}

static inline NSNumber * PBAvailableNumber (NSNumber * _Nullable obj) {
    return PBIsEmpty(obj)?[NSNumber numberWithInt:0]:obj;
}

static inline NSArray * PBAvailableArray (NSArray * _Nullable obj) {
    return PBIsEmpty(obj)?[NSArray array]:obj;
}

static inline NSDictionary * PBAvailableDictionary (NSDictionary * _Nullable obj) {
    return PBIsEmpty(obj)?[NSDictionary dictionary]:obj;
}

/*
 make the last line cell's seperate line for each section display to head
 */
static inline void pb_makeCellSeperatorLineTopGrid(UITableViewCell * cell){
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:true];
    }
}
/*
 auto simple resize to adjust device screen size
 */
static inline CGFloat pb_autoResize(CGFloat size, NSString *baseMode) {
    NSDictionary *tmp = @{@"5":@"320",@"6":@"375",@"6+":@"414"};
    NSString *sizeString = [tmp objectForKey:baseMode];
    if (PBIsEmpty(sizeString)) {
        return size;
    }
    return (size*PBSCREEN_WIDTH)/sizeString.floatValue;
}

/**
 auto resize font size with base mode iPhone6

 @param fontSize for iPhone6's font size
 @return the adjust font size
 */
static inline CGFloat pb_autoFont(CGFloat fontSize) {
    //base mode for iPhone6
    CGFloat base_mod_width = 375;
    if (PBSCREEN_WIDTH > base_mod_width) {
        return fontSize + PBFONT_OFFSET;
    }
    return fontSize;
}

NS_ASSUME_NONNULL_END
