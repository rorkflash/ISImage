//
//  ISImageCacheDelegate.h
//  ImageCacheDemo
//
//  Created by Ashot Gasparyan on 6/8/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#ifndef ISImageCacheDelegate_h
#define ISImageCacheDelegate_h

@protocol ISImageCacheDelegate <NSObject>

@property (strong, nonatomic) NSMutableDictionary *list;

@optional

@end

#endif /* ISImageCacheDelegate_h */
