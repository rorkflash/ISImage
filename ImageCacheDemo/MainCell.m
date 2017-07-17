//
//  MainCell.m
//  movietrip
//
//  Created by Ashot Gasparyan on 6/2/16.
//  Copyright © 2016 Ashot Gasparyan. All rights reserved.
//

#import "MainCell.h"

@implementation MainCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    //
    self.cover.contentMode = UIViewContentModeScaleAspectFill;
    self.cover.clipsToBounds = YES;
    self.height = 130;
}

- (void)setContent:(NSDictionary *)data
{
    self.height = 130;
    self.title.text = [data[@"name"] uppercaseString];
}

- (void)setCoverImage:(NSDictionary *)data
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
