//
//  ListVehicleViewController.m
//  CarShare
//
//  Created by guild on 9/29/2558 BE.
//  Copyright © 2558 ssd. All rights reserved.
//

#import "ListVehicleViewController.h"
#import "VehicleListCell.h"
@implementation ListVehicleViewController


- (void)viewDidLoad {
    
    NSLog(@"%@",self.user.username);
    
    if(self.vehicle.vehicleList == nil)
    {
        self.vehicle = [[Vehicle alloc] initWithUser:self.user];
        self.vehicleModelList = [NSMutableArray arrayWithCapacity:10];
        [self.vehicle getListVehicle];
        
        alert = [UIAlertController alertControllerWithTitle:nil message:@"Loading\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.center = CGPointMake(130.5, 65.5);
        spinner.color = [UIColor blackColor];
        [alert.view addSubview:spinner];
        [spinner startAnimating];
        [self presentViewController:alert animated:NO completion:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LoadListVehicle" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receivedListVehicle)
                                                     name:@"LoadListVehicle" object:nil];
    }else{
        
         [self dismissViewControllerAnimated:YES completion:nil];
         //[self.listTableView reloadData];
    }
    
   

    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [super viewDidLoad];
    
}
-(void)receivedListVehicle
{
    
    self.vehiclePictureUrl = [NSMutableArray arrayWithCapacity:10];
    NSArray *vehiclePic = self.vehicle.vehicleList[@"Vehicles"];

    for(NSDictionary* query in vehiclePic)
    {

        NSArray *x = query[@"VehiclePictures"][@"PicturesCollection"];

        if (x == nil || [x count] == 0) {
            NSNull *none = [NSNull null];
            [self.vehiclePictureUrl addObject:none];
            
        }else{
            
            [self.vehiclePictureUrl addObject:x];
        }
    }
    
    NSLog(@"count %lu",(unsigned long)[self.vehiclePictureUrl count]);
    [self.listTableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.vehicle.vehicleModel count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    VehicleListCell *cell =(VehicleListCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell ==nil) {
        cell = [[VehicleListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.tag = indexPath.row;
    cell.imageView.image = nil;
    
    if([self.vehiclePictureUrl objectAtIndex:indexPath.row] != [NSNull null]){
    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[[self.vehiclePictureUrl objectAtIndex:indexPath.row] objectAtIndex:0] objectForKey:@"Url"]]];
            
            if(data){
                UIImage* imageVehicle = [UIImage imageWithData:data];
                if (imageVehicle) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UITableViewCell *updateCell = [self.listTableView cellForRowAtIndexPath:indexPath];
                        if (updateCell) {
                            updateCell.imageView.image = imageVehicle;
                            [updateCell setNeedsLayout];
                        }
                    });
                }
            }
        });
    }
    
    cell.title.text = [self.vehicle.vehicleMaker objectAtIndex:indexPath.row];
    cell.detail.text = [self.vehicle.vehicleModel objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSDictionary* detail = [self.vehicle.vehicleList[@"Vehicles"] objectAtIndex:[self.listTableView indexPathForSelectedRow].row];
    
    VehicleDetailViewController *dest = [segue destinationViewController];
    dest.detail = detail;
    dest.user = self.user;
    [self.tableView deselectRowAtIndexPath:[self.listTableView indexPathForSelectedRow] animated:YES];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    
    //[self.navigationController setNavigationBarHidden:YES];
    
}

@end
