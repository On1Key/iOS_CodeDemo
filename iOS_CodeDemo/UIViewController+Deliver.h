//
//  UIViewController+Deliver.h
//  firstNursingWorkers
//
//  Created by mac book on 16/3/7.
//  Copyright © 2016年 HB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void (^SendText)(NSString *text);
typedef void (^SendDictionary)(NSDictionary *dict);
typedef void (^SendArray)(NSArray *arr);
typedef void (^SendObject)(id obj);

/*使用范例：
 假如在A页面跳转到B页面，然后将值从B回传至A界面：
 
 在A界面跳转B界面完毕的位置加这个代码：
 B界面名称.sendText = ^(NSString *text){
    NSLog(@"接收到的值为：%@",text);
 }
 
 在B界面跳转回A界面的位置之前加如下代码：
 self.sendText(@"此处是要传的值");
 传值完毕
 */

@interface UIViewController (Deliver)
/**
 *  传值字符串
 */
@property (nonatomic, copy) SendText sendText;
/**
 *  传值字典
 */
@property (nonatomic, copy) SendDictionary sendDictionary;
/**
 *  传值数组
 */
@property (nonatomic, copy) SendArray sendArray;
/**
 *  传值id类型数据
 */
@property (nonatomic, copy) SendObject sendObject;


/**
 *  隐藏键盘蒙板
 */
- (void)showMask;
- (void)showMaskCompletion:(void (^)())completion;
/**
 *  显示键盘蒙板
 *
 *  @param standardFrame 键盘的frame
 *  @param oldPoint      原来的偏移量
 *
 *  @return 新的偏移量
 */
- (CGPoint)showMaskWithCalculateKeyBoardByStandardFrame:(CGRect)standardFrame oldPoint:(CGPoint)oldPoint;
/**
 *  创建自定义标题
 */
- (void)setUpTitle:(NSString *)title;
/**
 *  快捷创建按钮
 */
- (UIButton *)createCustomerButtonWithTitle:(NSString *)title sel:(SEL)sel frame:(CGRect)frame;


@end
