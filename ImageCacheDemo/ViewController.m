//
//  ViewController.m
//  ImageCacheDemo
//
//  Created by Ashot Gasparyan on 6/6/17.
//  Copyright © 2017 Ashot Gasparyan. All rights reserved.
//

#import "ViewController.h"
#import "ISImageCache.h"
#import <math.h>

@interface ViewController ()
{
    NSNumber *cols;
    ISImageCache *cache;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    cache = [ISImageCache getInstance];
    [cache setup];
    //[cache clearCache];
    if (cache.list.count <= 1) {
        [cache addCollectionWithName:@"main" withStoreType:ISCacheStoreTypeInDrive];
    }
    
    self.list1 = @[
                   @"https://www.w3schools.com/css/img_fjords.jpg",
                   @"http://i.stack.imgur.com/WCveg.jpg",
                   @"http://lokeshdhakar.com/projects/lightbox2/images/image-3.jpg",
                   @"http://wowslider.com/sliders/demo-65/data1/images/bernese_oberland.jpg",
                   @"http://bsnscb.com/data/out/101/40051776-image-wallpapers.jpg",
                   @"http://bsnscb.com/data/out/102/39454516-image-wallpapers.jpg"
                   ];
    
    self.list2 = @[
                   @{@"name":@"1", @"url": @"https://static.pexels.com/photos/3247/nature-forest-industry-rails.jpg"},
                   @{@"name":@"2", @"url": @"https://wallpaperscraft.com/image/switzerland_mountains_alps_road_summer_86912_1920x1080.jpg"},
                   @{@"name":@"3", @"url": @"https://wallpaperscraft.com/image/lake_sunset_trees_landscape_beach_art_night_reflection_48159_1920x1080.jpg"},
                   @{@"name":@"4", @"url": @"https://wallpaperscraft.com/image/fog_trees_forest_thicket_84863_1920x1080.jpg"},
                   @{@"name":@"5", @"url": @"https://wallpaperscraft.com/image/ng_gate_sun_tree_leaves_earth_emptiness_60174_1920x1080.jpg"},
                   @{@"name":@"6", @"url": @"https://wallpaperscraft.com/image/desert_mountains_sand_sky_landscape_100762_1920x1080.jpg"},
                   @{@"name":@"7", @"url": @"https://wallpaperscraft.com/image/boat_ocean_palm_trees_sunset_96491_1920x1080.jpg"}
                   ];
    
    self.list3 = @[
                   @{@"name":@"1", @"type":@"drive", @"url":@"http://localhost/img/1.jpg"},
                   @{@"name":@"2", @"type":@"memory", @"url":@"http://localhost/img/2.jpg"},
                   @{@"name":@"3", @"type":@"drive", @"url":@"http://localhost/img/3.jpg"},
                   @{@"name":@"4", @"type":@"drive", @"url":@"http://localhost/img/4.jpg"},
                   @{@"name":@"5", @"type":@"drive", @"url":@"http://localhost/img/5.jpg"},
                   @{@"name":@"6", @"type":@"drive", @"url":@"http://localhost/img/6.jpg"},
                   @{@"name":@"7", @"type":@"drive", @"url":@"http://localhost/img/7.jpg"},
                   @{@"name":@"8", @"type":@"drive", @"url":@"http://localhost/img/8.jpg"},
                   @{@"name":@"9", @"type":@"drive", @"url":@"http://localhost/img/9.jpg"}
                   ];
    
    self.listView1 = [[NSMutableArray alloc] init];
    self.listView2 = [[NSMutableArray alloc] init];
    self.listView3 = [[NSMutableArray alloc] init];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self loadImages];
}

-(void)loadImages
{
    NSDictionary *obj = nil;
    for (int i=0; i<self.list3.count; i++) {
        obj = self.list3[i];
        [UIImage getImage:obj[@"url"] withCache:@[obj[@"name"], @"main", [NSNumber numberWithInt:ISCacheStoreTypeInDrive]]
                completion:^(UIImage *img, NSError *error) {
                    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
                    int row = (int)(i/3);
                    imgView.frame = CGRectMake((i-row*3)*123+4, 60+row*(80+3), 120, 80);
                    [self.listView3 addObject:imgView];
                    [self.view addSubview:imgView];
                }];
    }
}

-(void)unloadImages
{
    for (int i=0; i<self.listView3.count; i++) {
        UIImageView *imgView = self.listView3[i];
        [imgView removeFromSuperview];
    }
    [self.listView3 removeAllObjects];
}

- (IBAction)onRefrsh:(UIButton *)sender
{
    NSLog(@"Refresh");
    [self unloadImages];
    [self loadImages];
}

- (IBAction)onClear:(UIButton *)sender
{
    NSLog(@"ClearAll");
    [[ISImageCache getInstance] clearAll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
