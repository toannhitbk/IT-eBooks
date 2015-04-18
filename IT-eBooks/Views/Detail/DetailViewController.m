//
//  DetailViewController.m
//  IT-eBooks
//
//  Created by Nguyen Huu Toan on 3/21/15.
//  Copyright (c) 2015 ToanNH. All rights reserved.
//

#import "DetailViewController.h"
#import "MBProgressHUD.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    NSLog(@"ID----%@",_idBooks);
    _lblTitle.text = nil;
    _lblPublisher.text = nil;
    _lblBy.text = nil;
    _lblISBN.text = nil;
    _lblYear.text = nil;
    _lblPages.text = nil;
    _lblDesc.text = nil;
    _lblDesc.editable = NO;
    [self getDataSearch:_idBooks];
//    [self.editScrollView setContentOffset:CGPointMake(0, frame.y - 180) animated:YES];
//    [self.editScrollView setContentSize:CGSizeMake(320, 568+50)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getDataSearch:(NSInteger *)idbo{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [manager GET:[NSString stringWithFormat:@"http://it-ebooks-api.info/v1/book/%@",idbo] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dict = (NSDictionary *)responseObject;
        NSLog(@"Dict: %@",responseObject);
        _lblTitle.text = [dict objectForKey:@"Title"];
        _lblPublisher.text = [dict objectForKey:@"Publisher"];
        _lblBy.text = [dict objectForKey:@"Author"];
        _lblISBN.text = [dict objectForKey:@"ISBN"];
        _lblYear.text = [dict objectForKey:@"Year"];
        _lblPages.text = [dict objectForKey:@"Page"];
        _lblDesc.text = [dict objectForKey:@"Description"];
        _imageBook.image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Image"]]]]];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    [textView resignFirstResponder];
    return YES;
}


- (IBAction)btnDownload:(id)sender {
    NSString *text = [dict objectForKey:@"Title"];
    NSURL *url = [NSURL URLWithString:[dict objectForKey:@"Download"]];
    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Image"]]]]];
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[text,url,image] applicationActivities:nil];
    controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                         UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll,
                                         UIActivityTypeAddToReadingList,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypePostToTencentWeibo,
                                         UIActivityTypeAirDrop];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
