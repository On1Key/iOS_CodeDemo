//
//  NSString+Extension.m
//
//  Created by mac on 16/1/25.
//  Copyright © 2016年 HB. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (BOOL)match:(NSString *)pattern{
    // 1、创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc]initWithPattern:pattern options:0 error:nil];
    
    // 2、测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return results.count>0;
}

- (BOOL)isPhoneNumbber{
    return [self match:@"^1\\d{10}$"];
}


/**
 * 时间戳转日期字符串
 */
+ (NSString *)timeToString:(NSInteger)time format:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}


/**
 * 将数值转换为两位小数字符串
 */
+ (NSString *)stringWithFloatNumber:(NSString *)numString{
    
    CGFloat number = [numString floatValue];
    NSString *string= @"";
    CGFloat floatNumber = number;
    NSUInteger integerNumber = (NSUInteger)number;
    // 小数
    CGFloat lastFloat = floatNumber-integerNumber;
    
    NSMutableArray *array = [NSMutableArray array];
    while (1) {
        if (integerNumber==0) {
            // 如果值为0
            if (lastFloat==0) {
                return @"0.00";
            }else{
                // 如果值为0.12
                return [NSString stringWithFormat:@"%.2f",lastFloat];
            }
        }
        NSUInteger num = integerNumber%1000;
        NSUInteger numNext = integerNumber/1000;
        integerNumber =integerNumber/1000;
        if (numNext==0) {
            [array addObject:[NSString stringWithFormat:@"%ld",(unsigned long)num]];
            break;
            
        }else{
            [array addObject:[NSString stringWithFormat:@"%03ld",(unsigned long)num]];
        }
        
    }
    for (NSInteger i=array.count-1; i >= 0; i--) {
        if (i==array.count-1) {
            string = [NSString stringWithFormat:@"%@",(NSString *)array[i]];
        }else{
            string = [NSString stringWithFormat:@"%@,%@",string,(NSString *)array[i]];
        }
    }
    // 判断是否是小数
    if (lastFloat==0) {
        return [NSString stringWithFormat:@"%@.00",string];
    }else{
        NSArray *comArray = [[NSString stringWithFormat:@"%.2f",lastFloat] componentsSeparatedByString:@"."];
        string = [NSString stringWithFormat:@"%@.%@",string,(NSString *)comArray[1]];
        return string;
    }
}
@end
