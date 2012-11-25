//
//  BIDNewsCell.h
//  Net
//
//  Created by dong wang on 12-8-3.
//  Copyright (c) 2012年 hfut ios开发组. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDNewsCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView * newsImage;
@property (retain, nonatomic) IBOutlet UILabel * titleLabel;
@property (retain, nonatomic) IBOutlet UILabel * dateLabel;

@end
