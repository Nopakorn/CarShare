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
    self.user.deviceToken = deviceTokenStr;
    
    //You need to get input from user
    //[self.user setUsername:@"TEST" withPassword:@"TEST"];
    [self.user setUsername:self.textUserName.text withPassword:self.textPassword.text];
    
    alert = [UIAlertController alertControllerWithTitle:nil message:@"Loading\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake(130.5, 65.5);
    spinner.color = [UIColor blackColor];
    [alert.view addSubview:spinner];
    [spinner startAnimating];
    [self presentViewController:alert animated:NO completion:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GetUser" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedLoadUser)
                                                 name:@"GetUser" object:nil];
}


- (void) receivedLoadUser
{
    NSLog(@"in receivedLoadUser %@: STATUS:%@",self.user.strReply,self.user.responseResult);
    if([self.user.responseResult isEqualToString:@"200"])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"LogIn" sender:nil];
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
        NSLog(@"Log in success");
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
            UIAlertView *notPermitted =[[UIAlertView alloc]
                                        initWithTitle:@"Alert"
                                        message:@"User ID not valid"
                                        delegate:nil
                                        cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [notPermitted show];
        });
        
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
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
    self.textUserName.text = @"";
    self.textPassword.text = @"";
    [self.navigationController setNavigationBarHidden:YES];

}


@end
