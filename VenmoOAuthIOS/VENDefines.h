typedef NS_ENUM(NSInteger, VENResponseType) {
    VENResponseTypeToken,
    VENResponseTypeCode
};

typedef NS_OPTIONS(NSUInteger, VENAccessScope) {
    VENAccessScopeNone                  = 0,
    VENAccessScopeFeed                  = 1 << 0,
    VENAccessScopeProfile               = 1 << 1,
    VENAccessScopeFriends               = 1 << 2,
    VENAccessScopePayments              = 1 << 3,
};

#define BASE_URL @"https://venmo.com/"
#define API_BASE_URL @"https://api.venmo.com/"

// testing
#define CLIENT_ID @"1405"
#define CLIENT_SECRET @"H537ZNzLZufvwApCbgQEpqhBYjBjbmtD"
#define SCOPES VENAccessScopeFriends | VENAccessScopeProfile | VENAccessScopeFriends | VENAccessScopePayments
#define REDIRECT_URL [NSURL URLWithString:@"http://strangelines.com"]
