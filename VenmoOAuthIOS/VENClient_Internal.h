#import "VENDefines.h"
#import "VENClient.h"

@interface VENClient ()

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters;

@end