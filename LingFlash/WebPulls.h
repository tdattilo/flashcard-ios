//
//  WebPulls.h
//  LingFlash
//
//  Created by Thomas Dattilo on 2/26/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#ifndef WebPulls_h
#define WebPulls_h
@interface WebPulls : NSObject

+ (NSURLSessionDataTask *)singlePostCall:(NSDictionary *)parameters fromURL:(NSString *)url completionHandler:(void (^)(NSDictionary *responseDict, NSError *error))completionHandler;

+ (NSURLSessionDataTask *)postCall:(NSDictionary *)parameters fromURL:(NSString *)url completionHandler:(void (^)(NSMutableArray *responseArray, NSError *error))completionHandler;
+ (NSURLSessionDataTask *)multiPostCall:(NSArray *)parameters fromURL:(NSString *)url completionHandler:(void (^)(NSMutableArray *responseArray, NSError *error))completionHandler;
@end
#endif /* WebPulls_h */
