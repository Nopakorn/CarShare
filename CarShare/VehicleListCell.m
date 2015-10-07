//
//  VehicleListCell.m
//  CarShare
//
//  Created by guild on 10/7/2558 BE.
//  Copyright © 2558 ssd. All rights reserved.
//

#import "VehicleListCell.h"

@implementation VehicleListCell

@synthesize title = _title;
@synthesize detail = _detail;
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, 100, 50);
}

@end
