//
//  KeyWordsView.h
//  firstNursingWorkers
//
//  Created by mac book on 16/3/16.
//  Copyright © 2016年 HB. All rights reserved.
//





#import <UIKit/UIKit.h>

@interface KeyWordsView : UIView
/**
 *  字符串数组
 */
@property (nonatomic, strong) NSArray<NSString *> *keyWords;
/**
 *  规则的/Users/macbook/Desktop/UsersClient/firstNursingWorkers/Classes/Home/View/KeyWordsView.m列设置
 *  如果不设置这个参数，默认是按字符串长度设置label长度
 */
@property (nonatomic) int column;
/**
 *  文字对齐方式，默认左对齐
 */
@property (nonatomic) NSTextAlignment textAlignment;
/**
 *  设置label属性
 *  现在仅添加了背景颜色，字体颜色
 */
@property (nonatomic, strong) NSDictionary *attributes;
/**
 *  文本边框圆角，默认0
 */
@property (nonatomic) CGFloat radious;
/**
 *  根据字符串数组获取行数
 */
+ (CGFloat)getHeight:(NSArray<NSString *>*)arr column:(int)column;
+ (CGFloat)getHeight:(NSArray<NSString *>*)arr
              column:(int)column
                font:(UIFont*)font
             padding:(CGFloat)padding
              margin:(CGFloat)margin
        maxSubHeight:(CGFloat)maxHeight
            maxWidth:(CGFloat)maxWidth;
@end
