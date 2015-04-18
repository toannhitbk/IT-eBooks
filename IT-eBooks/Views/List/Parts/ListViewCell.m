//
//  ListViewCell.m
//  IT-eBooks
//
//  Created by Nguyen Huu Toan on 3/21/15.
//  Copyright (c) 2015 ToanNH. All rights reserved.
//

#import "ListViewCell.h"

@implementation ListViewCell
@synthesize title,images,derc;

- (void)awakeFromNib {
    // Initialization code
    CGFloat borderWidth = 1.0f;
    
    _bgView.frame = CGRectInset(_bgView.frame, -borderWidth, -borderWidth);
    _bgView.layer.borderColor = [UIColor grayColor].CGColor;
    _bgView.layer.borderWidth = borderWidth;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
