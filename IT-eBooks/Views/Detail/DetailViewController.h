//
//  DetailViewController.h
//  IT-eBooks
//
//  Created by Nguyen Huu Toan on 3/21/15.
//  Copyright (c) 2015 ToanNH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

@interface DetailViewController : UIViewController <UITextViewDelegate> {
    NSMutableArray *data;
    NSDictionary *dict;
}
@property (strong, nonatomic) IBOutlet UIScrollView *editScrollView;

@property (nonatomic, assign) NSInteger idBooks;

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

@property (strong, nonatomic) IBOutlet UILabel *lblPublisher;

@property (strong, nonatomic) IBOutlet UILabel *lblBy;

@property (strong, nonatomic) IBOutlet UILabel *lblISBN;

@property (strong, nonatomic) IBOutlet UILabel *lblYear;

@property (strong, nonatomic) IBOutlet UILabel *lblPages;

//@property (strong, nonatomic) IBOutlet UILabel *lblDesc;

@property (strong, nonatomic) IBOutlet UITextView *lblDesc;

@property (strong, nonatomic) IBOutlet UIImageView *imageBook;

- (IBAction)btnDownload:(id)sender;
@end
