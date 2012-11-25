//
//  BIDNoticeViewController.m
//  Net
//
//  Created by dong wang on 12-8-3.
//  Copyright (c) 2012年 hfut ios开发组. All rights reserved.
//

#import "BIDNoticeViewController.h"
#import "BIDNewsCell.h"
#import "BIDDetailViewController.h"
#import "BIDXisuoNoticeViewController.h"

@interface BIDNoticeViewController ()

- (void)getData;

- (NSDictionary *)parserData;

@end

@implementation BIDNoticeViewController

@synthesize dataDic;
@synthesize controllers;


- (void)getData
{
    NSURL * url = [NSURL URLWithString:@"http://som.hfut.edu.cn/portal.php?mod=list&catid=15"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];

    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * response,NSData * data,NSError * error)
     {
         if ([data length] > 0 && error == nil) {
             //NSString * htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             
             NSString * documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
             NSString * filePath = [documentDir stringByAppendingPathComponent:@"学院新闻.html"];
             [data writeToFile:filePath atomically:YES];
             
         }else if ([data length] == 0 && error == nil) {
             NSLog(@"Nothing downloaded");
         }else if (error != nil) {
             NSLog(@"Error:%@",error);
         }
     }];
    //NSString * documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //NSString * filePath = [documentDir stringByAppendingPathComponent:@"apple.html"];
    //NSError * error;
    //return [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    //return [NSData dataWithContentsOfFile:filePath];
}


- (NSDictionary *)parserData
{
    NSString * documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * filePath = [documentDir stringByAppendingPathComponent:@"学院新闻.html"];
    NSData * data = [[NSData alloc] initWithContentsOfFile:filePath];
    
    TFHpple * xpathParser = [[TFHpple alloc] initWithHTMLData:data];
    
    
    NSArray * titleElements = [xpathParser search:@"//div[@class = 'bm_c']/ul/li/span/a"];
    NSMutableArray * titleArray = [[NSMutableArray alloc] init];
    
    for (TFHppleElement * element in titleElements) {
        NSString * strItem = [element content];
        NSLog(@"oneItem:%@",strItem);
        [titleArray addObject:strItem];
    }
    //NSLog(@"array:%@",titleArray);
    
    
    
    NSArray * dateElements = [xpathParser search:@"//div[@class = 'bm_c']/ul/li/em"];
    NSMutableArray * dateArray = [[NSMutableArray alloc] init];
    
    for (TFHppleElement * element in dateElements) {
        NSString * strItem = [element content];
        //NSLog(@"oneItem:%@",strItem);
        [dateArray addObject:strItem];
    }
    //NSLog(@"date:%@",dateArray);
    
    
    NSArray * linkElements = [xpathParser search:@"//div[@class = 'bm_c']/ul/li/span/a/@href"];
    NSMutableArray * linkArray = [[NSMutableArray alloc] init];
    
    for (TFHppleElement * element in linkElements) {
        NSString * strItem = [element content];
        //NSLog(@"oneItem:%@",strItem);
        [linkArray addObject:strItem];
    }
    //NSLog(@"link:%@",linkArray);
    
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:titleArray,@"title",dateArray,@"date",linkArray,@"link", nil];
    //NSLog(@"count:%d",[dic count]);
    //NSLog(@"title:%d",[[dic objectForKey:@"title"] count]);
    
    
    
    return dic;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self getData];
    self.dataDic = [self parserData];
    //[[NSBundle mainBundle] loadNibNamed:@"newsViewTabBar" owner:self options:nil];
    //[self.navigationController.view.window addSubview:self.tabBarController.view];
    BIDXisuoNoticeViewController * xisuoNoticeController = [self.controllers objectAtIndex:2];
    xisuoNoticeController.dataDic = self.dataDic;
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.dataDic = nil;
    self.controllers = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *newsCellIdentifier = @"newsCell";
    static BOOL nibsRegistered = NO;
    
    if (!nibsRegistered) {
        UINib * nib = [UINib nibWithNibName:@"Empty" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:newsCellIdentifier];
        nibsRegistered = YES;
    }
    
    BIDNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:newsCellIdentifier];
    
    /*if (cell == nil) {
        NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"Empty" owner:self options:nil];
        for (id oneObject in nibArray) {
            if ([oneObject isKindOfClass:[BIDNewsCell class]]) {
                cell = (BIDNewsCell *)oneObject;
            }
        }
    }*/
    
    // Configure the cell...
    
    /*NSString * documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * filePath = [documentDir stringByAppendingPathComponent:@"baidu.html"];
    
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    
    NSString * htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //NSString * string = @"good afternoon";
    
    
    [cell.webView loadHTMLString:htmlString baseURL:nil];*/
    //cell.webView.scalesPageToFit = YES;
    
    NSArray * titleArray = [self.dataDic objectForKey:@"title"];
    //NSLog(@"title:%@",titleArray);
    NSInteger row = [indexPath row];
    cell.titleLabel.text = [titleArray objectAtIndex:row];
    
    NSArray * dateArray = [self.dataDic objectForKey:@"date"];
    //NSLog(@"date:%@",dateArray);
    cell.dateLabel.text = [dateArray objectAtIndex:row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    BIDDetailViewController * detailController = [[BIDDetailViewController alloc] initWithNibName:@"BIDDetailViewController" bundle:nil];
    
    NSUInteger row = [indexPath row];
    detailController.linkIndex = row;
    detailController.dataDic = self.dataDic;
    
    
    [self.navigationController pushViewController:detailController animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}


@end
