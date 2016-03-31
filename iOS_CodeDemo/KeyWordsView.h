//
//  KeyWordsView.h
//  firstNursingWorkers
//
//  Created by mac book on 16/3/16.
//  Copyright © 2016年 HB. All rights reserved.
//
/**
 *  备注：
 *  凡是设置数字的属性，均存为NSNumber
 */

/**
 *  字体，默认14号
 */
static NSString * const KWAttributesFont = @"KWAttributesFont";
/**
 *  label背景颜色，默认白色
 */
static NSString * const KWAttributesBackgroundColor = @"KWAttributesBackgroundColor";
/**
 *  label字体颜色，默认黑色
 */
static NSString * const KWAttributesTextColor = @"KWAttributesTextColor";
/**
 *  规则列设置，默认为0，默认状态下label按字符长度设置宽度
 */
static NSString * const KWAttributesColumn = @"KWAttributesColumn";
/**
 *  label左右内边距，默认0
 */
static NSString * const KWAttributesInsidePadding = @"KWAttributesInsidePadding";
/**
 *  label左右外边距，默认0
 */
static NSString * const KWAttributesOutsideMargin = @"KWAttributesOutsideMargin";
/**
 *  label行高，不设置，默认为根据字体计算的行高
 */
static NSString * const KWAttributesLineHeight = @"KWAttributesLineHeight";
/**
 *  行间距，默认0
 */
static NSString * const KWAttributesLineSpacing = @"KWAttributesLineSpacing";
/**
 *  控件的最大宽度，默认屏幕宽
 */
static NSString * const KWAttributesMaxWidth = @"KWAttributesMaxWidth";
/**
 *  label的圆角，默认是0
 */
static NSString * const KWAttributesRadious = @"KWAttributesRadious";
/**
 *  label的对齐方式，默认是左对齐
 */
static NSString * const KWAttributesTextAlignment = @"KWAttributesTextAlignment";








#import <UIKit/UIKit.h>

@interface KeyWordsView : UIView
/**
 *  字符串数组
 */
@property (nonatomic, strong) NSArray<NSString *> *keyWords;
//注：字符串长度如果超过控件宽度，会出现排版错误

/**
 *  设置label属性
 *  现在仅添加了背景颜色，字体颜色
 */
@property (nonatomic, strong) NSDictionary<NSString *, id> *attributes;
/**
 *  文本边框圆角，默认0
 */
@property (nonatomic) CGFloat radious;
/**
 *  根据字符串数组获取行数
 */
+ (CGFloat)getHeight:(NSArray<NSString *>*)arr attributes:(NSDictionary<NSString *, id>*)attributes;
@end
