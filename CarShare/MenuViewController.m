//
//  MenuViewController.m
//  CarShare
//
//  Created by guild on 9/25/2558 BE.
//  Copyright © 2558 ssd. All rights reserved.
//

#import "MenuViewController.h"

@implementation MenuViewController
- (void) viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedUser)
                                                 name:@"LoadUser" object:nil];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

-(void) receivedUser
{
    NSLog(@"mrnu view strReply:%@",self.user.strReply);
}
@end
