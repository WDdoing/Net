//
//  BIDSecondViewController.m
//  Net
//
//  Created by dong wang on 12-7-30.
//  Copyright (c) 2012年 hfut ios开发组. All rights reserved.
//

#import "BIDSecondViewController.h"

@interface BIDSecondViewController ()

@end

@implementation BIDSecondViewController

@synthesize webView;

- (IBAction)toggleReload
{
    [self.webView reload];
}


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
    self.title = @"苹果官网";
    UIBarButtonItem * reloadButton = [[UIBarButtonItem alloc] initWithTitle:@"Reload" style:UIBarButtonSystemItemRefresh target:self action:@selector(toggleReload)];
    self.navigationItem.rightBarButtonItem = reloadButton;
    
    NSString * urlAsString = @"http://www.apple.com";
    NSURL * url = [NSURL URLWithString:urlAsString];
    NSURLRequest * request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0f];
    [webView loadRequest:request];
    self.webView.scalesPageToFit = YES;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end




