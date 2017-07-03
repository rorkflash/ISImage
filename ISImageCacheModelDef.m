//
//  ISImageCacheModel.m
//  movietrip
//
//  Created by Ashot Gasparyan on 6/5/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import "ISImageCacheModelDef.h"

@implementation ISImageCacheModelDef
{
    NSUserDefaults *pref;
    NSMutableDictionary *list;
    NSString *refKey;
}

-(NSMutableDictionary *)setupList
{
    pref = [NSUserDefaults standardUserDefaults];
    list = [[NSMutableDictionary alloc] init];
    refKey = @"ISImageCache";
    // DATA MODEL
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    @try {
        data = [pref objectForKey:refKey];
        if (data == nil) {
            [pref setObject:[[NSMutableDictionary alloc] init] forKey:refKey];
            [pref synchronize];
        }
    } @catch (NSException *exception) {
        NSLog(@"data initialization error %@", exception.reason);
    } @finally {
        if (data != nil) list = [[NSMutableDictionary alloc] initWithDictionary:[data mutableCopy]];
        return list;
    }
}

-(void)addCollection:(NSDictionary *)collection
{
    @try {
        list[collection[@"name"]] = [collection mutableCopy];
    } @catch (NSException *exception) {
        NSLog(@"failed to add collection %@", exception.reason);
    } @finally {
        [pref setObject:list forKey:refKey];
        [pref synchronize];
    }
}

-(void)removeCollection:(NSString *)key
{
    @try {
        [list removeObjectForKey:key];
    } @catch (NSException *exception) {
        NSLog(@"failed te remove collection %@", exception.reason);
    } @finally {
        [pref setObject:list forKey:refKey];
        [pref synchronize];
    }
}

-(void)addImage:(NSDictionary *)image withCollection:(NSString *)key
{
    NSMutableDictionary *clist = nil;
    @try {
        clist = list[key];
        //NSLog(@"collect list %@", clist);
        clist[@"list"][image[@"name"]] = @{@"name":image[@"name"]};//[image copy];
        //[clist[@"order"] insertObject:image[@"name"] atIndex:0];
    } @catch (NSException *exception) {
        NSLog(@"failed to add image in collection %@", exception.reason);
    } @finally {
        [pref setObject:list forKey:refKey];
        [pref synchronize];
    }
}

-(void)removeImage:(NSString *)key withCollection:(NSString *)collName
{
    NSMutableDictionary *clist = nil;
    @try {
        clist = list[collName];
        [clist[@"list"] removeObjectForKey:key];
        [clist[@"order"] removeObject:key];
    } @catch (NSException *exception) {
        NSLog(@"failed to remove image from collection %@", exception.reason);
    } @finally {
        [pref setObject:list forKey:refKey];
        [pref synchronize];
    }
}

@end
