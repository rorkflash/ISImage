//
//  ISImageCacheCollection.m
//  movietrip
//
//  Created by Ashot Gasparyan on 6/1/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import "ISImageCacheCollection.h"

@implementation ISImageCacheCollection

-(id)init
{
    return [self initWithName:@"default" withStoreType:ISCacheStoreTypeInDrive withSize:CGSizeZero];
}

-(id)initWithName:(NSString *)name
{
    return [self initWithName:name withStoreType:ISCacheStoreTypeInDrive withSize:CGSizeZero];
}

-(id)initWithName:(NSString *)name withStoreType:(int)type
{
    return [self initWithName:name withStoreType:type withSize:CGSizeZero];
}

-(id)initWithName:(NSString *)name withStoreType:(int)type withSize:(CGSize)size
{
    return [self initWithName:name withStoreType:type withSize:size withCount:0];
}

-(id)initWithName:(NSString *)name withStoreType:(int)type withCount:(int)count
{
    return [self initWithName:name withStoreType:type withSize:CGSizeZero withCount:count];
}

-(id)initWithName:(NSString *)name withStoreType:(int)type withSize:(CGSize)size withCount:(int)count
{
    return [self initWithName:name withStoreType:type withSize:size withCount:count withList:[[NSMutableDictionary alloc] init]];
}

-(id)initWithName:(NSString *)name withData:(NSMutableDictionary *)data
{
    int storeType = [data[@"storetype"] intValue];
    CGSize size = [data[@"size"] CGSizeValue];
    int count = [data[@"count"] intValue];
    // pars data
    return [self initWithName:name withStoreType:storeType withSize:size withCount:count withList:data];
}

-(id)initWithName:(NSString *)name withStoreType:(int)type withSize:(CGSize)size
        withCount:(int)count withList:(NSMutableDictionary *)list
{
    if (self = [super init])
    {
        self.name = name;
        self.storeType = type;
        self.size = size;
        self.count = 0;
        self.list = list;
        self.order = [[NSMutableArray alloc] init];
        
        return self;
    } else
        return nil;
}

-(NSDictionary *)toDictionary
{
    NSDictionary *ar = @{
                         @"name":self.name,
                         @"list":[[NSMutableDictionary alloc] init],
                         @"order":[self.order copy],
                         @"storetype":[NSNumber numberWithInt:self.storeType],
                         @"count":[NSNumber numberWithInt:self.count],
                         @"size":NSStringFromCGSize(self.size)
                         };
    
    return ar;
}

@end
