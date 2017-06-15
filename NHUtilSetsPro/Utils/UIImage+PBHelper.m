//
//  UIImage+PBHelper.m
//  NHUtilSetsPro
//
//  Created by hu jiaju on 16/4/14.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import "UIImage+PBHelper.h"
#import "PBKits.h"
#import "PBDependency.h"

@implementation UIImage (PBHelper)

#pragma mark - Private Methods
static void pb_addRoundedRectToPath(CGContextRef contextRef, CGRect rect, float widthOfRadius, float heightOfRadius) {
    float fw, fh;
    if (widthOfRadius == 0 || heightOfRadius == 0)
    {
        CGContextAddRect(contextRef, rect);
        return;
    }
    
    CGContextSaveGState(contextRef);
    CGContextTranslateCTM(contextRef, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(contextRef, widthOfRadius, heightOfRadius);
    fw = CGRectGetWidth(rect) / widthOfRadius;
    fh = CGRectGetHeight(rect) / heightOfRadius;
    
    CGContextMoveToPoint(contextRef, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(contextRef, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(contextRef, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(contextRef, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(contextRef, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(contextRef);
    CGContextRestoreGState(contextRef);
}

- (UIImage *)pb_createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius {
    int w = size.width;
    int h = size.height;
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(contextRef);
    pb_addRoundedRectToPath(contextRef, rect, radius, radius);
    CGContextClosePath(contextRef);
    CGContextClip(contextRef);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, w, h), image.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(contextRef);
    UIImage *img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(imageMasked);
    return img;
}

+ (UIImage *)pb_imagePathed:(NSString *)name {
    return [UIImage pb_imagePathed:name extention:nil];
}

+ (UIImage *)pb_imagePathed:(NSString *)name extention:(NSString *)ext {
    
    UIImage *img = nil;
    if (PBIsEmpty(name)) {
        return img;
    }
    if (PBIsEmpty(ext)) {
        ext = @"png";
    }
    NSString *m_realName = [name copy];
    NSUInteger location = [name rangeOfString:@"@"].location;
    if (location != NSNotFound && [name length]>1 && location > 0) {
        m_realName = [name substringToIndex:location-1];
    }
    NSBundle *bundle = [NSBundle mainBundle];
    int m_scale = (int)[UIScreen mainScreen].scale;
    if (m_scale == 1) {
        img = [UIImage imageWithContentsOfFile:[bundle pathForResource:m_realName ofType:ext]];
    }else {
        NSString *__tmp_name = PBFormat(@"%@@%dx",m_realName,m_scale);
        img = [UIImage imageWithContentsOfFile:[bundle pathForResource:__tmp_name ofType:ext]];
        if (img == nil) {
            int __tmp_scale = m_scale==2?3:2;
            m_realName = PBFormat(@"%@@%dx",m_realName,__tmp_scale);
            img = [UIImage imageWithContentsOfFile:[bundle pathForResource:m_realName ofType:ext]];
        }
    }
    
    return img;
}

- (BOOL)pb_isEqualTo:(UIImage *)image {
    BOOL result = NO;
    if (image && CGSizeEqualToSize(self.size, image.size)) {
        
        CGDataProviderRef dataProvider1 = CGImageGetDataProvider(self.CGImage);
        NSData *data1 = (NSData*)CFBridgingRelease(CGDataProviderCopyData(dataProvider1));
        
        CGDataProviderRef dataProvider2 = CGImageGetDataProvider(image.CGImage);
        NSData *data2 = (NSData*)CFBridgingRelease(CGDataProviderCopyData(dataProvider2));
        
        result = [data1 isEqual:data2];
    }
    return result;
}

+ (UIImage *)pb_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)pb_imageWithText:(NSString *)text withInfo:(PBImgTextInfo)info {
    CGSize size = CGSizeMake(info.width, info.height);
    NSString *fontHex = [NSString stringWithUTF8String:info.textColor];
    NSString *defaultHex = @"#FFFFFF";
    if (PBIsEmpty(fontHex)) {
        fontHex = defaultHex;
    }
    NSString *bgHex = [NSString stringWithUTF8String:info.bgColor];
    if (PBIsEmpty(bgHex)) {
        bgHex = defaultHex;
    }
    UIColor *bgColor = [UIColor pb_colorWithHexString:bgHex];
    UIColor *textColor = [UIColor pb_colorWithHexString:fontHex];
    NSString *fontName = [NSString stringWithUTF8String:info.fontName];
    UIFont *font = [UIFont systemFontOfSize:info.fontSize];
    if (!PBIsEmpty(fontName)) {
        font = [UIFont fontWithName:fontName size:info.fontSize];
    }
    CGRect rect = (CGRect){.origin = CGPointZero, .size = size};
    //计算文本区域
    CGSize textSize = [text pb_sizeThatFitsWithFont:font width:1000];
    NSAssert(info.width >= textSize.width, @"image size must be greater than text info!!!");
    CGFloat s_x = (info.width - textSize.width) * 0.5;
    CGFloat s_y = (info.height - textSize.height) * 0.5;
    CGRect textBounds = (CGRect){.origin = CGPointMake(s_x, s_y), .size = textSize};
    NSDictionary *infoAttr = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, textColor, NSForegroundColorAttributeName, nil];
    //绘图
    //UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, false, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, [bgColor CGColor]);
    CGContextFillRect(ctx, rect);
    
    [text drawInRect:textBounds withAttributes:infoAttr];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    //return [image pb_imageWithAlpha:info.alpha];
}

- (UIColor *)pb_image2Color4Point:(CGPoint)pt {
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), pt)) {
        return nil;
    }
    
    NSInteger pointX = trunc(pt.x);
    NSInteger pointY = trunc(pt.y);
    CGImageRef cgImage = self.CGImage;
    NSUInteger width = self.size.width;
    NSUInteger height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (UIImage *)pb_blurredImage:(CGFloat)level {
    if (level < 0.0 || level > 1.0) {
        level = 0.5;
    }
    
    int boxSize = (int)(level * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (!error) {
        error = vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    }
    
    if (error) {
#ifdef DEBUG
        NSLog(@"%s error: %zd", __PRETTY_FUNCTION__, error);
#endif
        
        return self;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
}

- (UIImage *)pb_croppedBounds:(CGRect)bounds {
    
    CGFloat scale = MAX(self.scale, 1.0f);
    
    CGRect scaledBounds = CGRectMake(bounds.origin.x * scale, bounds.origin.y * scale, bounds.size.width * scale, bounds.size.height * scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], scaledBounds);
    
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:UIImageOrientationUp];
    
    CGImageRelease(imageRef);
    
    return croppedImage;
    
}

- (UIImage*)pb_scaleToSize:(CGSize)dstSize {
    CGImageRef imgRef = self.CGImage;
    // the below values are regardless of orientation : for UIImages from Camera, width>height (landscape)
    CGSize  srcSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef)); // not equivalent to self.size (which is dependant on the imageOrientation)!
    
    /* Don't resize if we already meet the required destination size. */
    if (CGSizeEqualToSize(srcSize, dstSize)) {
        return self;
    }
    
    CGFloat scaleRatio = dstSize.width / srcSize.width;
    UIImageOrientation orient = self.imageOrientation;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(srcSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(srcSize.width, srcSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, srcSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            dstSize = CGSizeMake(dstSize.height, dstSize.width);
            transform = CGAffineTransformMakeTranslation(srcSize.height, srcSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI_2);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            dstSize = CGSizeMake(dstSize.height, dstSize.width);
            transform = CGAffineTransformMakeTranslation(0.0, srcSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI_2);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            dstSize = CGSizeMake(dstSize.height, dstSize.width);
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            dstSize = CGSizeMake(dstSize.height, dstSize.width);
            transform = CGAffineTransformMakeTranslation(srcSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    /////////////////////////////////////////////////////////////////////////////
    // The actual resize: draw the image on a new context, applying a transform matrix
    UIGraphicsBeginImageContextWithOptions(dstSize, NO, self.scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (!context) {
        return nil;
    }
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -srcSize.height, 0);
    } else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -srcSize.height);
    }
    
    CGContextConcatCTM(context, transform);
    
    // we use srcSize (and not dstSize) as the size to specify is in user space (and we use the CTM to apply a scaleRatio)
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, srcSize.width, srcSize.height), imgRef);
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

- (UIImage*)pb_scaleToSize:(CGSize)dstSize keepAspect:(BOOL)keep{
    
    /* Don't resize if we already meet the required destination size. */
    if (CGSizeEqualToSize(self.size, dstSize)) {
        return self;
    }
    
    CGRect scaledImageRect = CGRectZero;
    
    CGFloat aspectWidth = dstSize.width / self.size.width;
    CGFloat aspectHeight = dstSize.height / self.size.height;
    CGFloat aspectRatio = keep?MIN(aspectWidth, aspectHeight):MAX(aspectWidth, aspectHeight);
    
    scaledImageRect.size.width = self.size.width * aspectRatio;
    scaledImageRect.size.height = self.size.height * aspectRatio;
    scaledImageRect.origin.x = (dstSize.width - scaledImageRect.size.width) / 2.0f;
    scaledImageRect.origin.y = (dstSize.height - scaledImageRect.size.height) / 2.0f;
    
    UIGraphicsBeginImageContextWithOptions( dstSize, NO, 0 );
    [self drawInRect:scaledImageRect];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (UIImage *)pb_roundImage {
    int w = self.size.width;
    int h = self.size.height;
    int dst_wh = w;
    UIImage *tmpImg = self;
    if (w != h) {
        dst_wh = MIN(w, h);
        tmpImg = [self pb_scaleToSize:CGSizeMake(dst_wh, dst_wh) keepAspect:false];
    }
    int radius = dst_wh*0.5;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef = CGBitmapContextCreate(NULL, dst_wh, dst_wh, 8, 4 * w, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, dst_wh, dst_wh);
    
    CGContextBeginPath(contextRef);
    CGContextAddArc(contextRef, CGRectGetMidX(rect), CGRectGetMidY(rect), radius, 0, 2*M_PI, false);
    CGContextClosePath(contextRef);
    CGContextClip(contextRef);
    CGContextDrawImage(contextRef, rect, tmpImg.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(contextRef);
    UIImage *img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(imageMasked);
    return img;
}

- (UIImage *)pb_roundImageWithBorderWidth:(int)bWidth withColor:(UIColor *)color {
    int w = self.size.width;
    int h = self.size.height;
    int dst_wh = w;
    UIImage *tmpImg = self;
    if (w != h) {
        dst_wh = MIN(w, h);
        tmpImg = [self pb_scaleToSize:CGSizeMake(dst_wh, dst_wh) keepAspect:false];
    }
    int radius = dst_wh*0.5;
    if (bWidth >= radius || bWidth <= 0) {
        return [self pb_roundImage];
    }
    color = ((color !=nil?color:[UIColor whiteColor]));
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef = CGBitmapContextCreate(NULL, dst_wh, dst_wh, 8, 4 * w, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, dst_wh, dst_wh);
    
    CGContextBeginPath(contextRef);
    CGContextAddArc(contextRef, CGRectGetMidX(rect), CGRectGetMidY(rect), radius, 0, 2*M_PI, false);
    CGContextClosePath(contextRef);
    CGContextClip(contextRef);
    /// draw layer
    CGContextSetFillColorWithColor(contextRef, color.CGColor);
    CGContextFillRect(contextRef, rect);
    rect = CGRectInset(rect, bWidth, bWidth);
    CGContextAddArc(contextRef, CGRectGetMidX(rect), CGRectGetMidY(rect), radius-bWidth, 0, 2*M_PI, false);
    CGContextClosePath(contextRef);
    CGContextClip(contextRef);
    CGContextDrawImage(contextRef, rect, tmpImg.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(contextRef);
    UIImage *img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(imageMasked);
    return img;
}

- (UIImage *)pb_roundCornerWithRadius:(int)radius {
    int w = self.size.width;
    int h = self.size.height;
    int dst_wh = w;
    if (w != h) {
        dst_wh = MIN(w, h);
    }
    if (radius > dst_wh || radius <= 0) {
        return self;
    }
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    UIBezierPath *dstPath = [self pb_pathForSize:rect radius:radius];
    CGContextBeginPath(contextRef);
    CGContextAddPath(contextRef, dstPath.CGPath);
    CGContextClosePath(contextRef);
    CGContextClip(contextRef);
    CGContextDrawImage(contextRef, rect, self.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(contextRef);
    UIImage *img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(imageMasked);
    return img;
}

- (UIImage *)pb_roundCornerWithRadius:(int)radius withBorderWidth:(int)bWidth withBorderColor:(UIColor *)bColor {
    int w = self.size.width;
    int h = self.size.height;
    int dst_wh = w;
    if (w != h) {
        dst_wh = MIN(w, h);
    }
    if (radius + bWidth > dst_wh || radius <= 0 || bWidth <= 0) {
        return self;
    }
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    UIBezierPath *dstPath = [self pb_pathForSize:rect radius:radius];
    /// begin graphics
    CGContextBeginPath(contextRef);
    CGContextAddPath(contextRef, dstPath.CGPath);
    CGContextClosePath(contextRef);
    CGContextClip(contextRef);
    /// draw layer
    bColor = ((bColor != nil)?bColor:[UIColor whiteColor]);
    CGContextSetFillColorWithColor(contextRef, bColor.CGColor);
    CGContextFillRect(contextRef, rect);
    /// draw image
    rect = CGRectInset(rect, bWidth, bWidth);
    dstPath = [self pb_pathForSize:rect radius:radius];
    CGContextAddPath(contextRef, dstPath.CGPath);
    CGContextClosePath(contextRef);
    CGContextClip(contextRef);
    CGContextDrawImage(contextRef, rect, self.CGImage);
    /// end draw image
    CGImageRef imageMasked = CGBitmapContextCreateImage(contextRef);
    UIImage *img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(imageMasked);
    return img;
}

- (UIBezierPath *)pb_pathForSize:(CGRect)rect radius:(int)radius {
    
    CGPoint origin = rect.origin;
    CGSize size = rect.size;
    UIBezierPath *path = [UIBezierPath bezierPath];
    /// left top points
    CGPoint lt_c = CGPointMake(origin.x, origin.y);
    CGPoint lt_r = CGPointMake(origin.x+radius, origin.y);
    CGPoint lt_l = CGPointMake(origin.x, origin.y+radius);
    /// right top points
    CGPoint rt_c = CGPointMake(origin.x+size.width, origin.y);
    CGPoint rt_r = CGPointMake(origin.x+size.width, origin.y+radius);
    CGPoint rt_l = CGPointMake(origin.x+size.width-radius, origin.y);
    /// left bottom points
    CGPoint lb_c = CGPointMake(origin.x, origin.y+size.height);
    CGPoint lb_r = CGPointMake(origin.x+radius, origin.y+size.height);
    CGPoint lb_l = CGPointMake(origin.x, origin.y+size.height-radius);
    /// right bottom points
    CGPoint rb_c = CGPointMake(origin.x+size.width, origin.y+size.height);
    CGPoint rb_r = CGPointMake(origin.x+size.width, origin.y+size.height-radius);
    CGPoint rb_l = CGPointMake(origin.x+size.width-radius, origin.y+size.height);
    
    /// add points lines to path
    [path moveToPoint:lt_r];
    [path addLineToPoint:rt_l];
    [path addQuadCurveToPoint:rt_r controlPoint:rt_c];
    [path addLineToPoint:rb_r];
    [path addQuadCurveToPoint:rb_l controlPoint:rb_c];
    [path addLineToPoint:lb_r];
    [path addQuadCurveToPoint:lb_l controlPoint:lb_c];
    [path addLineToPoint:lt_l];
    [path addQuadCurveToPoint:lt_r controlPoint:lt_c];
    [path closePath];
    
    return path;
}

- (UIImage *)pb_imageWithAlpha:(CGFloat)alpha {
    CGSize size = self.size;
    CGFloat scale = self.scale;
    UIGraphicsBeginImageContextWithOptions(size, false, scale);
    [self drawAtPoint:CGPointZero blendMode:kCGBlendModeNormal alpha:alpha];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
}

- (UIImage *)pb_darkColor:(UIColor *)color lightLevel:(CGFloat)level {
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, false, self.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self drawInRect:imageRect];
    
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextSetAlpha(ctx, level);
    CGContextSetBlendMode(ctx, kCGBlendModeSourceAtop);
    CGContextFillRect(ctx, imageRect);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *darkImage = [UIImage imageWithCGImage:imageRef
                                             scale:self.scale
                                       orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    UIGraphicsEndImageContext();
    
    return darkImage;
}

+ (UIImage *)pb_iconFont:(NSString *)fontName withName:(NSString *)name withSize:(NSInteger)size withColor:(UIColor *)color {
    if (size <= 0 || PBIsEmpty(name)) {
        return nil;
    }
    CGFloat scale = [UIScreen mainScreen].scale;
    fontName = (fontName != nil ? fontName:@"iconfont");
    UIFont *font = [UIFont fontWithName:fontName size:size*scale];
    if (font == nil) {
        return nil;
    }
    color = (color == nil ? [UIColor whiteColor]:color);
    
    CGFloat realSize = size * scale;
    //    UIGraphicsBeginImageContext(CGSizeMake(realSize, realSize));
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(realSize, realSize), false, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if ([name respondsToSelector:@selector(drawAtPoint:withAttributes:)]) {
        [name drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName: color}];
    } else {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CGContextSetFillColorWithColor(context, color.CGColor);
        [name drawAtPoint:CGPointMake(0, 0) withFont:font];
#pragma clang pop
    }
    
    UIImage *image = [UIImage imageWithCGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage scale:scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)pb_drawRoundCornerWithRadius:(CGFloat)radius toSize:(CGSize)size {
    CGRect bounds = CGRectZero;
    bounds.size = size;
    
    UIGraphicsBeginImageContextWithOptions(bounds.size, false, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx, path.CGPath);
    CGContextClosePath(ctx);
    CGContextClip(ctx);
    [self drawInRect:bounds];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}

#pragma mark - 生成条形码以及二维码

// 参考文档
// https://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html

+ (UIImage *)pb_generateQRCode:(NSString *)code size:(CGSize)size {
    
    // 生成二维码图片
    CIImage *qrcodeImage;
    NSData *data = [code dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    qrcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = size.width / qrcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = size.height / qrcodeImage.extent.size.height;
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}

+ (UIImage *)pb_generateBarCode:(NSString *)code size:(CGSize)size {
    // 生成条形码图片
    CIImage *barcodeImage;
    NSData *data = [code dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    barcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = size.width / barcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = size.height / barcodeImage.extent.size.height;
    CIImage *transformedImage = [barcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}

- (UIImage *)pb_mergeImage:(UIImage *)icon size:(CGSize)size {
    if (!icon) {
        return self;
    }
    CGFloat t_corner = 4;
    CGSize t_size = self.size;
    CGSize s_size = icon.size;
    CGRect infoRect ;
    infoRect.origin = CGPointZero;
    infoRect.size = t_size;
    CGRect iconRect ;
    iconRect.origin = CGPointMake((t_size.width-size.width)*0.5, (t_size.height-size.height)*0.5);
    iconRect.size = size;
    icon = [self pb_createRoundedRectImage:icon withSize:s_size withRadius:t_corner];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:iconRect cornerRadius:t_corner];
    iconRect = CGRectInset(iconRect, 3, 3);
    UIGraphicsBeginImageContextWithOptions(t_size, true, 1.0);
    
    [self drawInRect:infoRect];
    
    [[UIColor whiteColor] setFill];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddPath(ctx, path.CGPath);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    [icon drawInRect:iconRect];
    
    UIImage *dstImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return dstImg;
}

#pragma mark -- assemble group chat avatar

+ (UIImage *)pb_assembleGroupAvatarWithUsrAvatars:(NSArray *)avatars forAvatarSize:(CGSize)size forBgColor:(UIColor *)bgColor {
    return [[UIImage new] mergeAvatarsWithMemAvatars:avatars size:size seperateWidth:2 backgroundColor:bgColor];
}

- (UIImage *)mergeAvatarsWithMemAvatars:(NSArray *)avatars size:(CGSize)size seperateWidth:(CGFloat)seperateWidth backgroundColor:(UIColor *)backgroundColor {
    UIImage *image;
    
    //    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, 2);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    //背景颜色
    if(backgroundColor != nil) {
        CGContextSetFillColorWithColor(contextRef, backgroundColor.CGColor);
        CGContextAddRect(contextRef, CGRectMake(0, 0, size.width, size.height));
        CGContextDrawPath(contextRef, kCGPathFill);
    }
    
    UIImage *subImg;
    CGSize subImgSize = [self getSubImgSizeWithImageArray:avatars size:size seperateWidth:seperateWidth];
    NSArray *pointArr = [self getCGPointWithImageArray:avatars withSize:size subImgSize:subImgSize seperateWidth:seperateWidth];
    
    for (NSInteger i = 0;i < avatars.count; i ++) {
        subImg = [avatars objectAtIndex:i];
        CGRect rect = CGRectZero;
        rect.origin = [[pointArr objectAtIndex:i] CGPointValue];
        rect.size = subImgSize;
        [subImg drawInRect:rect];
    }
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (CGSize)getSubImgSizeWithImageArray:(NSArray *)imgArr size:(CGSize)size seperateWidth:(CGFloat)seperateWidth {
    CGSize subImgSize;
    if (imgArr.count <= 4) {
        subImgSize = [self getSubImgSizeUsingSudoku4WithSize:size seperateWidth:seperateWidth];
    } else {
        subImgSize = [self getSubImgSizeUsingSudoku9WithSize:size seperateWidth:seperateWidth];
    }
    return subImgSize;
}

//获取四宫格子图片大小
- (CGSize)getSubImgSizeUsingSudoku4WithSize:(CGSize)size seperateWidth:(CGFloat)seperateWidth {
    CGSize s4 = CGSizeMake((size.width - (seperateWidth*3))/2, (size.height - (seperateWidth*3))/2);
    return s4;
}

//获取九宫格子图片的大小
- (CGSize)getSubImgSizeUsingSudoku9WithSize:(CGSize)size seperateWidth:(CGFloat)seperateWidth {
    CGSize s9 = CGSizeMake((size.width - (seperateWidth*4))/3, (size.height - seperateWidth*4)/3);
    return s9;
}

- (NSArray *)getCGPointWithImageArray:(NSArray *)imageArray withSize:(CGSize)size subImgSize:(CGSize)subImgSize seperateWidth:(CGFloat)seperateWidth {
    NSArray *arr;
    if (imageArray.count == 1) {
        arr = [self getCGPointArrayWithOneSudoWithSize:size subImgSize:subImgSize seperateWidth:seperateWidth];
    } else if(imageArray.count == 2) {
        arr = [self getCGPointArrayWithTwoSudoWithSize:size subImgSize:subImgSize seperateWidth:seperateWidth];
    } else if(imageArray.count == 3) {
        arr = [self getCGPointArrayWithThreeSudoWithSize:size subImgSize:subImgSize seperateWidth:seperateWidth];
    } else if(imageArray.count == 4) {
        arr = [self getCGPointArrayWithFourSudoWithSize:size subImgSize:subImgSize seperateWidth:seperateWidth];
    } else if(imageArray.count == 5) {
        arr = [self getCGPointArrayWithFiveSudoWithSize:size subImgSize:subImgSize seperateWidth:seperateWidth];
    } else if(imageArray.count >= 6) {
        NSInteger imageCount = imageArray.count;
        if(imageCount > 9) {
            imageCount = 9;
        }
        arr = [self getCGPointArrayWithNineSudoWithSize:size subImgSize:subImgSize imageCount:imageCount seperateWidth:seperateWidth];
    }
    return arr;
}

//1图片的布局
- (NSArray *)getCGPointArrayWithOneSudoWithSize:(CGSize)size subImgSize:(CGSize)subImgSize seperateWidth:(CGFloat)seperateWidth {
    CGPoint point1 = CGPointMake((size.width-subImgSize.width)/2, (size.height-subImgSize.height)/2);
    return @[[NSValue valueWithCGPoint:point1]];
}

//2张图片的布局
- (NSArray *)getCGPointArrayWithTwoSudoWithSize:(CGSize)size subImgSize:(CGSize)subImgSize seperateWidth:(CGFloat)seperateWidth {
    CGPoint point1 = CGPointMake(seperateWidth, (size.height-subImgSize.height)/2);
    CGPoint point2 = CGPointMake(subImgSize.width + seperateWidth*2, (size.height-subImgSize.height)/2);
    
    return @[[NSValue valueWithCGPoint:point1], [NSValue valueWithCGPoint:point2]];
}

//3图布局
- (NSArray *)getCGPointArrayWithThreeSudoWithSize:(CGSize)size subImgSize:(CGSize)subImgSize seperateWidth:(CGFloat)seperateWidth {
    CGPoint point1 = CGPointMake((size.width-subImgSize.width)/2, seperateWidth);
    CGPoint point2 = CGPointMake(seperateWidth, subImgSize.height + seperateWidth*2);
    CGPoint point3 = CGPointMake(subImgSize.width + seperateWidth*2, subImgSize.height + seperateWidth*2);
    
    return @[[NSValue valueWithCGPoint:point1], [NSValue valueWithCGPoint:point2], [NSValue valueWithCGPoint:point3]];
}

//4图布局
- (NSArray *)getCGPointArrayWithFourSudoWithSize:(CGSize)size subImgSize:(CGSize)subImgSize seperateWidth:(CGFloat)seperateWidth {
    CGPoint point1 = CGPointMake(seperateWidth, seperateWidth);
    CGPoint point2 = CGPointMake(subImgSize.width + seperateWidth*2, seperateWidth);
    CGPoint point3 = CGPointMake(seperateWidth, subImgSize.height + seperateWidth*2);
    CGPoint point4 = CGPointMake(subImgSize.width +seperateWidth*2, subImgSize.height + seperateWidth*2);
    
    return @[[NSValue valueWithCGPoint:point1], [NSValue valueWithCGPoint:point2], [NSValue valueWithCGPoint:point3], [NSValue valueWithCGPoint:point4]];
}

//5图布局
- (NSArray *)getCGPointArrayWithFiveSudoWithSize:(CGSize)size subImgSize:(CGSize)subImgSize seperateWidth:(CGFloat)seperateWidth {
    CGPoint point1 = CGPointMake((size.width - subImgSize.width*2)/2, (size.height - subImgSize.height*2)/2);
    CGPoint point2 = CGPointMake((size.width - subImgSize.width*2)/2 + subImgSize.width + seperateWidth, (size.height - subImgSize.height*2)/2);
    CGPoint point3 = CGPointMake(seperateWidth, point1.y + subImgSize.height + seperateWidth);
    CGPoint point4 = CGPointMake(subImgSize.height + seperateWidth*2, point1.y + subImgSize.height + seperateWidth);
    CGPoint point5 = CGPointMake(subImgSize.height*2 + (seperateWidth * 3), point1.y + subImgSize.height + seperateWidth);
    
    return @[[NSValue valueWithCGPoint:point1], [NSValue valueWithCGPoint:point2], [NSValue valueWithCGPoint:point3], [NSValue valueWithCGPoint:point4], [NSValue valueWithCGPoint:point5]];
}

//6-9宫格布局
- (NSArray *)getCGPointArrayWithNineSudoWithSize:(CGSize)size subImgSize:(CGSize)subImgSize imageCount:(NSInteger)imageCount seperateWidth:(CGFloat)seperateWidth {
    NSMutableArray *arr = [NSMutableArray array];
    
    NSInteger count = imageCount;
    NSInteger columnPerRow = 3;
    NSInteger rowPerColumn = 3;
    
    NSInteger columnIndex = 0;
    NSInteger rowIndex = 0;
    NSInteger allRowCount = 0;
    for (NSInteger i = 0; i < count; i ++) {
        
        columnIndex = i % columnPerRow;
        rowIndex = i / columnPerRow;
        
        if (count % columnPerRow == 0) {
            allRowCount = count / columnPerRow;
        } else {
            allRowCount = count / columnPerRow + 1;
        }
        
        CGPoint point = CGPointMake(columnIndex * subImgSize.width + (seperateWidth*(columnIndex + 1)), ((rowPerColumn - allRowCount)*subImgSize.height)/2 + (rowIndex * subImgSize.height) + (seperateWidth *(rowIndex+1)));
        
        [arr addObject:[NSValue valueWithCGPoint:point]];
    }
    
    return arr;
}

@end
