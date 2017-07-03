//
//  ISImageCacheModelDelegate.h
//  movietrip
//
//  Created by Ashot Gasparyan on 6/5/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#ifndef ISImageCacheModelDelegate_h
#define ISImageCacheModelDelegate_h

typedef enum {
    ISCacheModelCD,
    ISCacheModelDef
} ISCacheModelType;

@protocol ISImageCacheModelDelegate <NSObject>

@required

-(NSMutableDictionary *)setupList;

-(void)addCollection:(NSDictionary *)collection;
-(void)removeCollection:(NSString *)key;
-(void)addImage:(NSDictionary *)image withCollection:(NSString *)coll;
-(void)removeImage:(NSString *)key withCollection:(NSString *)collName;

@optional

@end

#endif
