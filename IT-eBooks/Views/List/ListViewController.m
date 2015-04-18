//
//  ListViewController.m
//  IT-eBooks
//
//  Created by Nguyen Huu Toan on 3/23/15.
//  Copyright (c) 2015 ToanNH. All rights reserved.
//

#import "ListViewController.h"
#import "ListViewCell.h"
#import "MBProgressHUD.h"
#import "DetailViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

#pragma make cycel life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Create save data,dict
    data = [[NSMutableArray alloc] init];
    dict = [[NSMutableDictionary alloc] init];
    
    //String get json
    //http://it-ebooks-api.info/v1/search/php%20mysql/
    [self getDataSearch:[self.textSearch stringByReplacingOccurrencesOfString:@" " withString:@"%20"] andPage:1];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //page number
    i=1;
}

- (void)viewWillAppear:(BOOL)animated {
    [self setupDefaultNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma make - Function
-(void)setupDefaultNavigationBar {
    [self.navigationController.navigationBar setHidden:NO];
}


- (void)getDataSearch:(NSString *)title andPage:(int)page {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [manager GET:[NSString stringWithFormat:@"http://it-ebooks-api.info/v1/search/%@/page/%d",title,page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dict = (NSDictionary *)responseObject;
        NSLog(@"Dict: %@",responseObject);
        
        NSArray *list = [dict objectForKey:@"Books"];
        
        [data addObjectsFromArray:list];
        [self.tableView reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

#pragma make - UITableView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    
    CGFloat contentYoffset = scrollView.contentOffset.y;
    
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;
    
    if(distanceFromBottom <= height)
    {
        NSLog(@"end of the table");
        for (i;i<=[dict objectForKey:@"Page"]; i++) {
            i++;
            break;
        }
        if (i<=[dict objectForKey:@"Page"]) {
            [self getDataSearch:self.textSearch andPage:i];
        }
        NSLog(@"%d",i);
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 157;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListViewCell *cell = (ListViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil)
        {
            cell = (ListViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"ListViewCell" owner:self options:nil] lastObject];
        }
    
        // Do on background
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSArray *thedata = [data objectAtIndex:indexPath.row];
            NSString *title = [NSString stringWithFormat:@"%@",[thedata valueForKey:@"Title"]];
            NSString *des = [NSString stringWithFormat:@"%@",[thedata valueForKey:@"Description"]];
            // do on UI
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.title.text = title;
                cell.derc.text = des;
                [cell.images setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[thedata valueForKey:@"Image"]]]] placeholderImage:nil success:nil failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                    NSLog(@"Unable to retrieve image");
                }];
            });
        });
//        [self.tableView reloadData];
        cell.layer.shouldRasterize = YES;
        cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    return cell;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detal = [[DetailViewController alloc] init];
    detal.idBooks = [[data objectAtIndex:indexPath.row] valueForKey:@"ID"];
    [self.navigationController pushViewController:detal animated:YES];
    
    return indexPath;
}



@end
