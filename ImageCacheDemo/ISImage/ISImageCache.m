//
//  ISImageCache.m
//  movietrip
//
//  Created by Ashot Gasparyan on 6/1/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import "ISImageCache.h"

@implementation ISImageCache
{
    NSString *docDir;
}

+(ISImageCache *)getInstance
{
    static ISImageCache *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        self.list = [[NSMutableDictionary alloc] init];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        docDir = [paths objectAtIndex:0];
    }
    return self;
}

-(void)setup
{
    [self setupWith:ISCacheModelDef];
}

-(void)setupWith:(int)modelType
{
    [self setModelType:modelType];
    [self loadData];
}

-(void)setModelType:(int)modelType
{
    if (modelType == ISCacheModelDef) {
        self.model = [[ISImageCacheModelDef alloc] init];
    } else {
        self.model = [[ISImageCacheModelCD alloc] init];
    }
}

-(void)loadData
{
    NSMutableDictionary *list = [self.model setupList];
    NSDictionary *imgList = nil;
    NSMutableDictionary *imgObj = nil;
    [self.list removeAllObjects];
    
    if ([list count] > 0) {
        for (NSString *key in list) {
            imgList = list[key][@"list"];
            ISImageCacheCollection *coll = [[ISImageCacheCollection alloc] initWithName:key];
            self.list[key] = coll;
            // Image List
            for (NSString *imgKey in imgList) {
                imgObj = [[NSMutableDictionary alloc] initWithDictionary:@{
                                                                           @"name":imgList[imgKey][@"name"],
                                                                           @"image":imgList[imgKey][@"image"],
                                                                           @"path":imgList[imgKey][@"path"],
                                                                           @"storetype":imgList[imgKey][@"storetype"],
                                                                           @"date": imgList[imgKey][@"date"],
                                                                           @"timestamp": imgList[imgKey][@"timestamp"]
                                                                           }];
                coll.list[imgKey] = imgObj;
            }
            // Order list
            coll.order = [list[key][@"order"] mutableCopy];
        }
    } else {
        [self addCollectionWithName:@"default" withStoreType:ISCacheStoreTypeInDrive];
    }
}

/* 
 DATA structure
 [
    "CollectionName":{
        name:NSString,
        storetype:ISCacheModelType,
        count:int,
        size:CGSize,
        list:[...] // Array of image objects,
        order:[...]
    },
    ...
 ]
 
 LIST structure
 [
    "CollectionName":CollectionObject 
        {
            list:[
                {
                     name: NSString,
                     image: UIImage,
                     storetype: ISCacheModelType,
                     date: NSString,
                     timestamp: NSString
                },
                ...] // Array of image objects,
            order:[...]
        },
    ...
 ]
 */

// SET AND GET IMAGES

-(UIImage *)getImage:(NSString *)key fromCollection:(NSString *)collName
{
    NSMutableDictionary *obj = nil;
    UIImage *img = nil;
    
    @try {
        ISImageCacheCollection *coll = self.list[collName];
        
        if (coll.list[key] != nil) {
            obj = coll.list[key];
            img = obj[@"image"];
            if (img == nil || [img isEqual:@""]) {
                NSString *path = obj[@"path"];
                img = [UIImage imageWithContentsOfFile:path];
            }
        }
        
    } @catch (NSException *exception) {
        NSLog(@"there is no list with this key");
    } @finally {
        return img;
    }
    
    return nil;
}

-(void)setImage:(UIImage *)img withKey:(NSString *)key withCollection:(NSString *)collName
{
    ISImageCacheCollection *coll = self.list[collName];
    if (coll != nil) {
        int type = coll.storeType;
        [self setImage:img withKey:key withCollection:collName withStorType:type];
    } else {
        NSLog(@"collection not exist");
    }
}

-(void)setImage:(UIImage *)img withKey:(NSString *)key withCollection:(NSString *)collName withStorType:(int)type
{
    // DATE
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSDate *currentDate = [NSDate date];
    NSString *dateString = [formatter stringFromDate:currentDate];
    NSTimeInterval since1970 = [currentDate timeIntervalSince1970];
    double timestamp = since1970 * 1000;
    NSString *name = [NSString stringWithFormat:@"%f", timestamp];
    // IMAGE PART
    NSData *imageData = UIImagePNGRepresentation(img);
    // CHECK IMAGE EXIST
    @try {
        ISImageCacheCollection *coll = self.list[collName];
        //
        if (coll != nil) {
            NSMutableDictionary *obj = nil;
            // check store type
            type = coll.storeType != ISCacheStoreTypeCombined ? coll.storeType : type;
            //
            if (coll.list[key] != nil) { // image exist
                obj = coll.list[key];
                name = obj[name];
                [coll.order removeObject:key]; // remove from order, if exists
            }
            
            obj = [[NSMutableDictionary alloc] initWithDictionary:@{
                                                                    @"name":name,
                                                                    @"image":@"",
                                                                    @"path":@"",
                                                                    //@"url":@"",
                                                                    @"storetype":[NSNumber numberWithInt:type],
                                                                    @"date": dateString,
                                                                    @"timestamp": [NSString stringWithFormat:@"%f", timestamp]
                                                                    }];
            
            if (type == ISCacheStoreTypeInDrive) {
                // STORE IN DRIVE
                NSString *imagePath = [docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",name]];
                
                if (![imageData writeToFile:imagePath atomically:YES]) {
                    NSLog(@"Failed to cache image data to disk");
                } else {
                    //NSLog(@"the cachedImaged is %@", key);
                    // DATA
                    obj[@"path"] = imagePath;
                    [self.model addImage:obj withCollection:collName];
                }
            } else {
                // STORE IN MEMORY
                obj[@"image"] = img;
            }
            
            // Dynamic Data
            NSLog(@"image %@ saved in \"%@\" collection", key, coll.name);
            coll.list[key] = obj;
            // Ordering
            [coll.order insertObject:key atIndex:0]; // add to beginnig of array
            // Check list and remove if out of count
            [self checkList:coll];
            
        } else {
            NSLog(@"collection not exist");
        }
        
    } @catch (NSException *exception) {
        NSLog(@"some error with caching");
    } @finally {
        
    }
}

-(void)removeImage:(NSString *)key withCollectionName:(NSString *)collName
{
    if (self.list[collName]) {
        ISImageCacheCollection *coll = self.list[collName];
        [self removeImage:key withCollection:coll];
    }
}

-(void)removeImage:(NSString *)key withCollection:(ISImageCacheCollection *)coll
{
    NSDictionary *img = coll.list[key];
    NSError *error = nil;
    @try {
        // remove image if it exists in drive
        [[NSFileManager defaultManager] removeItemAtPath:img[@"path"] error:&error];
        // remove from Model
        [self.model removeImage:key withCollection:coll.name];
        // remove from list
        [coll.list removeObjectForKey:key];
        // remove from order
        [coll.order removeObject:key];
        //
    } @catch (NSException *exception) {
        NSLog(@"somthing goes wrong %@", exception.reason);
        NSLog(@"%@", error);
    } @finally {
        
    }
}

// ORDERING

-(void)checkList:(ISImageCacheCollection *)coll
{
    if (coll.count > 0 && coll.order.count > coll.count) {
        for (int i=coll.count; i < coll.order.count; i++) {
            [self removeImage:coll.order[i] withCollection:coll];
        }
    }
}

// COLLECTIONS

-(void)addCollectionWithName:(NSString *)name withStoreType:(int)type
{
    ISImageCacheCollection *coll = [[ISImageCacheCollection alloc] initWithName:name withStoreType:type];
    [self addCollection:coll];
}

-(void)addCollectionWithName:(NSString *)name withStoreType:(int)type withCount:(int)count
{
    ISImageCacheCollection *coll = [[ISImageCacheCollection alloc] initWithName:name
                                                                  withStoreType:type
                                                                      withCount:count];
    [self addCollection:coll];
}

-(void)addCollection:(ISImageCacheCollection *)coll
{
    self.list[coll.name] = coll;
    // DATA
    [self.model addCollection:[coll toDictionary]];
}

-(ISImageCacheCollection *)getCollection:(NSString *)name
{
    return [self.list objectForKey:name];
}

-(void)removeCollection:(NSString *)name
{
    @try {
        [self clearCollection:name];
        //
        [self.list removeObjectForKey:name];
    } @catch (NSException *exception) {
        NSLog(@"problem to remove collection with name %@ \n reason %@", name, exception.reason);
    } @finally {
        
        // DATA
        [self.model removeCollection:name];
        [self.pref setObject:self.list forKey:@"ISImageCache"];
        [self.pref synchronize];
    }
}

-(void)removeCollections
{
    @try {
        [self.model removeCollections];
        for (NSString *key in self.list) {
            [self clearCollection:key];
            //[self.list removeObjectForKey:key];
        }
        [self.list removeAllObjects];
    } @catch (NSException *exception) {
        NSLog(@"collections remove failed %@", exception.reason);
    } @finally {
        
    }
}

-(void)clearCollection:(NSString *)name
{
    NSDictionary *img = nil;
    ISImageCacheCollection *coll = self.list[name];
    NSError *error = nil;
    
    @try {
        for (NSString *key in coll.list) {
            img = coll.list[key];
            [[NSFileManager defaultManager] removeItemAtPath:img[@"path"] error:&error];
        }
        [coll.list removeAllObjects];
        [coll.order removeAllObjects];
        [self.model removeCollection:name];
        //
    } @catch (NSException *exception) {
        NSLog(@"failed to clear collection cache %@", exception.reason);
    } @finally {
        
    }
}

-(void)clearCollections
{
    for (NSString *key in self.list) {
        [self clearCollection:key];
    }
}

// CLEAR

-(void)clearCache
{
    [self clearCollections];
}

-(void)clearAll
{
    [self clearCollections];
    [self.model clearAll];
}

-(void)clearAllWithModel:(int)modelType
{
    id <ISImageCacheModelDelegate> model = nil;
    if (modelType == ISCacheModelDef) {
        model = [[ISImageCacheModelDef alloc] init];
    } else {
        model = [[ISImageCacheModelCD alloc] init];
    }
    [model clearAll];
}

@end
