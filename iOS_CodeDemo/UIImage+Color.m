//
//  UIImage+Color.m
//  StockRadar
//
//  Created by StockRadar on 14-6-30.
//  Copyright (c) 2014年 Donald. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size

{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,
                                   
                                   color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
    
}

+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  画圆角图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius{
    // 1.开启上下文

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0);
    // 2.获取上下文
    UIGraphicsGetCurrentContext();
    // 3.画圆
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:radius];
    bezierPath.lineWidth = 1.0;
    [color setFill];
    [bezierPath fill];
    // 4.使用BezierPath进行剪切
    [bezierPath addClip];
    
    // 6.从内存中创建新图片对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 7.结束上下文
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  画矩形图片
 */
+ (UIImage *)imageWithRectEdgeColor:(UIColor *)color RectSize:(CGSize)size radius:(CGFloat)radius andLineWidth:(CGFloat)lineWidth{
    // 1.开启上下文
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0);
    // 2.获取上下文
    UIGraphicsGetCurrentContext();
    // 3.画圆
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:radius];
    bezierPath.lineWidth = lineWidth;
    [color setStroke];
    [bezierPath stroke];
    // 4.使用BezierPath进行剪切
    [bezierPath addClip];
    
    // 6.从内存中创建新图片对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 7.结束上下文
    UIGraphicsEndImageContext();
  
    return newImage;
}


@end
