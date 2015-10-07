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

    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationItem.hidesBackButton = YES;
    
    self.username.text = self.user.username;

//    UIImage *user_image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.user.memberPicUrl]]];

//    profileWebView.layer.borderWidth = 1.0f;
//    profileWebView.layer.cornerRadius = 50;
//    profileWebView.layer.masksToBounds = YES;
//    profileWebView.clipsToBounds = YES;
//    profileWebView.image = user_image;
    
//    profileWebView.image = [UIImage imageNamed:@"placeholder.png"];
//    NSLog(@"%@",self.user.memberPicUrl);
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
//        NSLog(@"in load tread: URL %@",self.user.memberPicUrl);
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.user.memberPicUrl]];
//        if (data) {
//            NSLog(@"Load data success");
//            UIImage* user_image =[UIImage imageWithData:data];
//            if (user_image) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSLog(@"back to main");
//                    profileWebView.image = user_image;
//                    NSLog(@"We done");
//                });
//            }
//        }
//    });
    menuTable = [[NSMutableArray alloc] initWithObjects:@"Rent",@"Schedule",@"List my vehicle",@"Manage my vehicle",@"Account", nil];

    self.menuTableView.dataSource =self;
    self.menuTableView.delegate = self;
    
}

-(IBAction)doSettingMenu:(id)sender
{
    UIActionSheet *actionSheet =[[UIActionSheet alloc]
                                 initWithTitle:@"Setting"
                                 delegate:self
                                 cancelButtonTitle:@"Cancel"
                                 destructiveButtonTitle:@"Log out" otherButtonTitles: nil];
    [actionSheet showInView:self.view];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex != [actionSheet cancelButtonIndex]){
//        [self.user setUsername:nil withPassword:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuTable count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Items";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    
    cell.textLabel.text = [menuTable objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *menuSelected = [menuTable objectAtIndex:indexPath.row];
    
    if ([menuSelected isEqualToString:@"List my vehicle"]) {
        
        [self performSegueWithIdentifier:@"ListMyVehicle" sender:self];
    }
    
    
    NSLog(@"Select item:%@",menuSelected);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ListMyVehicle"])
    {
        ListVehicleViewController *dest = [segue destinationViewController];
        dest.user = self.user;

    }
}




@end
