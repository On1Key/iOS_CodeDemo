//
//  UIBarButtonItem+Extension.m
//  天天微博
//
//  Created by tarena on 15/6/13.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
// 【创建navigationItem】
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName
                         highImageName:(NSString *)highImageName
                                 taget:(id)target
                                action:(SEL)action{
    // 设置导航栏按钮
    UIButton *button = [[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageWithName:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:highImageName] forState:UIControlStateHighlighted];
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
@end
