//
//  DismissingAnimator.m
//  Popping
//
//  Created by André Schneider on 16.05.14.
//  Copyright (c) 2014 André Schneider. All rights reserved.
//

#import "DismissingAnimator.h"

@implementation DismissingAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    toVC.view.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
//    toVC.view.userInteractionEnabled = YES;
//
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//
//    __block UIView *dimmingView;
//    [transitionContext.containerView.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
//        if (view.layer.opacity < 1.f) {
//            dimmingView = view;
//            *stop = YES;
//        }
//    }];
//    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
//    opacityAnimation.toValue = @(0.0);
//
//    POPBasicAnimation *offscreenAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
//    offscreenAnimation.toValue = @(-fromVC.view.layer.position.y);
//    [offscreenAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
//        [transitionContext completeTransition:YES];
//    }];
//    [fromVC.view.layer pop_addAnimation:offscreenAnimation forKey:@"offscreenAnimation"];
//    [dimmingView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
    
    
    //1
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    //2
    CGRect finalRect = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalRect, 0,0/*[[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height*/);

    //3
//    [[transitionContext containerView]addSubview:toVC.view];
    
    //4
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        toVC.view.frame = finalRect;
    } completion:^(BOOL finished) {
        //5
        [transitionContext completeTransition:YES];
    }];
//    1、我们需要得到参与切换的两个ViewController的信息，使用context的方法拿到它们的参照；
//    2、对于要呈现的VC，我们希望它从屏幕下方出现，因此将初始位置设置到屏幕下边缘；
//    3、将view添加到containerView中；
//    4、开始动画。这里的动画时间长度和切换时间长度一致。usingSpringWithDamping的UIView动画API是iOS7新加入的，描述了一个模拟弹簧动作的动画曲线；
//    5、在动画结束后我们必须向context报告VC切换完成，是否成功。系统在接收到这个消息后，将对VC状态进行维护
}

@end
