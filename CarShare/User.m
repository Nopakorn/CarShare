//
//  User.m
//  CarShare
//
//  Created by guild on 9/25/2558 BE.
//  Copyright © 2558 ssd. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize responseResult;

-(id)init
{
    if(self = [super init]){
        //will change later
       self.siteURLString = [NSString stringWithFormat:@"http://otr-carsharing.azurewebsites.net/api/member"];
    }
    return self;
}

- (void)setUsername:(NSString *)username withPassword:(NSString *) password
{
    NSLog(@"In setUser");
    //[self getMember];
    [self loadUser];
}

- (void) getMember
{
    
    NSLog(@"get member");
    NSString* urlString = [NSString stringWithFormat:@"%@",self.siteURLString];
    NSURL* url = [NSURL URLWithString:urlString];
    NSLog(@"URL check:%@",url);
    
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    [req setHTTPMethod:@"GET"];
    //[req setHTTPBody:[argString dataUsingEncoding:NSUTF8StringEncoding]];
    [req setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setValue:@"Albus" forHTTPHeaderField:@"Authorization"];
    
    NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    
    if(conn)
    {
        receivedData = [NSMutableData data];
    }
    else
        NSLog(@"error");
    
}

- (void) loadUser
{
    NSString* jsonRequest = [NSString stringWithFormat:@"{\"MemberId\":\"albus\",\"Password\":\"Welcome1\",\"DeviceToken\":\"7ab630d5 7bd8a220 3c2837b8 b03c7b34 c0c97451 5312973f d3855e9c 99f0398b\"}"];
    NSLog(@"check: %@",jsonRequest);
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    NSData *requestData =[NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setURL:[NSURL URLWithString:@"http://otr-carsharing.azurewebsites.net/api/member/login"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:[NSString stringWithFormat:@"%d",[requestData length]] forHTTPHeaderField:@"Content-length"];
    [request setHTTPBody:requestData];
    
    NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        int code = [httpResponse statusCode];
        NSLog(@"got response Status:%d",code);
        
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"request reply: %@", requestReply);
        self.strReply = requestReply;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadUser" object:self];
        
    }] resume];

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
    NSLog(@"Success");
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];    
    NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"str:%@",responseString);
    NSLog(@"%@",json);
}

@end
