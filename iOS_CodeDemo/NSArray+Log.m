//
//  NSArray+Log.m
//  mapTest
//
//  Created by mac book on 16/1/5.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)
/**
 *  控制台输出，中文编码为utf-8
 */
- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@")"];
    
    return strM;
}
@end
