//
//  ListViewController.h
//  IT-eBooks
//
//  Created by Nguyen Huu Toan on 3/23/15.
//  Copyright (c) 2015 ToanNH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+AFNetworking.h"

@interface ListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *data;
    NSDictionary *dict;
    int i;


}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) NSString *textSearch;
@end
