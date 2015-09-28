//
//  LogInViewcontroller.m
//  CarShare
//
//  Created by guild on 9/25/2558 BE.
//  Copyright © 2558 ssd. All rights reserved.
//

#import "LogInViewcontroller.h"

@implementation LogInViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.user = [[User alloc] init];
    self.textUserName.delegate = self;
    self.textPassword.delegate = self;
    

    [self.navigationController setNavigationBarHidden:YES];
    
}

-(IBAction)signIn:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *deviceTokenStr = [[[appDelegate.deviceToken description]
                                  stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""];
    NSLog(@"%@",deviceTokenStr);
    self.user.deviceToken = deviceTokenStr;
    
    [self.user setUsername:@"TEST" withPassword:@"TEST"];
}


- (BOOL) receivedLoadUser
{
    NSLog(@"in receivedLoadUser");
    if(self.user.strReply != nil)
    {
        NSLog(@"Log in success");
        return YES;
    }
    return NO;
}

//-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
//{
//    if ([identifier isEqualToString:@"SignIn"]) {
//        
//        
//        if(![self receivedLoadUser]){
//            
//            UIAlertView *notPermitted =[[UIAlertView alloc]
//                                        initWithTitle:@"Alert"
//                                        message:@"User ID not valid"
//                                        delegate:nil
//                                        cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [notPermitted show];
//            return NO;
//        }
//    }
//    return YES;
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"In segue");

    if([segue.identifier isEqualToString:@"SignIn"])
    {
        MenuViewController *dest = [segue destinationViewController];
        dest.user = self.user;
    }


}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
