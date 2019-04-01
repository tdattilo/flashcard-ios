//
//  WebPulls.m
//  LingFlash
//
//  Created by Thomas Dattilo on 2/26/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebPulls.h"

@interface WebPulls()
@end
@implementation WebPulls

+ (NSURLSessionDataTask *)singlePostCall:(NSDictionary *)parameters fromURL:(NSString *)url completionHandler:(void (^)(NSDictionary *responseDictionary, NSError *error))completionHandler {
    
    NSURL *urlPut = [NSURL URLWithString:url];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlPut];
    NSURLSession *session = [NSURLSession sharedSession];
    NSError *jsonError;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters
                                                       options:NSJSONWritingSortedKeys error:&jsonError];
    NSString *requestParameters = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", requestParameters);
    NSString *post = [NSString stringWithFormat:@"%@",requestParameters];
    NSLog(@"%@", post);
    NSData *postData = [post dataUsingEncoding:NSUTF16StringEncoding allowLossyConversion:NO];
    NSLog(@"%@", [[NSString alloc] initWithData:postData encoding:NSUTF16StringEncoding]);
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:@"text/html; charset=UTF-16" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:postData];
    //NSLog(@"%@", urlRequest);
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"Got to completion handler");
        if (completionHandler) {
            if (error) {
                NSLog(@"Got an error");
                completionHandler(nil, error);
            } else {
                NSError *parseError = nil;
                //if(data!=nil){
                    //NSLog(@"Data is not nil");
                //}
                //if([data length]!=0){
                    //NSLog(@"Data length is not zero");
                    
                //}
                NSLog(@"Got to parsing");
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                /*if([[responseDictionary allKeys] count]>0){
                    NSLog(@"JSON Results not empty. Number of keys: %lu", [[responseDictionary allKeys] count]);
                }*/
                for(NSString* key in responseDict){
                    NSLog(@"%@ = %@", key, responseDict[key]);
                }
                completionHandler(responseDict, parseError);
            }
        }
    }];
    
    [dataTask resume];
    
    return dataTask;
}

+ (NSURLSessionDataTask *)postCall:(NSDictionary *)parameters fromURL:(NSString *)url completionHandler:(void (^)(NSMutableArray *responseArray, NSError *error))completionHandler {
    
    NSURL *urlPut = [NSURL URLWithString:url];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlPut];
    NSURLSession *session = [NSURLSession sharedSession];
    NSError *jsonError;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters
                                                       options:NSJSONWritingSortedKeys error:&jsonError];
    NSString *requestParameters = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", requestParameters);
    NSString *post = [NSString stringWithFormat:@"%@",requestParameters];
    NSLog(@"%@", post);
    NSData *postData = [post dataUsingEncoding:NSUTF16StringEncoding allowLossyConversion:NO];
    NSLog(@"%@", [[NSString alloc] initWithData:postData encoding:NSUTF16StringEncoding]);
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:@"text/html; charset=UTF-16" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:postData];
    //NSLog(@"%@", urlRequest);

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Got to completion handler");
        if (completionHandler) {
            if (error) {
                NSLog(@"Got an error");
                completionHandler(nil, error);
            } else {
                NSError *parseError = nil;
                NSMutableArray *responseArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseError];
                completionHandler(responseArray, parseError);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Data Task Successful" object:nil];
            }
        }
    }];
    
    [dataTask resume];
    
    return dataTask;
}
+ (NSURLSessionDataTask *)multiPostCall:(NSArray *)parameters fromURL:(NSString *)url completionHandler:(void (^)(NSMutableArray *responseArray, NSError *error))completionHandler {
    
    NSURL *urlPut = [NSURL URLWithString:url];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlPut];
    NSURLSession *session = [NSURLSession sharedSession];
    NSError *jsonError;
    
    NSString *fullRequestParameters = [[NSString alloc] init];
    NSString *post;
    for(int i = 0; i<[parameters count]; i++){
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters[i]
                                                       options:NSJSONWritingSortedKeys error:&jsonError];
        NSString *requestParameters = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", requestParameters);
        post = [NSString stringWithFormat:@"%@",requestParameters];
        if(i!=[parameters count]-1){
            post=[post stringByAppendingString:@","];
        }
        NSLog(@"%@", post);
        fullRequestParameters=[fullRequestParameters stringByAppendingString:post];
    }
    fullRequestParameters = [[@"{\"data\":[" stringByAppendingString:fullRequestParameters] stringByAppendingString:@"]}"];
    NSData *postData = [fullRequestParameters dataUsingEncoding:NSUTF16StringEncoding allowLossyConversion:NO];
    NSLog(@"%@", [[NSString alloc] initWithData:postData encoding:NSUTF16StringEncoding]);
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:@"text/html; charset=UTF-16" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:postData];
    //NSLog(@"%@", urlRequest);
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Got to completion handler");
        if (completionHandler) {
            if (error) {
                NSLog(@"Got an error");
                completionHandler(nil, error);
            } else {
                NSError *parseError = nil;
                NSMutableArray *responseArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseError];
                completionHandler(responseArray, parseError);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Data Task Successful" object:nil];
            }
        }
    }];
    
    [dataTask resume];
    
    return dataTask;
}
@end
