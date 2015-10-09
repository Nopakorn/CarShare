//
//  User.h
//  CarShare
//
//  Created by guild on 9/25/2558 BE.
//  Copyright © 2558 ssd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSURLConnectionDataDelegate>
{
    NSMutableData* receivedData;
}
@property(nonatomic, copy) NSString* username;
@property(nonatomic, copy) NSString* password;
//REST attibute part
@property(nonatomic, copy) NSString* siteURLString;
@property(nonatomic, copy) NSString* deviceToken;
@property(nonatomic, copy) NSString* strReply;
@property(nonatomic, copy) NSString* memberPicUrl;

@property(nonatomic, copy) NSString* responseResult;
- (id)init;
- (void)setUsername:(NSString *)username withPassword:(NSString *) password;

@end
