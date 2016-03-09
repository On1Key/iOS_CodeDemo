//
//  UIButton+Copy.m
//  iOS_CodeDemo
//
//  Created by mac book on 16/3/9.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "UIButton+Copy.h"

@implementation UIButton (Copy)
/**
 *  iOS默认只有textfield和textview开起来可以响应键盘
 *  这里设置为YES后，按钮也可以响应键盘的复制粘贴操作
 */
- (BOOL)canBecomeFirstResponder{
    return YES;
}
@end
