//
//  ISImageCacheObject.m
//  ImageCacheDemo
//
//  Created by Ashot Gasparyan on 7/1/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import "ISImageCacheObject.h"

@implementation ISImageCacheObject

+(id)initWithName:(NSString *)name withCollection:(NSString *)coll withStoreType:(int)type
{
    static ISImageCacheObject *_instance = nil;
    _instance = [[self alloc] initWithName:name withCollection:coll withStoreType:type];
    return _instance;
}

-(id)init
{
    return [self initWithName:nil withCollection:nil withStoreType:0];
}

-(id)initWithName:(NSString *)name withCollection:(NSString *)coll withStoreType:(int)type
{
    self = [super init];
    if (self)
    {
        self.name = name;
        self.collname = coll;
        self.storeType = type;
    }
    return self;
}

@end
