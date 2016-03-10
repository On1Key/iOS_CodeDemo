//
//  UIImage+Extension.h
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 HB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

// 取消iOS7下的默认渲染模式
+ (UIImage *)imageWithName:(NSString *)name;

// 方法一 传入图片名
+ (UIImage *)circleImageWithName:(NSString *)name
                       imageSize:(CGSize)size
                     borderWidth:(CGFloat)borderWidth
                     borderColor:(UIColor *)borderColor;
/**
 *  返回一张按比例缩放后的图片
 */
+ (UIImage *)scaleImageWithImage:(UIImage *)image
                       imageSize:(CGSize)size;

/**
 * 根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)resizedImageName:(NSString *)name;

/**
 * 根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)resizedImage:(UIImage *)image;
@end
