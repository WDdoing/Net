//
//  BIDViewController.m
//  Net
//
//  Created by dong wang on 12-7-30.
//  Copyright (c) 2012年 hfut ios开发组. All rights reserved.
//

#import "BIDViewController.h"
#import "BIDSecondViewController.h"
#import "BIDNoticeViewController.h"
#import "BIDXisuoNoticeViewController.h"

@interface BIDViewController ()//<UITabBarDelegate>


@end

@implementation BIDViewController



@synthesize controllers;
@synthesize tabBarController;






- (IBAction)buttonPressed:(id)sender
{
    BIDSecondViewController * secondController = [self.controllers objectAtIndex:0];
    [self.navigationController pushViewController:secondController animated:YES];
}

- (IBAction)newsButtonPressed
{

    //BIDNoticeViewController * noticeController = [self.controllers objectAtIndex:1];
    [[NSBundle mainBundle] loadNibNamed:@"newsViewTabBar" owner:self options:nil];
    //[self.navigationController pushViewController:noticeController animated:YES];
    [self.navigationController pushViewController:self.tabBarController animated:YES];
    //[[NSBundle mainBundle] loadNibNamed:@"newsViewTabBar" owner:noticeController.navigationController options:nil];
}

/*- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    BIDNoticeViewController * noticeController = [self.controllers objectAtIndex:1];

    self.tabBarController
}*/





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"网站导航";
    NSMutableArray * array = [[NSMutableArray alloc] init];
    BIDSecondViewController * secondController = [[BIDSecondViewController alloc] initWithNibName:@"BIDSecondViewController" bundle:nil];
    
    BIDNoticeViewController * noticeController = [[BIDNoticeViewController alloc] initWithStyle:UITableViewStylePlain];
    

    BIDXisuoNoticeViewController * xisuoNoticeController = [[BIDXisuoNoticeViewController alloc] initWithStyle:UITableViewStylePlain];
   
    //xisuoNoticeController.dataDic = noticeController.dataDic;
    
    [array addObject:secondController];
    [array addObject:noticeController];
    [array addObject:xisuoNoticeController];
    
    self.controllers = array;
    noticeController.controllers = self.controllers;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.controllers = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
