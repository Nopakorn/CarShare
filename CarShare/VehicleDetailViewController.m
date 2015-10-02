//
//  VehicleDetailViewController.m
//  CarShare
//
//  Created by guild on 10/2/2558 BE.
//  Copyright © 2558 ssd. All rights reserved.
//

#import "VehicleDetailViewController.h"
#import "VehicleDetailCell.h"

@implementation VehicleDetailViewController
@synthesize coordinate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) coord{
    coordinate=coord;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.vehicleDetail = [[VehicleDetail alloc] init];
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    self.mapview.delegate = self;
    self.mapview.hidden = YES;
    if([self.detail objectForKey:@"Lat"] != [NSNull null]|| [self.detail objectForKey:@"Lon"] != [NSNull null]){
        self.mapview.hidden = NO;
        [self loadMapView];
    }
    [self getInfo];
    itemTable = [[NSMutableArray alloc] initWithObjects:@"Id",@"Fullname",@"MailAddress", nil];
    self.detailTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(void) getInfo
{
   
    NSString *vehicleId = [NSString stringWithFormat:@"%@",[self.detail objectForKey:@"VehicleId"]];
     NSLog(@"GET INFO %@",vehicleId);
    //self.vehicleDetail = [self.vehicleDetail initWithUser:self.user WithVehicleID:vehicleId];
    [self.vehicleDetail getInfo:self.user WithVehicleID:vehicleId];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedVehicleInfo)
                                                 name:@"LoadInfo" object:nil];
}

-(void)receivedVehicleInfo
{
    //NSLog(@"received info:%@",self.vehicleDetail.ownerId);
    [self.detailTableView reloadData];
}

-(void) loadMapView
{
    coordinate.latitude = [[self.detail objectForKey:@"Lat"] doubleValue];
    coordinate.longitude = [[self.detail objectForKey:@"Lon"] doubleValue];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, 0.001, 0.001);
    viewRegion.span.latitudeDelta = 0.005;
    viewRegion.span.longitudeDelta = 0.005;
    
    [self.mapview setRegion:[self.mapview regionThatFits:viewRegion] animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = coordinate;
    point.title = [self.detail objectForKey:@"Maker"];
    point.subtitle = [self.detail objectForKey:@"Model"];
    [self.mapview addAnnotation:point];

}


- (NSString *)subtitle{
    return nil;
}

- (NSString *)title{
    return nil;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"VehicleDetailCell";
    VehicleDetailCell *cell = (VehicleDetailCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell ==nil) {
        NSArray *nib =[[NSBundle mainBundle] loadNibNamed:@"VehicleDetailCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.item.text = [itemTable objectAtIndex:indexPath.row];

//    if(indexPath.row == 0){
//        cell.value.text = self.vehicleDetail.ownerId;
//    }
//    if(indexPath.row == 1){
//        cell.value.text = self.vehicleDetail.ownerFullName;
//    }
    switch (indexPath.row) {
        case 0:
            cell.value.text = self.vehicleDetail.ownerId;
            break;
        case 1:
            cell.value.text = self.vehicleDetail.ownerFullName;
            break;
        case 2:
            cell.value.text = self.vehicleDetail.ownerMailAddress;
            break;            
        default:
            break;
    }
    return cell;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
