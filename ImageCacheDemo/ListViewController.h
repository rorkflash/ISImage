//
//  ListViewController.h
//  ImageCacheDemo
//
//  Created by Ashot Gasparyan on 7/6/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIImage+Load.h"

@interface ListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *dataList;

@end
