//
//  ISImageCacheModelCD.h
//  movietrip
//
//  Created by Ashot Gasparyan on 6/5/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISImageCacheModelDelegate.h"

@interface ISImageCacheModelCD : NSObject <ISImageCacheModelDelegate>

-(NSMutableDictionary *)setupList;

-(void)addImage:(NSDictionary *)image withCollection:(NSString *)coll;
-(void)removeImage:(NSString *)key withCollection:(NSString *)collName;

-(void)addCollection:(NSDictionary *)collection;
-(void)removeCollection:(NSString *)key;
-(void)removeCollections;

-(void)clearAll;

@end
