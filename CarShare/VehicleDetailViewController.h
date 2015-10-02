//
//  VehicleDetailViewController.h
//  CarShare
//
//  Created by guild on 10/2/2558 BE.
//  Copyright © 2558 ssd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Mapkit/MKAnnotation.h>
#import "VehicleDetailCell.h"
#import "User.h"
#import "VehicleDetail.h"

@interface VehicleDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MKAnnotation, MKMapViewDelegate>
{
    CLLocationCoordinate2D coordinate;
    NSMutableArray *itemTable;
    
}
@property (strong, nonatomic) User * user;
@property (strong, nonatomic) VehicleDetail * vehicleDetail;
@property(nonatomic,strong) NSDictionary* detail;
@property(weak, nonatomic) IBOutlet UITableView *detailTableView;

@property(strong,nonatomic) IBOutlet MKMapView* mapview;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
- (id)initWithLocation:(CLLocationCoordinate2D)coord;
- (NSString *)subtitle;
- (NSString *)title;

@end
