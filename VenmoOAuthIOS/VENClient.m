#import "VENClient.h"
#import "VENAuthViewController_Internal.h"

@interface VENClient ()

@property (readwrite, nonatomic, strong) NSURL *baseURL;
@property (readwrite, nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation VENClient

static NSString * percentEscapedQueryStringFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    static NSString * const kAFCharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    static NSString * const kAFCharactersToLeaveUnescaped = @"[].";

	return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, (__bridge CFStringRef)kAFCharactersToLeaveUnescaped, (__bridge CFStringRef)kAFCharactersToBeEscaped, CFStringConvertNSStringEncodingToEncoding(encoding));
}

NSString *queryStringFromParameters(NSDictionary *parameters) {
    NSMutableArray *mutableQueryStringComponents = [NSMutableArray array];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    for (id key in [parameters.allKeys sortedArrayUsingDescriptors:@[sortDescriptor]]) {
        id value = parameters[key];
        if (value) {
            [mutableQueryStringComponents addObject:[NSString stringWithFormat:@"%@=%@",
                                                     percentEscapedQueryStringFromStringWithEncoding(key, NSUTF8StringEncoding),
                                                     percentEscapedQueryStringFromStringWithEncoding(value, NSUTF8StringEncoding)]];
        }
    }
    return [mutableQueryStringComponents componentsJoinedByString:@"&"];
}

+ (VENClient *)sharedClient
{
    static VENClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] init];
        _sharedClient.baseURL = [NSURL URLWithString:API_BASE_URL];
        _sharedClient.operationQueue = [[NSOperationQueue alloc] init];
        [_sharedClient.operationQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    });
    return _sharedClient;
}

+ (VENAuthViewController *)OAuthViewControllerWithClientID:(NSString *)clientID
                                              clientSecret:(NSString *)clientSecret
                                                    scopes:(VENAccessScope)scopes
                                              responseType:(VENResponseType)responseType
                                               redirectURL:(NSURL *)redirectURL
                                                  delegate:(id<VENAuthViewControllerDelegate>)delegate
{
    VENAuthViewController *authVC = [[VENAuthViewController alloc] initWithClientId:clientID clientSecret:clientSecret scopes:scopes reponseType:responseType redirectURL:redirectURL delegate:delegate];

    return authVC;
}


- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters
{
    NSParameterAssert(method);

    if (!path) {
        path = @"";
    }

    NSURL *url = [NSURL URLWithString:path relativeToURL:self.baseURL];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:method];

    if (parameters) {
        url = [NSURL URLWithString:[[url absoluteString] stringByAppendingFormat:[path rangeOfString:@"?"].location == NSNotFound ? @"?%@" : @"&%@", queryStringFromParameters(parameters)]];
        [request setURL:url];
    } else {
        [request setURL:url];
    }
    
	return request;
}

- (void)sendAsyncRequest:(NSURLRequest *)request
       completionHandler:(void(^)(NSURLResponse *response, NSDictionary *json, NSError *connectionError))handler
{
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:self.operationQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               NSDictionary *json = nil;
                               NSError *error = nil;
                               if (!connectionError){
                                   json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                               } else {
                                   error = connectionError;
                               }
                               handler(response,json,error);
                           }];
}


@end
