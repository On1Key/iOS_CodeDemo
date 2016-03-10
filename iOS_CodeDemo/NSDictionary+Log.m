//
//  NSDictionary+Log.m
//  mapTest
//
//  Created by mac book on 16/1/5.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)
/**
 *  控制台输出，中文编码为utf-8
 */
- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}
@end
