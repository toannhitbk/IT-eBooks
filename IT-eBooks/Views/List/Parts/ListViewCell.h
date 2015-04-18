//
//  ListViewCell.h
//  IT-eBooks
//
//  Created by Nguyen Huu Toan on 3/21/15.
//  Copyright (c) 2015 ToanNH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewCell : UITableViewCell {
    
}
@property (strong, nonatomic) IBOutlet UIView *bgView;

@property (strong, nonatomic) IBOutlet UIImageView *images;

@property (strong, nonatomic) IBOutlet UILabel *title;

@property (strong, nonatomic) IBOutlet UILabel *derc;

@end
