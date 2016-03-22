//
//  UITableView+Keyboard.m
//  firstNursingWorkers
//
//  Created by mac book on 16/3/22.
//  Copyright © 2016年 HB. All rights reserved.
//

#import "UITableView+Keyboard.h"
/**
 *  保存当前的偏移y值，便于在键盘隐藏时恢复修改前的偏移量
 */
static CGFloat currY = 0.f;

@implementation UITableView (Keyboard)
- (void)addResponserKeyboardNotification{
    currY = 0.f;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)noti{
    //    NSLog(@"----%@\n%@",noti.userInfo,noti.object);
    
    for (UITableViewCell *infoCell in self.visibleCells) {
        if ([infoCell isKindOfClass:[UITableViewCell class]]) {
            
            UIView *resView = [self findFirstResponder:infoCell];
            
            
            CGRect tvToView = [resView convertRect:resView.frame toView:self];
            CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//            NSLog(@"\n--tv:%@\n--kb:%@",NSStringFromCGRect(tvToView),NSStringFromCGRect(keyboardFrame));
            if (CGRectGetMaxY(tvToView) + 64 >= keyboardFrame.origin.y) {
                currY = self.contentOffset.y;
                CGFloat nowY = currY;
                nowY += CGRectGetMaxY(tvToView) + 64 - keyboardFrame.origin.y;
                self.contentOffset = CGPointMake(0, nowY);
            }
            //                [self showMask];
            
        }
        
    }
    
    
    
}
/**
 *  递归找到当前键盘的响应者
 */
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
/**
 *  恢复键盘出现前的偏移y值
 */
- (void)keyboardWillHide:(NSNotification*)noti{
    self.contentOffset = CGPointMake(0, currY);
}
@end
