

#define COLOR_MASK [UIColor colorWithRed:0.922 green:0.922 blue:0.945 alpha:0.5]
#define BACK_TAG 10101010

#import "UIViewController+Deliver.h"

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
+ (void)showMaskWithTarget:(id)target completion:(void (^)())finish{
    UIView *backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = COLOR_MASK;
    backView.tag = BACK_TAG;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:@selector(hideView:)];
    //    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hideView:)];
    //    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(hideView:)];
    //    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideView:)];
    [backView addGestureRecognizer:tap];
    //    [backView addGestureRecognizer:pan];
    //    [backView addGestureRecognizer:press];
    //    [backView addGestureRecognizer:swipe];
    [[UIApplication sharedApplication].keyWindow addSubview:backView];
    if (finish && !backView) {
        finish();
    }
}
+(void)showMaskWithTarget:(id)target{
    [UIViewController showMaskWithTarget:target completion:nil];
}
- (void)showMaskCompletion:(void (^)())finish{
    [UIViewController showMaskWithTarget:self completion:finish];
}
- (void)showMask{
    [UIViewController showMaskWithTarget:self completion:nil];
}
- (void)hideAllMask{
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if (subView.tag == BACK_TAG) {
            subView.hidden = YES;
            [subView removeFromSuperview];
        }
    }
}
- (void)hideView:(UIGestureRecognizer *)ges{
    UIView *backview = ges.view;
    [self.view endEditing:YES];
    backview.hidden = YES;
    [backview removeFromSuperview];
}
@end
