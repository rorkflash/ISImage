//
//  ISImageUtility.h
//  movietrip
//
//  Created by Ashot Gasparyan on 6/1/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ISImageUtility : NSObject

+ (UIImage *) resizeWithImage:(UIImage *)image withSize:(CGSize)newSize;
+ (UIImage *) cropWithImage:(UIImage *)image withSize:(CGSize)newSize withAlign:(NSString *)align; // depricated
+ (UIImage *) cropWithImage:(UIImage *)image withSize:(CGSize)newSize; // depricated

+ (UIImage *) cropImage:(UIImage *)image withSize:(CGSize)size fitToCrop:(Boolean)fit align:(NSString *)align;

+ (UIImage *) brightness:(UIImage *)image withValue:(float)value;
+ (UIImage *) tintImage:(UIImage *)image withColor:(UIColor *)tintColor;
+ (UIImage *) colorizeImage:(UIImage *)image withColor:(UIColor *)color;
// mask
+ (UIImage *) maskImage:(UIImage *)image withMask:(UIImage *)mask fitToMask:(Boolean)fit align:(NSString *)align;

@end
