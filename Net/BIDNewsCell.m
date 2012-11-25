//
//  BIDNewsCell.m
//  Net
//
//  Created by dong wang on 12-8-3.
//  Copyright (c) 2012年 hfut ios开发组. All rights reserved.
//

#import "BIDNewsCell.h"

@implementation BIDNewsCell

@synthesize newsImage;
@synthesize titleLabel;
@synthesize dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
