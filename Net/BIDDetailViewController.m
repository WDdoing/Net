//
//  BIDDetailViewController.m
//  Net
//
//  Created by dong wang on 12-8-5.
//  Copyright (c) 2012年 hfut ios开发组. All rights reserved.
//

#import "BIDDetailViewController.h"
#import "BIDNoticeViewController.h"

@interface BIDDetailViewController ()
{
    NSMutableData * receivedData;
}

- (void)getData;
- (NSArray *)parserData;

@end

@implementation BIDDetailViewController


@synthesize webView;
@synthesize linkIndex;
@synthesize dataDic;



- (void)getData
{
    NSArray * links = [self.dataDic objectForKey:@"link"];
    NSString * urlString = @"http://som.hfut.edu.cn/";
    urlString = [urlString stringByAppendingString:[links objectAtIndex:self.linkIndex]];
    
    
    NSURL * url = [NSURL URLWithString:urlString];
    //NSURLRequest * request = [NSURLRequest requestWithURL:url];
    //NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (connection) {
        receivedData = [NSMutableData data];
            } else {
                NSLog(@"Can not connect!");
                    }
    
    /*[NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * response,NSData * data,NSError * error)
     {
         if ([data length] > 0 && error == nil) {
             NSString * docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
             NSString * filePath = [docDir stringByAppendingPathComponent:@"detail.html"];
             [data writeToFile:filePath atomically:YES];
         }else if ([data length] == 0 && error == nil) {
             NSLog(@"Nothing Download!");
         }else if (error != nil) {
             NSLog(@"We got an error!");
         }
     }];*/
    
    /*NSURLResponse * response = nil;
    NSError * error = nil;
    
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if ([data length] > 0 && error == nil) {
        NSString * docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString * filePath = [docDir stringByAppendingPathComponent:@"detail.html"];
        [data writeToFile:filePath atomically:YES];
    }else if ([data length] == 0 && error == nil) {
        NSLog(@"Nothing download!");
    }else if (error != nil) {
        NSLog(@"We got an error!");
    }*/
}


- (NSArray *)parserData
{
    NSString * documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * filePath = [documentDir stringByAppendingPathComponent:@"detail.html"];
    NSData * data = [[NSData alloc] initWithContentsOfFile:filePath];
    
    TFHpple * xpathParser = [[TFHpple alloc] initWithHTMLData:data];
    
    
    
    NSArray * headElements = [xpathParser search:@"//div[@class = 'h hm']/h1"];
    NSMutableArray * headArray = [[NSMutableArray alloc] init];
    
    for (TFHppleElement * element in headElements) {
        NSString * strItem = [element content];
        [headArray addObject:strItem];
    }
    NSString * headString = [headArray componentsJoinedByString:@" "];
    
    
    
    
    NSArray * publishElements = [xpathParser search:@"//div[@class = 'h hm']/p/text() | //div[@class = 'h hm']/p/a"];
    NSMutableArray * publishArray = [[NSMutableArray alloc] init];
    
    for (TFHppleElement * element in publishElements) {
        NSString * strItem = [element content];
        [publishArray addObject:strItem];
    }
    NSString * publishString = [publishArray componentsJoinedByString:@" "];
    
    
    
    
    NSArray * contentElements = [xpathParser search:@"//td[@id = 'article_content']/descendant::*/text()"];////td[@id = 'article_content']/div/span/p[@class = 'MsoNormal']/span/text() | //td[@id = 'article_content']/div/span/p[@class = 'MsoNormal']/span/font/text() | //td[@id = 'article_content']/p/text() | //td[@id = 'article_content']/text() | //td[@id = 'article_content']/div/text() | //td[@id = 'article_content']/div/p/text() | //td[@id = 'article_content']/div/p/a/text() | //td[@id = 'article_content']/div/p/a/@href | //td[@id = 'article_content']/p/span/font/text() | //td[@id = 'article_content']/p/span/font/span/text() | //td[@id = 'article_content']/p/font/span/text() | //td[@id = 'article_content']/p/font/span/span/text() | //td[@id = 'article_content']/div/p/b/span/text() | //td[@id = 'article_content']/div/p/b/span/span/text() | 
    NSMutableArray * contentArray = [[NSMutableArray alloc] init];
    
    for (TFHppleElement * element in contentElements) {
        NSString * strItem = [element content];
        //NSLog(@"oneItem:%@",strItem);
        [contentArray addObject:strItem];
    }
    NSString * contentString = [contentArray componentsJoinedByString:@" "];
    //NSLog(@"array:%@",contentString);
    
    
    
    NSArray * dataArray = [[NSArray alloc] initWithObjects:headString,publishString,contentString, nil];
    return dataArray;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark NSURLConnectionDelegate Methods


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
    
    NSString * docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * filePath = [docDir stringByAppendingPathComponent:@"detail.html"];
    [receivedData writeToFile:filePath atomically:YES];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSArray * dataArray = [self parserData];
    
    NSString * headString = [dataArray objectAtIndex:0];
    NSString * publishString = [dataArray objectAtIndex:1];
    NSString * contentString = [dataArray objectAtIndex:2];
    
    NSString * htmlString = @"<html><body><h1 style=\"text-align:center;font-family:verdana;font-size:60px\">";
    htmlString = [[htmlString stringByAppendingString:headString] stringByAppendingString:@"</h1><p style=\"text-align:center;font-size:40px\">"];
    htmlString = [[htmlString stringByAppendingString:publishString] stringByAppendingString:@"</p><p style=\"font-family:arial;font-size:50px\">"];
    htmlString = [[htmlString stringByAppendingString:contentString] stringByAppendingString:@"</p></body></html>"];
    
    [self.webView loadHTMLString:htmlString baseURL:nil];
    self.webView.scalesPageToFit = YES;
}

/*- (void)viewWillAppear:(BOOL)animated
{
    [self getData];
}*/

/*- (void)connectionDidFinishDownloading:(NSURLConnection *)connection destinationURL:(NSURL *)destinationURL
{
    NSString * contentString = [self parserData];
    
    NSString * htmlString = @"<html><body>";
    htmlString = [[htmlString stringByAppendingString:contentString] stringByAppendingString:@"</body></html>"];
    
    [self.webView loadHTMLString:htmlString baseURL:nil];
    self.webView.scalesPageToFit = YES;
    
}*/
#pragma mark



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getData];
    //NSString * contentString = [self parserData];
    
    //NSString * path = [[NSBundle mainBundle] pathForResource:@"detail" ofType:@"html"];
    //NSString * html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
   /* NSString * htmlString = @"<html><body>";
    htmlString = [[htmlString stringByAppendingString:contentString] stringByAppendingString:@"</body></html>"];
    
    [self.webView loadHTMLString:htmlString baseURL:nil];
    self.webView.scalesPageToFit = YES;*/
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.webView = nil;
    self.dataDic = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
