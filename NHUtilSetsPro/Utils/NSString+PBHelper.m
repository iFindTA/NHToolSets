//
//  NSString+PBHelper.m
//  NHUtilSetsPro
//
//  Created by hu jiaju on 16/4/14.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import "NSString+PBHelper.h"
#import "PBDependency.h"

static NSString *MPHexStringFromBytes(void *bytes, NSUInteger len) {
    NSMutableString *output = [NSMutableString string];
    
    unsigned char *input = (unsigned char *)bytes;
    
    NSUInteger i;
    for (i = 0; i < len; i++)
        [output appendFormat:@"%02x", input[i]];
    return output;
}

@implementation NSString (PBHelper)

- (BOOL)pb_isOnlyNumbers {
    NSCharacterSet *regular = [NSCharacterSet decimalDigitCharacterSet];
    regular = [regular invertedSet];
    NSRange range = [self rangeOfCharacterFromSet:regular];
    return range.location == NSNotFound;
}

- (BOOL)pb_isOnlyLetters {
    NSCharacterSet *regular = [NSCharacterSet letterCharacterSet];
    regular = [regular invertedSet];
    NSRange range = [self rangeOfCharacterFromSet:regular];
    return range.location == NSNotFound;
}

- (BOOL)pb_isNumberOrLetter {
    NSCharacterSet *regular = [NSCharacterSet alphanumericCharacterSet];
    regular = [regular invertedSet];
    NSRange range = [self rangeOfCharacterFromSet:regular];
    return range.location == NSNotFound;
}

- (CGSize)pb_sizeThatFitsWithFont:(UIFont *)font width:(CGFloat)width {
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:self];
    NSDictionary *attSetting = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    NSRange range = NSMakeRange(0, self.length);
    [attString setAttributes:attSetting range:range];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    
    CGSize constraints = CGSizeMake(width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, 0), nil, constraints, nil);
    return CGSizeMake(ceilf(width), ceilf(coreTextSize.height));
}

- (NSString *)pb_zhHansTransform2Ascii {
    NSString *zhHans = [self copy];
    if (!zhHans || zhHans.length == 0) {
        return @"#";
    }
    NSMutableString *source = [zhHans mutableCopy];
    if(source && source.length>0){
        //只转换首字母
        CFRange range = CFRangeMake(0, 1);
        //转换成拼音
        CFStringTransform((__bridge CFMutableStringRef)source, &range, kCFStringTransformMandarinLatin, NO);
        //去掉声母
        CFStringTransform((__bridge CFMutableStringRef)source, &range, kCFStringTransformStripDiacritics, NO);
        
        NSString *tmpChar = source;
        tmpChar = [tmpChar substringToIndex:1];
        tmpChar = [tmpChar uppercaseString];
        int temp = [tmpChar characterAtIndex:0];
        
        if (temp < 65 || temp > 122 || (temp > 90 && temp < 97)) {
            //不合法的title
            tmpChar = @"#";
        }
        return tmpChar;
        
    }
    return @"#";
}
/*
- (NSString *)pb_SHA256 {
    const char *input = [self UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(input, (CC_LONG)strlen(input), result);
    return MPHexStringFromBytes(result, CC_SHA256_DIGEST_LENGTH);
}

- (NSString *)pb_MD5Hash {
    const char *input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    return MPHexStringFromBytes(result, CC_MD5_DIGEST_LENGTH);
}

- (NSString *)pb_SHA1Hash {
    const char *input = [self UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(input, (CC_LONG)strlen(input), result);
    return MPHexStringFromBytes(result, CC_SHA1_DIGEST_LENGTH);
}
 */

+ (NSString *)UUIDString {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    NSString *uString = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
    if(uuid) {
        CFRelease(uuid);
    }
    return uString;
}

@end
