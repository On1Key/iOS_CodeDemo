//
//  UIImage+Extension.m
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 HB. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
/**
 *  取消iOS7下的默认渲染模式
 *
 *  @param name 图片名
 */
+ (UIImage *)imageWithName:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    UIImage *newImage = [image  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return newImage;
}


/**
 *  返回一张圆形图片
 */
+ (UIImage *)circleImageWithImage:(UIImage *)image
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor{
    // 1.开启上下文
    CGFloat imageWidth = image.size.width+2*borderWidth;
    CGFloat imageHeight = image.size.height+2*borderWidth;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), NO, 0);
    // 2.获取上下文
    UIGraphicsGetCurrentContext();
    // 3.画圆
    CGFloat radius = MIN(image.size.width*0.5, image.size.height*0.5);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageWidth*0.5, imageHeight*0.5) radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    bezierPath.lineWidth = borderWidth;
    [borderColor setStroke];
    [bezierPath stroke];
    // 4.使用BezierPath进行剪切
    [bezierPath addClip];
    // 5.画图
    [image drawInRect:CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height)];
    // 6.从内存中创建新图片对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 7.结束上下文
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)circleImageWithName:(NSString *)name
                       imageSize:(CGSize)size
                     borderWidth:(CGFloat)borderWidth
                     borderColor:(UIColor *)borderColor{
    UIImage *sourceImage =[self scaleToSize:[UIImage imageNamed:name] size:size];
    UIImage *newImage = [self circleImageWithImage:sourceImage borderWidth:borderWidth borderColor:borderColor];
    return newImage;
}
// 按比例缩放图片
+ (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  返回一张按比例缩放后的图片
 */
+ (UIImage *)scaleImageWithImage:(UIImage *)image
                      imageSize:(CGSize)size{
    UIImage *imageScale = [UIImage scaleToSize:image size:size];
    // 1.开启上下文
    CGFloat imageWidth = imageScale.size.width;
    CGFloat imageHeight = imageScale.size.height;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), NO, 0);
    // 2.获取上下文
    UIGraphicsGetCurrentContext();
        // 5.画图
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    // 6.从内存中创建新图片对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 7.结束上下文
    UIGraphicsEndImageContext();
    return newImage;
}
/**
 * 根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)resizedImageName:(NSString *)name{
    UIImage *image = [UIImage imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.2 topCapHeight:image.size.height*0.2];
}

/**
 * 根据图片返回一张能够自由拉伸的图片
 */
+ (UIImage *)resizedImage:(UIImage *)image{
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}

@end
