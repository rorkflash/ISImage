//
//  ISImageCacheModel.h
//  movietrip
//
//  Created by Ashot Gasparyan on 6/5/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISImageCacheModelDelegate.h"

@interface ISImageCacheModelDef : NSObject <ISImageCacheModelDelegate>

-(NSMutableDictionary *)setupList;

-(void)addCollection:(NSDictionary *)collection;
-(void)removeCollection:(NSString *)key;
-(void)addImage:(NSDictionary *)image withCollection:(NSString *)coll;
-(void)removeImage:(NSString *)key withCollection:(NSString *)collName;
-(void)clearAll;

@end
