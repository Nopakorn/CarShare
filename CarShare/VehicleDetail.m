//
//  VehicleDetail.m
//  CarShare
//
//  Created by guild on 10/2/2558 BE.
//  Copyright © 2558 ssd. All rights reserved.
//

#import "VehicleDetail.h"

@implementation VehicleDetail

-(id)init
{
    if(self = [super init]){
        self.siteURLString = [NSString stringWithFormat:@"http://otr-carsharing.azurewebsites.net/api/vehicles"];
    }
    return self;
}

-(void)getInfo:(User *)user WithVehicleID:(NSString *)vehicleid
{
    self.user = user;
    self.vehicleId = vehicleid;
    [self loadInfo];
}
-(void)loadInfo
{
    NSLog(@"LOAD INFO%@",self.vehicleId);
    NSString* urlString = [NSString stringWithFormat:@"%@/%@",self.siteURLString,self.vehicleId];
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    [req setHTTPMethod:@"GET"];
    [req setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setValue:self.user.username forHTTPHeaderField:@"Authorization"];
    
    NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    
    if(conn)
    {
        receivedData = [NSMutableData data];
    }
    else
        NSLog(@"error");
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    NSLog(@"got response Status:%d",code);
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary* res = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
    
    self.ownerId = [[res objectForKey:@"OwnerId"] stringValue];
    self.ownerFullName = [res objectForKey:@"OwnerFullName"];
    self.ownerMailAddress = [res objectForKey:@"OwnerMailAddress"];
    self.ownerPictureUrl = [res objectForKey:@"OwnerPictureUrl"];
    self.rentalPrice = [[res objectForKey:@"RentalPrice"] stringValue];
    
    if ([res objectForKey:@"MileageLimit"] != [NSNull null]) {
        self.mileageLimit = [[res objectForKey:@"MileageLimit"] stringValue];
    }
    
    self.descript = [res objectForKey:@"Description"];
    self.vin = [res objectForKey:@"Vin"];
    self.shareStatus = [[res objectForKey:@"VehicleShareStatus"] stringValue];
    self.evaluation = [[res objectForKey:@"EvaluationAverage"] stringValue];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadInfo" object:self];
}


@end
