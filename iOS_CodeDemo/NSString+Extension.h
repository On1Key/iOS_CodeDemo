//
//  NSString+Extension.h
//
//  Created by mac on 16/1/25.
//  Copyright © 2016年 HB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 * 匹配正则表达式
 */
- (BOOL)match:(NSString *)pattern;
/**
 * 是否是电话号码
 */
- (BOOL)isPhoneNumbber;

/**
 * 时间戳转日期字符串
 */
+ (NSString *)timeToString:(NSInteger)time format:(NSString *)format;

/**
 * 将数值转换为两位小数字符串
 */
+ (NSString *)stringWithFloatNumber:(NSString *)number;

@end
