//
//  UIImage+Load.m
//  ImageCacheDemo
//
//  Created by Ashot Gasparyan on 6/28/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import "UIImage+Load.h"

@implementation UIImage (Load)

+(void)getImage:(NSString *)url withCache:(id)cache
     completion:(void (^)(UIImage *img, NSError *error))complete
{
    ISImageCacheObject *obj = [self getCacheObject:cache];
    UIImage *img = [[ISImageCache getInstance] getImage:obj.name fromCollection:obj.collname];
    
    if (img == nil) { // load image
        [self loadImage:url withCache:obj completion:^(UIImage *img, NSError *error) {
            complete(img, error);
        }];
    } else { // return from cache
        complete(img, nil);
    }
}

+(void)loadImage:(NSString *)url withCacheName:(NSString *)key withCacheCollection:(NSString *)collName
      completion:(void (^)(UIImage *img, NSError *error))complete
{
    ISImageCacheObject *obj = [ISImageCacheObject initWithName:key withCollection:collName withStoreType:ISCacheStoreTypeInDrive];
    [self loadImage:url withCache:obj completion:^(UIImage *img, NSError *error) {
        complete(img, error);
    }];
}

+(void)loadImage:(NSString *)url withCache:(id)cache completion:(void (^)(UIImage *img, NSError *error))complete
{
    // CACHE
    ISImageCacheObject *obj = [self getCacheObject:cache];
    //
    NSMutableArray *handler = [[NSMutableArray alloc] init];
    [handler addObject:[complete copy]];
    int index = (int)[handler indexOfObject:[handler lastObject]];
    // LOAD
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
        NSError *err = nil;
        UIImage *img = nil;
        
        if (data == nil) {
            if (obj.name != nil && obj.collname != nil)
                img = [[ISImageCache getInstance] getImage:obj.name fromCollection:obj.collname];
            err = [[NSError alloc] initWithDomain:NSPOSIXErrorDomain code:0 userInfo:@{@"reason":@"there is no data"}];
        } else {
            img = [UIImage imageWithData: data];
            if (obj.name != nil && obj.collname != nil)
                [[ISImageCache getInstance] setImage:img withKey:obj.name withCollection:obj.collname withStorType:obj.storeType];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            void (^_handler)(UIImage *img, NSError *error);
            _handler = [handler objectAtIndex:index];
            _handler(img, err);
            _handler = nil;
        });
    });
}

+(ISImageCacheObject *)getCacheObject:(id)cache
{
    ISImageCacheObject *obj = [[ISImageCacheObject alloc] init];
    //
    if ([cache isKindOfClass:[NSDictionary class]]) {
        obj.name = cache[@"name"] == nil ? cache[@"key"] : cache[@"name"];
        obj.collname = cache[@"coll"] == nil ? cache[@"collName"] : cache[@"coll"];
        obj.storeType = cache[@"type"] == nil ? [cache[@"storeType"] intValue] : [cache[@"type"] intValue];
    } else if ([cache isKindOfClass:[NSArray class]]) {
        obj.name = cache[0];
        obj.collname = cache[1];
        obj.storeType = [cache[2] intValue];
    } else if ([cache isKindOfClass:[ISImageCacheObject class]]) {
        obj = cache;
    }
    
    return obj;
}

@end
