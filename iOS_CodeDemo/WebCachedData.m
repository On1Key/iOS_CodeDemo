//
//  WebCachedData.m
//  RSA
//
//  Created by mac book on 16/8/11.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "WebCachedData.h"

static NSString *const kDataKey =@"data";
static NSString *const kResponseKey =@"response";
static NSString *const kRedirectRequestKey =@"redirectRequest";
static NSString *const kDateKey =@"date";

@implementation WebCachedData

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[self data] forKey:kDataKey];
    [aCoder encodeObject:[self response] forKey:kResponseKey];
    [aCoder encodeObject:[self redirectRequest] forKey:kRedirectRequestKey];
    [aCoder encodeObject:[self date] forKey:kDateKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self !=nil) {
        [self setData:[aDecoder decodeObjectForKey:kDataKey]];
        [self setResponse:[aDecoder decodeObjectForKey:kResponseKey]];
        [self setRedirectRequest:[aDecoder decodeObjectForKey:kRedirectRequestKey]];
        [self setDate:[aDecoder decodeObjectForKey:kDateKey]];
    }
    
    return self;
}

@end

