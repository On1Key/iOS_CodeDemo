//
//  UIViewController+Deliver.m
//  firstNursingWorkers
//
//  Created by mac book on 16/3/7.
//  Copyright © 2016年 HB. All rights reserved.
//

#define COLOR_MASK [UIColor colorWithRed:0.922 green:0.922 blue:0.945 alpha:0]

#import "UIViewController+Deliver.h"

typedef void (^Completion)();

@interface UIViewController()
/**
 *  点击事件
 */
@property (nonatomic, copy) Completion complete;
@end

@implementation UIViewController (Deliver)
- (SendText)sendText{
    return objc_getAssociatedObject(self, @selector(sendText));
}
- (void)setSendText:(SendText)sendText{
    objc_setAssociatedObject(self, @selector(sendText), sendText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (SendDictionary)sendDictionary{
    return objc_getAssociatedObject(self, @selector(sendDictionary));
}
- (void)setSendDictionary:(SendDictionary)sendDictionary{
    objc_setAssociatedObject(self, @selector(sendDictionary), sendDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (SendArray)sendArray{
    return objc_getAssociatedObject(self, @selector(sendArray));
}
- (void)setSendArray:(SendArray)sendArray{
    objc_setAssociatedObject(self, @selector(sendArray), sendArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (SendObject)sendObject{
    return objc_getAssociatedObject(self, @selector(sendObject));
}
- (void)setSendObject:(SendObject)sendObject{
    objc_setAssociatedObject(self, @selector(sendObject), sendObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (Completion)complete{
    return objc_getAssociatedObject(self, @selector(complete));
}
- (void)setComplete:(Completion)complete{
    objc_setAssociatedObject(self, @selector(complete), complete, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)showMaskWithTarget:(id)target completion:(void (^)())completion{
    UIView *backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = COLOR_MASK;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:@selector(hideView:)];
    [backView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:backView];
    
    //完成回调
    if (completion) {
        self.complete = ^(){
            completion();
        };
    }
}
- (CGPoint)showMaskWithCalculateKeyBoardByStandardFrame:(CGRect)standardFrame oldPoint:(CGPoint)oldPoint{
    [self showMaskWithTarget:self completion:nil];
    UIView *resView = [self findFirstResponder:self.view];
    CGRect resToFrame = [resView convertRect:resView.frame toView:self.view];
    CGRect keyboardFrame = standardFrame;
    //            NSLog(@"\n--tv:%@\n--kb:%@",NSStringFromCGRect(tvToView),NSStringFromCGRect(keyboardFrame));
    if (CGRectGetMaxY(resToFrame) + 64 >= keyboardFrame.origin.y) {
        CGFloat currY = oldPoint.y;
        currY += CGRectGetMaxY(resToFrame) + 64 - keyboardFrame.origin.y;
        
        return CGPointMake(0, currY);
    }
    return oldPoint;
}
- (UIView *)findFirstResponder:(UIView *)superView
{
    if (superView.isFirstResponder) {
        return superView;
    }
    for (UIView *subView in superView.subviews) {
        UIView *firstResponder = [self findFirstResponder:subView];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    return nil;
}
-(void)showMaskWithTarget:(id)target{
    [self showMaskWithTarget:target completion:nil];
}
- (void)showMaskCompletion:(void (^)())completion{
    [self showMaskWithTarget:self completion:completion];
}
- (void)showMask{
    [self showMaskWithTarget:self completion:nil];
}
- (void)hideMask{
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if (subView.tag == 101010) {
            subView.hidden = YES;
            [subView removeFromSuperview];
        }
    }
}
/**
 *  创建自定义按钮
 */
- (UIButton *)createCustomerButtonWithTitle:(NSString *)title sel:(SEL)sel frame:(CGRect)frame{
    UIButton *button = [[UIButton alloc] init];
    button.frame = frame;
    button.backgroundColor = COLOR_RANDOM;
    button.titleLabel.numberOfLines = 0;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:nil forState:UIControlStateNormal];
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return button;
}
/**
 *  创建自定义标题
 */
- (void)setUpTitle:(NSString *)title{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 100, 40);
    label.text = title;
    label.font = [UIFont fontName_Zapfino_Size:14];
    label.textColor = COLOR_RANDOM;
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
}
- (void)hideView:(UIGestureRecognizer *)ges{
    UIView *backview = ges.view;
    [self.view endEditing:YES];
    [self.navigationItem.titleView endEditing:YES];
    backview.hidden = YES;
    backview = nil;
    [backview removeFromSuperview];
    //回调
    [self completeAction];
    
}
- (void)completeAction{
    if (self.complete) {
        self.complete();
    }
}
@end
