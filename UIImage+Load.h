//
//  UIImage+Load.h
//  ImageCacheDemo
//
//  Created by Ashot Gasparyan on 6/28/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ISImageCache.h"
#import "ISImageCacheObject.h"

@interface UIImage (Load)

+(void)getImage:(NSString *)url withCache:(id)cache completion:(void (^)(UIImage *img, NSError *error))complete;

+(void)loadImage:(NSString *)url withCacheName:(NSString *)key withCacheCollection:(NSString *)collName
      completion:(void (^)(UIImage *img, NSError *error))complete;

+(void)loadImage:(NSString *)url withCache:(id)cache completion:(void (^)(UIImage *img, NSError *error))complete;

+(id)getCacheObject:(id)cache;

@end
