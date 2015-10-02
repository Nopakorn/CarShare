//
//  MenuViewController.h
//  CarShare
//
//  Created by guild on 9/25/2558 BE.
//  Copyright © 2558 ssd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "ListVehicleViewController.h"

@interface MenuViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIWebViewDelegate>
{
    NSMutableArray *menuTable;
    IBOutlet UIWebView *imageWebView;
    IBOutlet UIImageView *profileWebView;
}
@property (strong, nonatomic) User * user;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property(weak, nonatomic) IBOutlet UITableView *menuTableView;
//@property(weak, nonatomic) IBOutlet UIWebView *imageWebView;


-(IBAction)doSettingMenu:(id)sender;

@end
