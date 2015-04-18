//
//  HomeUViewController.h
//  IT-eBooks
//
//  Created by Nguyen Huu Toan on 3/21/15.
//  Copyright (c) 2015 ToanNH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface HomeViewController : UIViewController <UITextFieldDelegate>{
    
}
#pragma make - Property
@property (strong, nonatomic) IBOutlet UITextField *tfTitle;
@property (strong, nonatomic) IBOutlet UIScrollView *editScrollView;
@property (strong, nonatomic) IBOutlet UIView *editContentView;


#pragma make - Action
- (IBAction)btnSearchEbooks:(id)sender;
@end
