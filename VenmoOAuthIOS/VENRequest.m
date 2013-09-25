#import "VENRequest.h"

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

@implementation VENRequest

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
