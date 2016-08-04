//
//  PopAnimator.m
//  Popping
//
//  Created by André Schneider on 14.05.14.
//  Copyright (c) 2014 André Schneider. All rights reserved.
//

#import "PresentingAnimator.h"
//#import "UIColor+CustomColors.h"
//#import <POP/POP.h>

@implementation PresentingAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
//    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
//    fromView.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
//    fromView.userInteractionEnabled = NO;
//
//    UIView *dimmingView = [[UIView alloc] initWithFrame:fromView.bounds];
//    dimmingView.backgroundColor = [UIColor grayColor];
//    dimmingView.layer.opacity = 0.0;
//
//    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
//    toView.frame = CGRectMake(0,
//                              0,
//                              CGRectGetWidth(transitionContext.containerView.bounds) - 104.f,
//                              CGRectGetHeight(transitionContext.containerView.bounds) - 288.f);
//    toView.center = CGPointMake(transitionContext.containerView.center.x, -transitionContext.containerView.center.y);
//
//    [transitionContext.containerView addSubview:dimmingView];
//    [transitionContext.containerView addSubview:toView];

//    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
//    positionAnimation.toValue = @(transitionContext.containerView.center.y);
//    positionAnimation.springBounciness = 10;
//    [positionAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
//        [transitionContext completeTransition:YES];
//    }];
//
//    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    scaleAnimation.springBounciness = 20;
//    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.4)];
//
//    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
//    opacityAnimation.toValue = @(0.2);
//
//    [toView.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
//    [toView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
//    [dimmingView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
    //1
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //2
    CGRect finalRect = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalRect, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height);
    
    //3
    [[transitionContext containerView]addSubview:toVC.view];
    
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
