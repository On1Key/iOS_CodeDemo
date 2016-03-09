//
//  PathView.m
//  data
//
//  Created by mac book on 16/2/15.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "PathView.h"

@implementation PathView

//参考文章
//http://blog.csdn.net/yiyaaixuexi/article/details/8848449

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _path = [UIBezierPath bezierPath];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        pan.maximumNumberOfTouches = pan.minimumNumberOfTouches = 1;
        [self addGestureRecognizer:pan];
        
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(earse)]];
        
        
    }
    return self;
}

static CGPoint midpoint(CGPoint p0, CGPoint p1) {
    return (CGPoint) {
        (p0.x + p1.x) / 2.0,
        (p0.y + p1.y) / 2.0
    };
}
- (void)earse{
    _path = [UIBezierPath bezierPath];
    [self setNeedsDisplay];
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint currentPoint = [pan locationInView:self];
    if (![NSValue valueWithCGPoint:_previousPoint]) {
        _previousPoint = currentPoint;
    }
    CGPoint midPoint = midpoint(_previousPoint, currentPoint);
    if (pan.state == UIGestureRecognizerStateBegan) {
        [_path moveToPoint:currentPoint];
    }else if (pan.state == UIGestureRecognizerStateChanged){
        [_path addQuadCurveToPoint:midPoint controlPoint:_previousPoint];
//        [_path addLineToPoint:currentPoint];
    }
    _previousPoint = currentPoint;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect{
    [[UIColor blackColor] setStroke];
    [_path stroke];
}

@end
