//
//  BIDViewController.h
//  Net
//
//  Created by dong wang on 12-7-30.
//  Copyright (c) 2012年 hfut ios开发组. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDViewController : UIViewController

@property (strong, nonatomic) NSArray * controllers;

@property (strong,nonatomic) IBOutlet UITabBarController * tabBarController;


- (IBAction)buttonPressed:(id)sender;

- (IBAction)newsButtonPressed;

@end
