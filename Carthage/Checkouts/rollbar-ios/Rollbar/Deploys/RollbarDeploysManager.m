//  Copyright © 2018 Rollbar. All rights reserved.

#import <UIKit/UIKit.h>
#include <sys/utsname.h>
#import "NSJSONSerialization+Rollbar.h"
#import "RollbarDeploysManager.h"

#define IS_IOS7_OR_HIGHER (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)

@interface RollbarDeploysManager()
@property (readwrite, retain) NSString *writeAccessToken;
@property (readwrite, retain) NSString *readAccessToken;
@end

@implementation RollbarDeploysManager

- (id)initWithWriteAccessToken:(NSString *)writeAccessToken
               readAccessToken:(NSString *)readAccessToken
deploymentRegistrationObserver:(NSObject<DeploymentRegistrationObserver>*)deploymentRegistrationObserver
     deploymentDetailsObserver:(NSObject<DeploymentDetailsObserver>*)deploymentDetailsObserver
 deploymentDetailsPageObserver:(NSObject<DeploymentDetailsPageObserver>*)deploymentDetailsPageObserver {
    self = [super init];
    if (nil != self) {
        self.writeAccessToken = writeAccessToken;
        self.readAccessToken = readAccessToken;
        _deploymentRegistrationObserver = deploymentRegistrationObserver;
        _deploymentDetailsObserver = deploymentDetailsObserver;
        _deploymentDetailsPageObserver = deploymentDetailsPageObserver;
    }
    return self;
}

- (id)init {
    return [self initWithWriteAccessToken:nil
                          readAccessToken:nil
           deploymentRegistrationObserver:nil
                deploymentDetailsObserver:nil
            deploymentDetailsPageObserver:nil
            ];
}

- (void)getDeploymentWithDeployId:(NSString *)deployId {
    NSString * const url =
        @"https://api.rollbar.com/api/1/deploy/";
    NSString * const getUrl =
        [NSString stringWithFormat:@"%@%@/?access_token=%@",url,deployId,self.readAccessToken];
    [self sendGetRequestToUrl:getUrl];
}

- (void)getDeploymentsPageNumber:(NSUInteger)pageNumber {
    NSString * const url =
        @"https://api.rollbar.com/api/1/deploys/";
    NSString * const getUrl =
        [NSString stringWithFormat:@"%@?access_token=%@&page=%lu",url,self.readAccessToken,(unsigned long)pageNumber];
    [self sendGetRequestToUrl:getUrl];
}

- (void)registerDeployment:(Deployment *)deployment {
    NSString * const url =
        @"https://api.rollbar.com/api/1/deploy/";
    NSMutableDictionary *params =
        [[NSMutableDictionary alloc] initWithDictionary:deployment.asJSONData];
    [params setObject:self.writeAccessToken
               forKey:@"access_token"
     ];
    [self sendPostRequest:params
                    toUrl:url
     ];
}

-(BOOL)sendGetRequestToUrl:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    __block BOOL result = NO;
    if (IS_IOS7_OR_HIGHER) {
        // This requires iOS 7.0+
        dispatch_semaphore_t sem = dispatch_semaphore_create(0);
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *dataTask =
        [session dataTaskWithRequest:request
                   completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                       result = [self checkResponse:response error:error data:data forRequest:request];
                       dispatch_semaphore_signal(sem);
                   }];
        [dataTask resume];
        
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    } else {
        // Using method sendSynchronousRequest, deprecated since iOS 9.0
        NSError *error;
        NSHTTPURLResponse *response;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        result = [self checkResponse:response error:error data:data forRequest:request];
    }
    
    return result;
}

-(BOOL)sendPostRequest:(NSDictionary *)params toUrl:(NSString *)urlString {

    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[params valueForKey:@"access_token"] forHTTPHeaderField:@"X-Rollbar-Access-Token"];
    
    NSData *jsonPayload = [NSJSONSerialization dataWithJSONObject:params
                                                          options:NSJSONWritingPrettyPrinted
                                                            error:nil
                                                             safe:true
                           ];
    [request setHTTPBody:jsonPayload];
    
    __block BOOL result = NO;
    if (IS_IOS7_OR_HIGHER) {
        // This requires iOS 7.0+
        dispatch_semaphore_t sem = dispatch_semaphore_create(0);
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *dataTask =
        [session dataTaskWithRequest:request
                   completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                       result = [self checkResponse:response error:error data:data forRequest:request];
                       dispatch_semaphore_signal(sem);
                   }];
        [dataTask resume];
        
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    } else {
        // Using method sendSynchronousRequest, deprecated since iOS 9.0
        NSError *error;
        NSHTTPURLResponse *response;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        result = [self checkResponse:response error:error data:data forRequest:request];
    }
    
    return result;
}

- (BOOL)checkResponse:(NSURLResponse*)response
                error:(NSError*)error
                 data:(NSData*)data
           forRequest:(NSMutableURLRequest*)request {
    
    if ((nil == request) || (nil == request.URL)) {
        return NO;
    }
    
    NSString *requestHttpMethod = request.HTTPMethod;
    NSString *requestUrl = request.URL.absoluteString;
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    
    if (([requestHttpMethod caseInsensitiveCompare:@"POST"] == NSOrderedSame)
        && [requestUrl hasSuffix:@"/deploy/"]
        && (nil != _deploymentRegistrationObserver)
        ) {
        DeploymentRegistrationResult *result =
        [[DeploymentRegistrationResult alloc] initWithResponse:httpResponse
                                                          data:data
                                                         error:error
                                                    forRequest:request];
        [_deploymentRegistrationObserver onRegisterDeploymentCompleted:result];
    }
    else if (([requestHttpMethod caseInsensitiveCompare:@"GET"] == NSOrderedSame)
             && [requestUrl containsString:@"/deploy/"]
             && (nil != _deploymentDetailsObserver)
             ) {
        DeploymentDetailsResult *result =
        [[DeploymentDetailsResult alloc] initWithResponse:httpResponse
                                                     data:data
                                                    error:error
                                               forRequest:request];
        [_deploymentDetailsObserver onGetDeploymentDetailsCompleted:result];
    }
    else if (([requestHttpMethod caseInsensitiveCompare:@"GET"] == NSOrderedSame)
             && [requestUrl containsString:@"/deploys/"]
             && (nil != _deploymentDetailsPageObserver)
             ) {
        DeploymentDetailsPageResult *result =
        [[DeploymentDetailsPageResult alloc] initWithResponse:httpResponse
                                                     data:data
                                                    error:error
                                               forRequest:request];
        [_deploymentDetailsPageObserver onGetDeploymentDetailsPageCompleted:result];
    }
    else {
        return NO;
    }

    return YES;
}
@end
