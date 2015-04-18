//
//  HomeUViewController.m
//  IT-eBooks
//
//  Created by Nguyen Huu Toan on 3/21/15.
//  Copyright (c) 2015 ToanNH. All rights reserved.
//

#import "HomeViewController.h"
#import "ListViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

#pragma mark - Cycel Life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setHidden:YES];
    [self.tfTitle resignFirstResponder];
    [self.tfTitle setText:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGPoint frame = textField.frame.origin;
    [self.editScrollView setContentOffset:CGPointMake(0, frame.y - 180) animated:YES];
    [self.editScrollView setContentSize:CGSizeMake(320, 568+50)];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self pushListViewController];
    [self.tfTitle resignFirstResponder];
    return YES;
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    [self.view endEditing:YES];
}

//  Toast a message
- (void) toastMessage:(NSString *)message andDuration:(int)duration {
    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil,
                          nil];
    toast.tag = 10000;
    [toast show];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [toast dismissWithClickedButtonIndex:0 animated:YES];
    });
}

- (void)pushListViewController{
    if ([self.tfTitle.text isEqualToString:@""]) {
        [self toastMessage:@"Empty Textfiled" andDuration:1];
        [self.editScrollView setContentSize:CGSizeMake(320, 568)];
    }else{
        ListViewController *listViewController = [[ListViewController alloc] init];
        listViewController.textSearch = self.tfTitle.text;
        [self.navigationController pushViewController:listViewController animated:YES];
    }
}
#pragma mark - Button action

- (IBAction)btnSearchEbooks:(id)sender {
//    [_tfTitle becomeFirstResponder];
    [_tfTitle resignFirstResponder];
    [self pushListViewController];
}
@end
