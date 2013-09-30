#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VENDefines.h"
#import "VENLoginViewController.h"

@protocol VENClientDelegate;

@interface VENClient : NSObject

@property (readonly, nonatomic, strong) NSURL *baseURL;
@property (readonly, nonatomic, strong) NSOperationQueue *operationQueue;
@property (readonly, nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) id<VENClientDelegate> delegate;

- (id)initWithAccessToken:(NSString *)accessToken;

- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
completionHandler:(void(^)(NSURLResponse *response, NSDictionary *json, NSError *connectionError))handler;

- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
completionHandler:(void(^)(NSURLResponse *response, NSDictionary *json, NSError *connectionError))handler;

@end

@protocol VENClientDelegate

- (void)request:(NSURLRequest *)request didFailWithAuthenticationError:(NSError *)error;

@end