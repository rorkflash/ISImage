//
//  ISImageShape.m
//  movietrip
//
//  Created by Ashot Gasparyan on 6/5/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import "ISImageShape.h"

@implementation ISImageShape

+ (UIImage *) RoundedRectWithSize:(CGSize)size withCorner:(float)corner withStrokeWith:(float)strokeWidth withColor:(UIColor *)color withStrokeColor:(UIColor *)strokeColor innerStroke:(Boolean)isInner withPadding:(int)padding
{
    CGRect rect;
    
    if (isInner == YES) {
        rect = CGRectMake(strokeWidth/2+padding, strokeWidth/2+padding, size.width-strokeWidth-padding*2, size.height-strokeWidth-padding*2);
    } else {
        rect = CGRectMake(padding, padding, size.width-padding*2, size.height-padding*2);
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:corner];
    if (color != nil) {
        [color setFill];
        [path fill];
    }
    if (strokeWidth > 0 && strokeColor != nil) {
        [path setLineWidth:strokeWidth];
        [strokeColor setStroke];
        [path stroke];
    }
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *) RoundedRectWithSize:(CGSize)size withCorner:(float)corner withStrokeWith:(float)strokeWidth withColor:(UIColor *)color withStrokeColor:(UIColor *)strokeColor innerStroke:(Boolean)isInner
{
    return [self RoundedRectWithSize:size withCorner:corner withStrokeWith:strokeWidth withColor:color withStrokeColor:strokeColor innerStroke:isInner withPadding:0];
}

+ (UIImage *) RoundedRectWithSize:(CGSize)size withCorner:(float)corner withColor:(UIColor *)color
{
    return [self RoundedRectWithSize:size withCorner:corner withStrokeWith:0 withColor:color withStrokeColor:nil innerStroke:NO];
}

+ (UIImage *) CircleWithRadius:(float)radius withStrokeWidth:(float)strokeWidth withColor:(UIColor *)color withStrokeColor:(UIColor *)strokeColor innerStroke:(Boolean)isInner withBgColor:(UIColor *)bgColor
{
    CGRect rect;
    
    if (isInner == YES && strokeWidth != 0 && strokeColor != nil) {
        radius = radius-strokeWidth/2;
        rect = CGRectMake(strokeWidth/2, strokeWidth/2, radius*2-strokeWidth, radius*2-strokeWidth);
    } else {
        rect = CGRectMake(0, 0, radius*2, radius*2);
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(radius*2, radius*2), NO, 0.0);
    //UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointZero radius:radius startAngle:0 endAngle:1 clockwise:YES];
    if (bgColor != nil) {
        CGRect rect1 = CGRectMake(0, 0, radius*2, radius*2);
        UIBezierPath *path1 = [UIBezierPath bezierPathWithRect:rect1];
        [bgColor setFill];
        [path1 fill];
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [color setFill];
    [path fill];
    [path setLineWidth:strokeWidth];
    if (strokeWidth != 0 && strokeColor != nil) {
        [strokeColor setStroke];
        [path stroke];
    }
    //CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *) CircleWithRadius:(float)radius withColor:(UIColor *)color
{
    return [self CircleWithRadius:radius withStrokeWidth:0 withColor:color withStrokeColor:nil innerStroke:NO withBgColor:nil];
}

+ (UIImage *) CircleWithRadius:(float)radius withColor:(UIColor *)color withBackgroundColor:(UIColor *)bgColor
{
    return [self CircleWithRadius:radius withStrokeWidth:0 withColor:color withStrokeColor:nil innerStroke:NO withBgColor:bgColor];
}

+ (UIImage *) CircleOutlineWithRadius:(float)radius withStrokeColor:(UIColor *)strokeColor withStrokeWidth:(float)strokeWidth
{
    return [self CircleWithRadius:radius withStrokeWidth:strokeWidth withColor:[UIColor clearColor] withStrokeColor:strokeColor innerStroke:YES withBgColor:nil];
}

@end
