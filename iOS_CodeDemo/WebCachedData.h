//
//  WebCachedData.h
//  RSA
//
//  Created by mac book on 16/8/11.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSUInteger const kCacheExpireTime = 600;//缓存的时间 默认设置为600秒

@interface WebCachedData :NSObject <NSCoding>
@property (nonatomic,strong) NSData *data;
@property (nonatomic,strong) NSURLResponse *response;
@property (nonatomic,strong) NSURLRequest *redirectRequest;
@property (nonatomic,strong) NSDate *date;
@end
