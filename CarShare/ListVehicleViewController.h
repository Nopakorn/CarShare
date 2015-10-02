//
//  ListVehicleViewController.h
//  CarShare
//
//  Created by guild on 9/29/2558 BE.
//  Copyright © 2558 ssd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Vehicle.h"
#import "VehicleDetailViewController.h"

@interface ListVehicleViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIAlertController *alert;
    UIImage *imageCar;
}
@property (nonatomic) NSMutableArray  * vehicleMakerList;
@property (nonatomic) NSMutableArray  * vehicleModelList;
@property (nonatomic) NSMutableArray  * vehiclePictureUrl;

@property (strong, nonatomic) User * user;
@property (strong, nonatomic) Vehicle * vehicle;
//@property (strong, nonatomic) VehicleDetail * vehicleDetail;

@property(weak, nonatomic) IBOutlet UITableView *listTableView;
@property(weak, nonatomic) IBOutlet UIWebView *webView;

@end
