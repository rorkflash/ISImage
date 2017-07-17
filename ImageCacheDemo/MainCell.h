//
//  MainCell.h
//  movietrip
//
//  Created by Ashot Gasparyan on 6/2/16.
//  Copyright © 2016 Ashot Gasparyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MainCell : UITableViewCell

@property (strong, nonatomic) NSString *ident;
@property int index;
@property float height;
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *title;

-(void)setContent:(NSDictionary *)data;

@end
