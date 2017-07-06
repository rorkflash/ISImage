//
//  ISImageShape.h
//  movietrip
//
//  Created by Ashot Gasparyan on 6/5/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ISImageShape : NSObject

+ (UIImage *) RoundedRectWithSize:(CGSize)size withCorner:(float)corner withStrokeWith:(float)strokeWidth withColor:(UIColor *)color withStrokeColor:(UIColor *)strokeColor innerStroke:(Boolean)isInner withPadding:(int)padding;

+ (UIImage *) RoundedRectWithSize:(CGSize)size withCorner:(float)corner withStrokeWith:(float)strokeWidth withColor:(UIColor *)color withStrokeColor:(UIColor *)strokeColor innerStroke:(Boolean)isInner;

+ (UIImage *) RoundedRectWithSize:(CGSize)size withCorner:(float)corner withColor:(UIColor *)color;

+ (UIImage *) CircleWithRadius:(float)radius withStrokeWidth:(float)strokeWidth withColor:(UIColor *)color withStrokeColor:(UIColor *)strokeColor innerStroke:(Boolean)isInner withBgColor:(UIColor *)bgColor;

+ (UIImage *) CircleWithRadius:(float)radius withColor:(UIColor *)color;
+ (UIImage *) CircleWithRadius:(float)radius withColor:(UIColor *)color withBackgroundColor:(UIColor *)bgColor;
+ (UIImage *) CircleOutlineWithRadius:(float)radius withStrokeColor:(UIColor *)strokeColor withStrokeWidth:(float)strokeWidth;

@end
