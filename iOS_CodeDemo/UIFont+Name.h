//
//  UIFont+Name.h
//  iOS_CodeDemo
//
//  Created by mac book on 16/3/9.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Name)
/**
 *  苹果支持的Zapfino字体，不支持中文
 */
+ (UIFont *)fontName_Zapfino_Size:(CGFloat)size;
@end
