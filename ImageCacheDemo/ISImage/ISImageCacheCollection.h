//
//  ISImageCacheCollection.h
//  movietrip
//
//  Created by Ashot Gasparyan on 6/1/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ISImageCacheDelegate.h"

typedef enum {
    ISCacheStoreTypeInDrive,
    ISCacheStoreTypeInMemory,
    ISCacheStoreTypeCombined
} ISCacheStoreType;

@interface ISImageCacheCollection : NSObject

@property (strong) NSString *name;
@property int storeType;
@property CGSize size;
@property int count;
@property (strong) NSMutableDictionary *list;
@property (strong) NSMutableArray *order;
@property (nonatomic, weak) id <ISImageCacheDelegate> cacheDelegate;

-(id)init;
-(id)initWithName:(NSString *)name;
-(id)initWithName:(NSString *)name withStoreType:(int)type;
-(id)initWithName:(NSString *)name withStoreType:(int)type withSize:(CGSize)size;
-(id)initWithName:(NSString *)name withStoreType:(int)type withSize:(CGSize)size withCount:(int)count;
-(id)initWithName:(NSString *)name withData:(NSMutableDictionary *)data;
-(id)initWithName:(NSString *)name withStoreType:(int)type withSize:(CGSize)size withCount:(int)count withList:(NSMutableDictionary *)list;
-(id)initWithName:(NSString *)name withStoreType:(int)type withCount:(int)count;

-(NSDictionary *)toDictionary;

@end
