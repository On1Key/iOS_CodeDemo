//
//  PathView.h
//  data
//
//  Created by mac book on 16/2/15.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  这是个简单的手写板，仅提供一个思路
 *  这个view还有一个bug，划线不能从落笔点开始，要滞后一点距离，不清楚原因
 */

@interface PathView : UIView
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic) CGPoint previousPoint;
@end
