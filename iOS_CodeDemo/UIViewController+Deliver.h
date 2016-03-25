

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void (^SendText)(NSString *text);
typedef void (^SendDictionary)(NSDictionary *dict);
typedef void (^SendArray)(NSArray *arr);
typedef void (^SendObject)(id obj);

/*  使用范例：
 假如在A页面跳转到B页面，然后将值从B回传至A界面：
 
 在A界面跳转B界面完毕的位置加这个代码：
 B界面名称.sendText = ^(NSString *text){
    NSLog(@"接收到的值为：%@",text);
 }
 
 在B界面跳转回A界面的位置之前加如下代码：
 self.sendText(@"此处是要传的值");
 传值完毕
 */

/*
 但是要注意使用的时候防止循环引用
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
 *  快捷创建按钮
 */
- (UIButton *)createCustomerButtonWithTitle:(NSString *)title sel:(SEL)sel frame:(CGRect)frame;
/**
 *  创建自定义标题
 */
- (void)setUpTitle:(NSString *)title;
/**
 *  隐藏键盘蒙板
 */
- (void)showMask;
- (void)hideAllMask;
//+ (void)showMaskWithTarget:(id)target;
//- (void)showMaskCompletion:(void (^)())finish;
//+ (void)showMaskWithTarget:(id)target completion:(void (^)())finish;

@end
