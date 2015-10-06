//
//  VehicleDetail.h
//  CarShare
//
//  Created by guild on 10/2/2558 BE.
//  Copyright © 2558 ssd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Vehicle.h"
@interface VehicleDetail : NSObject<NSURLConnectionDataDelegate>
{
    NSMutableData* receivedData; 
}
@property (strong, nonatomic) User * user;
@property(nonatomic, copy) NSString* vehicleId;
@property(nonatomic, copy) NSString* siteURLString;

@property(nonatomic, copy) NSString* ownerId;
@property(nonatomic, copy) NSString* ownerFullName;
@property(nonatomic, copy) NSString* ownerMailAddress;
@property(nonatomic, copy) NSString* ownerPictureUrl;
@property(nonatomic, copy) NSString* rentalPrice;
@property(nonatomic, copy) NSString* mileageLimit;
@property(nonatomic, copy) NSString* descript;
@property(nonatomic, copy) NSString* vin;
@property(nonatomic, copy) NSString* odometer;
@property(nonatomic, copy) NSString* shareStatus;
@property(nonatomic, copy) NSString* evaluation;

-(void)getInfo:(User *)user WithVehicleID:(NSString *)vehicleid;






-(id)initWithUser:(User*)user WithVehicleID:(NSString*)vehicleid;

@end
