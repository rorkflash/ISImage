//
//  ViewController.h
//  ImageCacheDemo
//
//  Created by Ashot Gasparyan on 6/6/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) NSArray *list1;
@property (strong, nonatomic) NSArray *list2;
@property (strong, nonatomic) NSArray *list3;
@property (strong, nonatomic) NSMutableArray *listView1;
@property (strong, nonatomic) NSMutableArray *listView2;
@property (strong, nonatomic) NSMutableArray *listView3;
@property (weak, nonatomic) IBOutlet UIButton *refreshBtn;
@property (weak, nonatomic) IBOutlet UIButton *clearCacheBtn;


@end

