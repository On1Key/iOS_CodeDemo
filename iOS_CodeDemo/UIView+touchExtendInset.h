//
//  UIView+touchExtendInset.h
//  iOS_CodeDemo
//
//  Created by mac book on 16/8/4.
//  Copyright © 2016年 mac book. All rights reserved.

//http://kittenyang.com/effective_category/

#import <UIKit/UIKit.h>

@interface UIView (touchExtendInset)
//一行代码扩大视图点击区域：
//self.button.touchExtendInset = UIEdgeInsetsMake(-10, -10, -10, -10)
@property (nonatomic) UIEdgeInsets touchExtendInset;
@end
