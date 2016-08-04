//
//  BezierTORefreshController.m
//  iOS_CodeDemo
//
//  Created by mac book on 16/7/4.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "BezierTORefreshController.h"
#import "RYCuteView.h"

@interface BezierTORefreshController ()

@end

@implementation BezierTORefreshController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RYCuteView *cuteView = [[RYCuteView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    cuteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cuteView];
}

@end
