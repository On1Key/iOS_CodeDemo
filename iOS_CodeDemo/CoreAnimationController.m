//
//  CoreAnimationController.m
//  iOS_CodeDemo
//
//  Created by mac book on 16/8/5.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "CoreAnimationController.h"
#import "BezierView.h"

@interface CoreAnimationController ()
@property (nonatomic, strong) BezierView *bezierView;
@end

@implementation CoreAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bezerPathTest];
    NSArray *selectorArr = @[@"BaseAni:",@"KeyFrAni:",@"GroupAni:"];
    
    CGFloat scrW = [UIScreen mainScreen].bounds.size.width;
    CGFloat mar = 20;
    CGFloat btnW = (scrW - selectorArr.count * mar - mar) / selectorArr.count;
    CGFloat btnH = 50;
    for (int i = 0;i < selectorArr.count;i ++) {
        NSString *selec = selectorArr[i];
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(mar + i * (btnW + mar), 40, btnW, btnH);
        btn.backgroundColor = [UIColor lightGrayColor];
        [btn addTarget:self action:NSSelectorFromString(selec) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:selec forState:UIControlStateNormal];
        btn.touchExtendInset = UIEdgeInsetsMake(-20, -20, -20, -20);
        [self.view addSubview:btn];
    }
}
- (void)BaseAni:(id)sender{
    [_bezierView animateBaseToTransform];
}
- (void)KeyFrAni:(id)sender{
    [_bezierView animateKeyFrameToMove];
}
- (void)GroupAni:(id)sender{
    [_bezierView animateGroupActions];
}
- (void)bezerPathTest{
    BezierView *zeView = [BezierView new];
    zeView.frame = CGRectMake(0, 0, 200, 200);
    zeView.center = self.view.center;
    zeView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.1];
    [self.view addSubview:zeView];
    _bezierView = zeView;
    
}

@end
