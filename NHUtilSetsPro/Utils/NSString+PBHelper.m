//
//  NSString+PBHelper.m
//  NHUtilSetsPro
//
//  Created by hu jiaju on 16/4/14.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import "NSString+PBHelper.h"
#import "PBDependency.h"
#import <CommonCrypto/CommonDigest.h>

static NSString *PBHexStringFromBytes(void *bytes, NSUInteger len) {
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

- (BOOL)pb_isMatchRegexPattern:(NSString *)pattern {
    BOOL ret = false;
    if (self.length == 0 || pattern.length == 0) {
        return ret;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:self];
}

- (CGSize)pb_sizeThatFitsWithFont:(UIFont *)font width:(CGFloat)width {
    /*
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:self];
    NSDictionary *attSetting = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    NSRange range = NSMakeRange(0, self.length);
    [attString setAttributes:attSetting range:range];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    
    CGSize constraints = CGSizeMake(width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, 0), nil, constraints, nil);
     */
    
    NSString *displayInfo = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:style};
    //CGFloat displayWidth = ceil(pb_autoResize(ChatContentW, @"6"));
    CGSize realSize = [displayInfo boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    return CGSizeMake(ceilf(realSize.width), ceilf(realSize.height));
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

- (NSDictionary <NSString *, NSArray *>*)multicastFamilyMaps {
    static NSMutableDictionary *maps = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (maps == nil) {
            maps = [NSMutableDictionary dictionaryWithObjectsAndKeys
             :@[@"po",@"fan"],@"繁"
             ,@[@"ou",@"qu"],@"区"
             ,@[@"qiu",@"chou"],@"仇"
             ,@[@"chong",@"zhong"],@"种"
             ,@[@"shan",@"dan"],@"单"
             ,@[@"xie",@"jie"],@"解"
             ,@[@"zha",@"cha"],@"查"
             ,@[@"zeng",@"ceng"],@"曾"
             ,@[@"yue",@"le"],@"乐"
             ,@[@"chong",@"zhong"],@"重"
             ,@[@"piao",@"pu"],@"朴"
             ,@[@"miao",@"mou"],@"缪"
             ,@[@"zhai",@"di"],@"翟"
             ,@[@"she",@"zhe"],@"折"
             ,@[@"he",@"hei"],@"黑"
             ,@[@"ge",@"gai"],@"盖"
             ,@[@"shen",@"chen"],@"沈"
             ,@[@"zhang sun",@"chang sun"],@"长孙"
             ,@[@"yu chi",@"wei chi"],@"尉迟"
             ,@[@"mo qi",@"wan qi"],@"万俟"
             ,nil];
        }
    });
    return maps.copy;
}

- (NSString *)zhHans2Ascii {
    NSString *zhHans = [self copy];
    NSUInteger char_len = zhHans.length;
//    if (!zhHans || char_len == 0) {
//        return @"#";
//    }
    NSMutableString *source = [zhHans mutableCopy];
    if(source && source.length>0){
        //只转换首字母
        CFRange range = CFRangeMake(0, char_len);
        //转换成拼音
        CFStringTransform((__bridge CFMutableStringRef)source, &range, kCFStringTransformMandarinLatin, NO);
        //去掉声母
        CFStringTransform((__bridge CFMutableStringRef)source, &range, kCFStringTransformStripDiacritics, NO);
        
        return source.copy;
        
    }
    return @"#";
}

- (NSString *)pb_zhHans2Ascii {
    NSString *zhHans = [[self stringByReplacingOccurrencesOfString:@" " withString:@""] copy];
    NSUInteger char_len = zhHans.length;
    if (!zhHans || char_len == 0) {
        return @"#";
    }
    NSString *ascii = [zhHans zhHans2Ascii];
    return ascii;
}

- (NSString *)pb_zhHansName2Ascii4Type:(PBZHHans2AsciiType)type {
    
    NSString *zhHans = [[self stringByReplacingOccurrencesOfString:@" " withString:@""] copy];
    NSUInteger char_len = zhHans.length;
    if (!zhHans || char_len == 0) {
        return @"#";
    }
    NSString *ascii = [zhHans zhHans2Ascii];
    NSString *family_char_en0 = [zhHans substringToIndex:1];
    NSString *family_char_en1 = nil;
    if (zhHans.length >= 3) {
        family_char_en1 = [zhHans substringToIndex:2];
    }
    //处理多音字
    NSMutableString *source = [ascii mutableCopy];
    NSArray <NSString *>*familyMaps = [self.multicastFamilyMaps allKeys];
    __block NSString *dest_key = nil;
    [familyMaps enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange charRange_en0 = [obj rangeOfString:family_char_en0];
        if (charRange_en0.location != NSNotFound) {
            dest_key = obj.copy;
            *stop = true;
        } else if (family_char_en1.length != 0 && [obj rangeOfString:family_char_en1].location!= NSNotFound) {
            dest_key = obj.copy;
            *stop = true;
        }
    }];
    if (dest_key != nil) {
        //找到姓名多音字
        NSArray *res = [self.multicastFamilyMaps objectForKey:dest_key];
        NSString *dest_char = [res firstObject];NSString *last_char = [res lastObject];
        NSString *dest_source = [source stringByReplacingOccurrencesOfString:last_char withString:dest_char];
        return dest_source;
    }
    __block NSMutableString *dest = nil;
    if (type & PBZHHans2AsciiTypeAll) {
        dest = [source stringByReplacingOccurrencesOfString:@" " withString:@""].mutableCopy;
    } else if (type & PBZHHans2AsciiTypeLastChar) {
        dest = [source substringToIndex:1].mutableCopy;
    } else if (type & PBZHHans2AsciiTypeCharSets) {
        dest = [NSMutableString stringWithCapacity:0];
        NSArray <NSString *>* tmps = [source componentsSeparatedByString:@" "];
        [tmps enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [dest appendString:[obj substringToIndex:1]];
        }];
    }
    if (dest.length == 0) {
        dest = [source mutableCopy];
    }
    return dest.copy;
}

- (NSString *)pb_MD5Hash {
    if (self.length == 0) {
        return self;
    }
    const char *input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    return PBHexStringFromBytes(result, CC_MD5_DIGEST_LENGTH);
}

- (NSString *)pb_SHA1Hash {
    if (self.length == 0) {
        return self;
    }
    const char *input = [self UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(input, (CC_LONG)strlen(input), result);
    return PBHexStringFromBytes(result, CC_SHA1_DIGEST_LENGTH);
}

- (NSString *)pb_SHA256 {
    if (self.length == 0) {
        return self;
    }
    const char *input = [self UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(input, (CC_LONG)strlen(input), result);
    return PBHexStringFromBytes(result, CC_SHA256_DIGEST_LENGTH);
}

+ (NSString *)UUIDString {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    NSString *uString = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
    if(uuid) {
        CFRelease(uuid);
    }
    return uString;
}

- (NSString *)pb_urlEncoding{
    if (self.length == 0) {
        return self;
    }
   //NSString *URLencodeString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)urlString, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    NSCharacterSet *sets = [[NSCharacterSet characterSetWithCharactersInString:@":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"] invertedSet];
    NSString *URLencodeString = [self stringByAddingPercentEncodingWithAllowedCharacters:sets];
    return URLencodeString;
}

+ (NSString *)pb_randomString4Length:(NSUInteger)length{
    if (length<=0) {
        return nil;
    }
    NSString *sourceString = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-*_[]<>@!#:";
    NSMutableString *result = [[NSMutableString alloc] init] ;
    srand((unsigned)time(0));
    for (int i = 0; i < length; i++){
        unsigned index = rand() % [sourceString length];
        NSString *s = [sourceString substringWithRange:NSMakeRange(index, 1)];
        [result appendString:s];
    }
    return result;
}

@end
