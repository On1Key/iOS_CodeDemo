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
    RYCuteView *cuteView = [[RYCuteView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    cuteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cuteView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
