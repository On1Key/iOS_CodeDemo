//
//  Bezier&CGRefController.m
//  iOS_CodeDemo
//
//  Created by mac book on 16/7/4.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "Bezier&CGRefController.h"
#import "CustomView.h"

@interface Bezier_CGRefController ()

@end

@implementation Bezier_CGRefController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomView *customView = [[CustomView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:customView];
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
