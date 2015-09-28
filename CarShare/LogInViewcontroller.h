//
//  LogInViewcontroller.h
//  CarShare
//
//  Created by guild on 9/25/2558 BE.
//  Copyright © 2558 ssd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "MenuViewController.h"
#import "AppDelegate.h"

@interface LogInViewcontroller : UIViewController<UIAlertViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textUserName;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;

@property (nonatomic,weak) NSString* fag;
@property (strong, nonatomic) User * user;


- (IBAction)signIn:(id)sender;


@end
