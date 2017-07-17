//
//  ISImageCache.h
//  movietrip
//
//  Created by Ashot Gasparyan on 6/1/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ISImageCacheDelegate.h"
#import "ISImageCacheCollection.h"
#import "ISImageCacheModelDef.h"
#import "ISImageCacheModelCD.h"
#import "UIImage+Load.h"
#import "ISImageCacheObject.h"

@interface ISImageCache : NSObject <ISImageCacheDelegate>

@property (strong, nonatomic) NSMutableDictionary *collections;
@property (strong, nonatomic) NSMutableDictionary *list;
//@property (strong, nonatomic) NSMutableArray *orderList;
@property (strong, nonatomic) NSUserDefaults *pref;
@property (strong, nonatomic) NSMutableDictionary *data;
@property (strong, nonatomic) id <ISImageCacheModelDelegate> model;

+(ISImageCache *)getInstance;

-(void)setup;
-(void)setupWith:(int)modelType;
-(void)setModelType:(int)modelType;
-(void)loadData;

-(UIImage *)getImage:(NSString *)key fromCollection:(NSString *)collName;
-(void)setImage:(UIImage *)img withKey:(NSString *)key withCollection:(NSString *)collName;
-(void)setImage:(UIImage *)img withKey:(NSString *)key withCollection:(NSString *)collName withStorType:(int)type;

-(void)addCollectionWithName:(NSString *)name withStoreType:(int)type;
-(void)addCollection:(ISImageCacheCollection *)coll;
-(void)removeCollection:(NSString *)name;
-(void)removeCollections;

-(void)clearCache;
-(void)clearCollection:(NSString *)name;
-(void)clearAll;
-(void)clearAllWithModel:(int)modelType;

@end
