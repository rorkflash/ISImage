//
//  ISImageCacheObject.h
//  ImageCacheDemo
//
//  Created by Ashot Gasparyan on 7/1/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISImageCacheObject : NSObject

@property (strong) NSString *name;
@property (strong) NSString *collname;
@property int storeType;

-(id)init;
+(id)initWithName:(NSString *)name withCollection:(NSString *)coll withStoreType:(int)type;
-(id)initWithName:(NSString *)name withCollection:(NSString *)coll withStoreType:(int)type;

@end
