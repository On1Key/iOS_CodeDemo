//
//  BezierView.m
//  TEST_JSON
//
//  Created by mac book on 16/8/4.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "BezierView.h"

typedef NS_ENUM(NSInteger,AnimateState){
    AnimateStateStart,
    AnimateStateMoving,
    AnimateStatePause,
    AnimateStateResume,
    AnimateStateEnd,
};

@interface BezierView()
#pragma mark - CABasicAnimation
@property (nonatomic, strong) CABasicAnimation *transformAnimate;
@property (nonatomic, strong) CABasicAnimation *opacityAnimate;
@property (nonatomic) CATransform3D myTransform;
//旋转度数加倍
@property (nonatomic) int count;
/**动画是否结束、暂停*/
@property (nonatomic) AnimateState animateState;
#pragma mark - CAKeyframeAnimation:关键帧动画
@property (nonatomic, strong) CAKeyframeAnimation *keyFrameAnimate;
#pragma mark - CAAnimationGroup:动画组
@property (nonatomic, strong) CAAnimationGroup *groupAnimate;
#pragma mark - CATransition:转场动画
@property (nonatomic, strong) CATransition *transitionAnimate;
#pragma mark - CAReplicatorLayer:复制图层
#pragma mark - CAShapeLayer：形状图层
#pragma mark - CAGradientLayer：渐变图层
#pragma mark - CAReplicatorLayer:复制图层
#pragma mark - CALayer：图层
#pragma mark - BezierPath
@end
#pragma mark - ------------------------------------
@implementation BezierView
#pragma mark -公用
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _count = 1;
        _myTransform = CATransform3DMakeRotation(radians(45 * _count),1.0,0.0,0.0);
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panActionWithTransitionAnomate:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}
/**暂停动画*/
-(void)pauseLayer:(CALayer*)layer{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    // 让CALayer的时间停止走动
    layer.speed = 0.0;
    // 让CALayer的时间停留在pausedTime这个时刻
    layer.timeOffset = pausedTime;
    
    _animateState = AnimateStatePause;
}
/**继续动画*/
-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = layer.timeOffset;
    // 1. 让CALayer的时间继续行走
    layer.speed = 1.0;
    // 2. 取消上次记录的停留时刻
    layer.timeOffset = 0.0;
    // 3. 取消上次设置的时间
    layer.beginTime = 0.0;
    // 4. 计算暂停的时间(这里也可以用CACurrentMediaTime()-pausedTime)
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    // 5. 设置相对于父坐标系的开始时间(往后退timeSincePause)
    layer.beginTime = timeSincePause;
    
    _animateState = AnimateStateResume;
}
/**根据状态判断动画是否暂停继续*/
- (void)actionChangeStateToPauseOrResume{
    //如果动画未结束，执行暂停操作
    if (_animateState == AnimateStateMoving || _animateState == AnimateStateResume) {
        [self pauseLayer:self.layer];
        return;
    }else if(_animateState == AnimateStatePause){
        [self resumeLayer:self.layer];
        return;
    }
}
#pragma mark - delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //    [self.layer setTransform:_myTransform];
    _animateState = AnimateStateEnd;
}
#pragma mark - CABasicAnimation
double radians(float degrees){
    return (degrees*M_PI)/180.0;
}
- (CABasicAnimation *)transformAnimate{
    if (!_transformAnimate) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.toValue = [NSValue valueWithCATransform3D:_myTransform];
        animation.duration =3.0;
//        animation.cumulative =YES;
//        animation.repeatCount=2;
        animation.delegate = self;
        //是否动态返回初始值
        animation.autoreverses = YES;
        //渐入渐出
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.timeOffset = 1;
        //如果fillMode=kCAFillModeForwards同时removedOnComletion=NO，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变
        //真正改变最终动画结果需要在动画结束后的代理中设置
        animation.fillMode=kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        
        _transformAnimate = animation;
    }
    return _transformAnimate;
}
//永久闪烁的动画
- (CABasicAnimation *)opacityAnimate{
    if (!_opacityAnimate) {
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue=[NSNumber numberWithFloat:1.0];
        animation.toValue=[NSNumber numberWithFloat:0.0];
        animation.autoreverses=YES;
        animation.duration=2;
        animation.repeatCount=FLT_MAX;
        animation.removedOnCompletion=NO;
        animation.fillMode=kCAFillModeForwards;
        _opacityAnimate = animation;
    }
    return _opacityAnimate;
}
- (void)animateBaseToTransform{
    //如果动画未结束，执行暂停操作
    [self actionChangeStateToPauseOrResume];
    _count ++;
    _animateState = AnimateStateMoving;
    _myTransform = CATransform3DMakeRotation(radians(45 * _count),1.0,0.0,0.0);
    self.transformAnimate.toValue = [NSValue valueWithCATransform3D:_myTransform];
    [self.layer addAnimation:self.transformAnimate forKey:nil];
    
    [self.layer addAnimation:self.opacityAnimate forKey:nil];
}

#pragma mark - CAAnimation:
- (void)CAAnimationTest{
    CAAnimation *nnn;
}
#pragma mark - CAKeyframeAnimation:关键帧动画
- (CAKeyframeAnimation *)keyFrameAnimate{
    if (!_keyFrameAnimate) {
        
//        CGMutablePathRef path = CGPathCreateMutable();
//        //将路径的起点定位到（50  120）
//        CGPathMoveToPoint(path,NULL,50.0,120.0);
//        //下面5行添加5条直线的路径到path中
//        CGPathAddLineToPoint(path,NULL, 60, 130);
//        CGPathAddLineToPoint(path,NULL, 70, 140);
//        CGPathAddLineToPoint(path,NULL, 80, 150);
//        CGPathAddLineToPoint(path,NULL, 90, 160);
//        CGPathAddLineToPoint(path,NULL, 100, 170);
//        //下面四行添加四条曲线路径到path
//        CGPathAddCurveToPoint(path,NULL,50.0,275.0,150.0,275.0,70.0,120.0);
//        CGPathAddCurveToPoint(path,NULL,150.0,275.0,250.0,275.0,90.0,120.0);
//        CGPathAddCurveToPoint(path,NULL,250.0,275.0,350.0,275.0,110.0,120.0);
//        CGPathAddCurveToPoint(path,NULL,350.0,275.0,450.0,275.0,130.0,120.0);
//        //以“position”为关键字
//        //创建 实例
//        CAKeyframeAnimation*animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//        //设置path属性
//        [animation setPath:path];
//        [animation setDuration:3.0];
//        //这句代码表示 是否动画回到原位
//        [animation setAutoreverses:YES];
//        //动画是否保存现有状态
//        animation.fillMode=kCAFillModeForwards;
//        animation.removedOnCompletion = NO;
//        _keyFrameAnimate = animation;
//        CFRelease(path);
        
        //  .
        // /|\
        //  |
        //  |
        //  |
        //上面是设置path，下面是设置values
        //tip:::一个数组，提供了一组关键帧的值，  当使用path的 时候 values的值自动被忽略
        
        
        CGPoint
        p1=CGPointMake(50, 120);
        CGPoint
        p2=CGPointMake(80, 170);
        CGPoint
        p3=CGPointMake(30, 100);
        CGPoint
        p4=CGPointMake(100, 190);
        CGPoint
        p5=CGPointMake(200, 10);
        NSArray*values=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:p1],[NSValue valueWithCGPoint:p2],[NSValue valueWithCGPoint:p3],[NSValue valueWithCGPoint:p4],[NSValue valueWithCGPoint:p5], nil];
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        [animation setValues:values];
        [animation setDuration:3.0];
        [animation setAutoreverses:YES];
        
        //每一帧动画时长设置
        //calculationMode这个属性用来设定 关键帧中间的值是怎么被计算的
        [animation setCalculationMode:kCAAnimationLinear];
        
        [animation setKeyTimes:[NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:0.0],
                                [NSNumber numberWithFloat:0.5],
                                [NSNumber numberWithFloat:0.9],
                                [NSNumber numberWithFloat:0.95],
                                [NSNumber numberWithFloat:1.0], nil]];
        _keyFrameAnimate = animation;
    }
    return _keyFrameAnimate;
}
- (void)animateKeyFrameToMove{
    [self actionChangeStateToPauseOrResume];
    [self.layer addAnimation:self.keyFrameAnimate forKey:NULL];
}
#pragma mark - CAAnimationGroup:动画组
- (CAAnimationGroup *)groupAnimate{
    if (!_groupAnimate) {
        _groupAnimate = [CAAnimationGroup animation];
        _groupAnimate.animations = @[self.transformAnimate,self.keyFrameAnimate];
        _groupAnimate.duration = 5.f;
    }
    return _groupAnimate;
}
- (void)animateGroupActions{
    [self actionChangeStateToPauseOrResume];
    [self.layer addAnimation:self.groupAnimate forKey:nil];
}
#pragma mark - CATransition:转场动画
- (CATransition *)transitionAnimate{
    if (!_transitionAnimate) {
        //1.创建转场动画对象
        CATransition *transition = [CATransition animation];
        //2.设置动画类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
        transition.type=@"cube";
        //设置动画时常
        transition.duration=1.0f;
        _transitionAnimate = transition;
    }
    return _transitionAnimate;
}

- (void)panActionWithTransitionAnomate:(UIPanGestureRecognizer *)ges{
    CGPoint locP = [ges locationInView:self];
    CGPoint traP = [ges translationInView:self];
    CGPoint verP = [ges velocityInView:self];
    CGPoint startP ;
    if (ges.state == UIGestureRecognizerStateEnded || ges.state == UIGestureRecognizerStateFailed || ges.state == UIGestureRecognizerStateCancelled) {
        NSLog(@"%@==%@==%@==%@",NSStringFromCGPoint(locP),NSStringFromCGPoint(traP),NSStringFromCGPoint(verP),NSStringFromCGPoint(startP));
        CGFloat directF = traP.x * traP.y;
        NSInteger direction = 0;
        //上下左右0123
        if (traP.x > 0 && traP.y > 0) {
            direction = 1;
        }else if (traP.x < 0 && traP.y < 0){
            direction = 0;
        }else if (traP.x > 0 && traP.y < 0){
            direction = 3;
        }else if (traP.x < 0 && traP.y > 0){
            direction = 2;
        }
        
        //设置子类型
        BOOL bl = YES;
        if (direction == 3) {
            self.transitionAnimate.subtype=kCATransitionFromRight;
            bl = YES;
        }else if (direction == 2) {
            self.transitionAnimate.subtype=kCATransitionFromLeft;
            bl = NO;
        }else if (direction == 0) {
            self.transitionAnimate.subtype=kCATransitionFromTop;
            bl = YES;
        }else{
            self.transitionAnimate.subtype=kCATransitionFromBottom;
            bl = NO;
        }
        
        NSArray *colors = @[[UIColor redColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor]];
        self.backgroundColor = colors[direction];
//        //3.设置转场后的新视图添加转场动画
        //方法一：自定义转场
        [self.layer addAnimation:self.transitionAnimate forKey:nil];
        //方法一：uiview的转场
//        [self transitionAnimation:bl index:direction];
        
    }
}
-(void)transitionAnimation:(BOOL)isNext index:(NSInteger)direction{
    UIViewAnimationOptions option;
//    if (isNext) {
//        option=UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionFlipFromRight;
//    }else{
//        option=UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionFlipFromLeft;
//    }
    if (direction == 3) {
        option=UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionFlipFromRight;
    }else if (direction == 2) {
        option=UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionFlipFromLeft;
    }else if (direction == 0) {
        option=UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionFlipFromTop;
    }else{
        option=UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionFlipFromBottom;
    }
    
    NSArray *colors = @[[UIColor redColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor]];
    [UIView transitionWithView:self duration:1.0 options:option animations:^{
        self.backgroundColor = colors[direction];
    } completion:nil];
}
- (void)animateTransition{
    [self actionChangeStateToPauseOrResume];
}
#pragma mark - CAReplicatorLayer:复制图层
#pragma mark - CAShapeLayer：形状图层
#pragma mark - CAGradientLayer：渐变图层
#pragma mark - CAReplicatorLayer:复制图层
#pragma mark - CALayer：图层
#pragma mark - BezierPath
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
//    [self drawARCPath];
//    [self bezerPathTest];
}
- (void)bezerPathTest{
    CGPoint startP = CGPointMake(100, 100);
    CGPoint throuthP = CGPointMake(120, 150);
    CGPoint endP = CGPointMake(200, 200);
    
    CGPoint ancP = CGPointMake(300, 300);
    CGPoint nextP = CGPointMake(50, 270);
    CGPoint lastP = CGPointMake(0, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startP];
    //    [path addLineToPoint:throuthP];
    //    [path addLineToPoint:endP];
    [path addQuadCurveToPoint:endP controlPoint:throuthP];
    [path addLineToPoint:ancP];
    [path addQuadCurveToPoint:lastP controlPoint:nextP];
    [path addLineToPoint:startP];
    
//    path.lineWidth = 5.f;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    
    //    UIColor *red = [UIColor redColor];
    //    [red set];
    //    [path fill];
    //    [red set];
    
    [path stroke];
    
    //    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    //    shapeLayer.path = path.CGPath;
    //    shapeLayer.fillColor = [UIColor lightGrayColor].CGColor;
    //    [self.view.layer addSublayer:shapeLayer];
    
    
}
const CGFloat pi = 3.14159265359;
#define   kDegreesToRadians(degrees)  ((pi * degrees)/ 180)
- (void)drawARCPath {
    
    
    CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:100
                                                    startAngle:0
                                                      endAngle:kDegreesToRadians(135)
                                                     clockwise:YES];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 5.0;
    
    UIColor *strokeColor = [UIColor redColor];
    [strokeColor set];
    
    [path stroke];
}

@end
