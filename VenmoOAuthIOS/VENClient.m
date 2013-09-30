#import "VENClient.h"
#import "VENLoginViewController.h"

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

@interface VENClient ()

@property (readwrite, nonatomic, strong) NSURL *baseURL;
@property (readwrite, nonatomic, strong) NSOperationQueue *operationQueue;
@property (readwrite, nonatomic, strong) NSString *accessToken;

@end

@implementation VENClient

- (id)initWithAccessToken:(NSString *)accessToken
{
    self = [super init];
    if (self) {
        self.baseURL = [NSURL URLWithString:API_BASE_URL];
        self.accessToken = accessToken;
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.operationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    }
    return self;
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

    NSMutableDictionary *tokenDict = [NSMutableDictionary dictionaryWithDictionary:@{@"access_token" : self.accessToken}];
    if (!parameters) {
        parameters = tokenDict;
    } else {
        [tokenDict addEntriesFromDictionary:parameters];
        parameters = tokenDict;
    }
    NSString *paramString = queryStringFromParameters(parameters);

    NSError *error = nil;
    NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));

    if ([method isEqualToString:@"GET"] || [method isEqualToString:@"HEAD"] || [method isEqualToString:@"DELETE"]) {
        url = [NSURL URLWithString:[[url absoluteString] stringByAppendingFormat:[path rangeOfString:@"?"].location == NSNotFound ? @"?%@" : @"&%@", paramString]];
    } else {
        [request setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error]];

    }

    [request setURL:url];

    if (error) {
        NSLog(@"%@ %@: %@", [self class], NSStringFromSelector(_cmd), error);
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
                                   if (error.domain == NSURLErrorDomain
                                       && error.code == NSURLErrorUserCancelledAuthentication) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           [self.delegate request:request didFailWithAuthenticationError:error];
                                       });
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   handler(response,json,error);
                               });
                           }];
}

- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
completionHandler:(void(^)(NSURLResponse *response, NSDictionary *json, NSError *connectionError))handler
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:parameters];
    [self sendAsyncRequest:request completionHandler:handler];
}

- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
completionHandler:(void(^)(NSURLResponse *response, NSDictionary *json, NSError *connectionError))handler
{
    NSURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:parameters];
    [self sendAsyncRequest:request completionHandler:handler];
}


@end
