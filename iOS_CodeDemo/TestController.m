//
//  TestController.m
//  iOS_CodeDemo
//
//  Created by mac book on 16/3/9.
//  Copyright © 2016年 mac book. All rights reserved.
//

#pragma mark - 添加规范注释
/**
 *  ----------------------------------------------------------------------
 *  添加规范注释
 */

#import "TestController.h"

@interface TestController ()

@end

@implementation TestController

- (void)viewDidLoad {
    [super viewDidLoad];
    //测试block回传值
    [self testOfBlockDeliver];
    self.view.backgroundColor = [UIColor lightGrayColor];
}
#pragma mark - 测试block回传值
/**
 *  ----------------------------------------------------------------------
 *  测试block回传值
 */
- (void)testOfBlockDeliver{
    [self createCustomerButtonWithTitle:@"popBack" sel:@selector(popBackWithBlcokDeliver) frame:CGRectMake(100, 100, 100, 100)];
}
- (void)popBackWithBlcokDeliver{
    NSString *text = [NSString stringWithFormat:@"随机传值测试：%d",arc4random()%100];
    if (self.sendText) {
        self.sendText(text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    self.sendText = nil;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}










@end
