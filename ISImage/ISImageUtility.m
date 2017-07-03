//
//  ISImageUtility.m
//  movietrip
//
//  Created by Ashot Gasparyan on 6/1/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import "ISImageUtility.h"

@implementation ISImageUtility

+ (UIImage *)resizeWithImage:(UIImage *)image withSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/** depricated */
+ (UIImage *)cropWithImage:(UIImage *)image withSize:(CGSize)newSize withAlign:(NSString *)align
{
    CGSize rSize = CGSizeMake(0, 0);
    
    if (image.size.height/newSize.height > image.size.width/newSize.width) {
        rSize.width = newSize.width;
        rSize.height = (newSize.width/image.size.width)*image.size.height;
    } else {
        rSize.height = newSize.height;
        rSize.width = (newSize.height/image.size.height)*image.size.width;
    }
    
    UIImage *rImage = [self resizeWithImage:image withSize:rSize];
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    if ([align isEqual:@"center"]) {
        [rImage drawAtPoint:CGPointMake((newSize.width-rImage.size.width)/2, (newSize.height-rImage.size.height)/2)];
    } else {
        [rImage drawAtPoint:CGPointMake(0, 0)];
    }
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)cropWithImage:(UIImage *)image withSize:(CGSize)newSize
{
    return [self cropWithImage:image withSize:newSize withAlign:@"center"];
}

+ (UIImage *)cropImage:(UIImage *)image withSize:(CGSize)newSize fitToCrop:(Boolean)fit align:(NSString *)align
{
    UIImage *img;
    
    if (fit == true) {
        CGSize rSize = CGSizeMake(0, 0);
        if (image.size.height/newSize.height > image.size.width/newSize.width) {
            rSize.width = newSize.width;
            rSize.height = (newSize.width/image.size.width)*image.size.height;
        } else {
            rSize.height = newSize.height;
            rSize.width = (newSize.height/image.size.height)*image.size.width;
        }
        img = [self resizeWithImage:image withSize:rSize];
    } else {
        img = image;
    }
    
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0.0);
    if ([align isEqual:@"center"]) {
        [img drawAtPoint:CGPointMake((newSize.width-img.size.width)/2, (newSize.height-img.size.height)/2)];
    } else {
        [img drawAtPoint:CGPointMake(0, 0)];
    }
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(UIImage *)brightness:(UIImage *)image withValue:(float)value
{
    CGFloat brightness = value;
    
    //UIGraphicsBeginImageContext(image.size);
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Original image
    [image drawInRect:imageRect];
    
    // Brightness overlay
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:brightness].CGColor);
    CGContextAddRect(context, imageRect);
    CGContextFillPath(context);
    
    UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

+(UIImage *)tintImage:(UIImage *)image withColor:(UIColor *)tintColor
{
    UIGraphicsBeginImageContextWithOptions (image.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // draw black background to preserve color of transparent pixels
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    [[UIColor blackColor] setFill];
    CGContextFillRect(context, rect);
    
    // tint image (loosing alpha) - the luminosity of the original image is preserved
    CGContextSetBlendMode(context, kCGBlendModeColor);
    [tintColor setFill];
    CGContextFillRect(context, rect);
    
    // draw original image
    //CGContextSetBlendMode(context, kCGBlendModeSaturation);
    //CGContextDrawImage(context, rect, image.CGImage);
    
    // mask by alpha values of original image
    CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
    CGContextDrawImage(context, rect, image.CGImage);
    
    
    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return coloredImage;
}

+ (UIImage *)colorizeImage:(UIImage *)image withColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -area.size.height);
    
    CGContextSaveGState(context);
    CGContextClipToMask(context, area, image.CGImage);
    
    [color set];
    CGContextFillRect(context, area);
    
    CGContextRestoreGState(context);
    
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
    
    CGContextDrawImage(context, area, image.CGImage);
    
    UIImage *colorizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return colorizedImage;
}

+ (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)maskImage fitToMask:(Boolean)fit align:(NSString *)align
{
    CGImageRef maskRef = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, true);
    
    UIImage *newImage = [self cropImage:image withSize:maskImage.size fitToCrop:fit align:align];
    
    CGImageRef maskedImageRef = CGImageCreateWithMask([newImage CGImage], mask);
    UIImage *maskedImage = [UIImage imageWithCGImage:maskedImageRef scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
    
    CGImageRelease(mask);
    CGImageRelease(maskedImageRef);
    
    // returns new image with mask applied
    return maskedImage;
}

@end
