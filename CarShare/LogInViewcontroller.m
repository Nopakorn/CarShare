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
    //You need to get input from user
    [self.user setUsername:@"TEST" withPassword:@"TEST"];
    
    alert = [UIAlertController alertControllerWithTitle:nil message:@"Loading\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake(130.5, 65.5);
    spinner.color = [UIColor blackColor];
    [alert.view addSubview:spinner];
    [spinner startAnimating];
    [self presentViewController:alert animated:NO completion:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedLoadUser)
                                                 name:@"GetUser" object:nil];
}


- (void) receivedLoadUser
{
    NSLog(@"in receivedLoadUser");
    if(self.user.strReply != nil)
    {
        [alert dismissViewControllerAnimated:YES completion:nil];
        [self performSegueWithIdentifier:@"LogIn" sender:nil];
        NSLog(@"Log in success");
    }else{
                    UIAlertView *notPermitted =[[UIAlertView alloc]
                                                initWithTitle:@"Alert"
                                                message:@"User ID not valid"
                                                delegate:nil
                                                cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [notPermitted show];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"In segue");

    if([segue.identifier isEqualToString:@"LogIn"])
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
- (void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES];

}


@end
