//
//  UIImage+Color.h
//  StockRadar
//
//  Created by StockRadar on 14-6-30.
//  Copyright (c) 2014年 Donald. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;

/**
 *  画圆角图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius;

/**
 *  画矩形图片
 */
+ (UIImage *)imageWithRectEdgeColor:(UIColor *)color RectSize:(CGSize)size radius:(CGFloat)radius andLineWidth:(CGFloat)lineWidth;
@end
