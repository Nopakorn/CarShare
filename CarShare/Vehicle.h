//
//  Vehicle.h
//  CarShare
//
//  Created by guild on 9/29/2558 BE.
//  Copyright © 2558 ssd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Vehicle : NSObject <NSURLConnectionDataDelegate>
{
    NSMutableData* receivedData;
}
@property (strong, nonatomic) User * user;
@property(nonatomic, copy) NSString* siteURLString;
@property(nonatomic, retain) NSDictionary *vehicleList;

@property(nonatomic, retain) NSMutableArray *vehicleModel;
@property(nonatomic, retain) NSMutableArray *vehicleMaker;

-(id)initWithUser:(User*)user;
-(void) getListVehicle;

@end
