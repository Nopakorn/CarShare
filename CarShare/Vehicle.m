//
//  Vehicle.m
//  CarShare
//
//  Created by guild on 9/29/2558 BE.
//  Copyright © 2558 ssd. All rights reserved.
//

#import "Vehicle.h"

@implementation Vehicle

-(id)initWithUser:(User *)user
{
    if(self = [super init]){
        //will change later
        self.user = user;
        self.siteURLString = [NSString stringWithFormat:@"http://otr-carsharing.azurewebsites.net/api/vehicles"];
    }
    return self;
}

-(void) getListVehicle
{
    NSString* urlString = [NSString stringWithFormat:@"%@",self.siteURLString];
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
    NSArray* json = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
    NSDictionary* res = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
    
    NSArray* a = res[@"Vehicles"];
    
    self.vehicleModel = [NSMutableArray arrayWithCapacity:10];
    for (NSDictionary* x in a) {
        [self.vehicleModel addObject:x[@"Model"]];
    }
    self.vehicleMaker =[NSMutableArray arrayWithCapacity:10];
    for(NSDictionary* x in a){
        [self.vehicleMaker addObject: x[@"Maker"]];
    }
    
    self.vehicleList = res;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadListVehicle" object:self];
}

@end
