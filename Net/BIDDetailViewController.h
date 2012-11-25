//
//  BIDDetailViewController.h
//  Net
//
//  Created by dong wang on 12-8-5.
//  Copyright (c) 2012年 hfut ios开发组. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDDetailViewController : UIViewController<NSURLConnectionDelegate>

@property (strong, nonatomic) IBOutlet UIWebView * webView;
@property (nonatomic) NSUInteger linkIndex;
@property (strong, nonatomic) NSDictionary * dataDic;

@end
