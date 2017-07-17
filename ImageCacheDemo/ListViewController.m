//
//  ListViewController.m
//  ImageCacheDemo
//
//  Created by Ashot Gasparyan on 7/6/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import "ListViewController.h"
#import "MainCell.h"

@implementation ListViewController
{
    NSString *cellName;
}

-(void)viewDidLoad
{
    cellName = @"MainCell";
    UINib *cellNib = [UINib nibWithNibName:cellName bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:cellName];
    
    self.dataList = @[
                      @{@"name":@"1", @"type":@"drive", @"url":@"http://localhost/img/1.jpg"},
                      @{@"name":@"2", @"type":@"memory", @"url":@"http://localhost/img/2.jpg"},
                      @{@"name":@"3", @"type":@"drive", @"url":@"http://localhost/img/3.jpg"},
                      @{@"name":@"4", @"type":@"drive", @"url":@"http://localhost/img/4.jpg"},
                      @{@"name":@"5", @"type":@"drive", @"url":@"http://localhost/img/5.jpg"},
                      @{@"name":@"6", @"type":@"drive", @"url":@"http://localhost/img/6.jpg"},
                      @{@"name":@"7", @"type":@"drive", @"url":@"http://localhost/img/7.jpg"},
                      @{@"name":@"8", @"type":@"drive", @"url":@"http://localhost/img/8.jpg"},
                      @{@"name":@"9", @"type":@"drive", @"url":@"http://localhost/img/9.jpg"},
                      @{@"name":@"10", @"type":@"drive", @"url":@"http://localhost/img/10.jpg"}
                      ];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
    [self.tableView sizeToFit];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = (int)[indexPath row];
    MainCell *cell;
    
    if (index < [self.dataList count]) {
        NSDictionary *obj = self.dataList[index];
        cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        [cell setContent:obj];
        
        [UIImage getImage:obj[@"url"] withCache:@[obj[@"name"], @"list", [NSNumber numberWithInt:ISCacheStoreTypeInDrive]]
               completion:^(UIImage *img, NSError *error) {
                   //UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
                   [cell.cover setImage:img];
               }];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

@end
