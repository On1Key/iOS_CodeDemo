//
//  ViewController.m
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

#import "ViewController.h"
#import "TestController.h"
#import "MapController.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *btn_test;
@end

/**
 *  算法：3 << 4 = 3*(2^4)
 */
typedef NS_ENUM(NSInteger, TEST){
    TEST_ONE = 0,
    TEST_TWO = 1 << 0,
    TEST_THR = 1 << 1,
    TEST_FOR = 1 << 2,
    TEST_FIV = 1 << 3,
    TEST_SIX = 1 << 4,
    TEST_SEV = 1 << 5,
    TEST_EIG = 1 << 6,
    TEST_NIN = 1 << 7,
    TEST_ZER = 1 << 8
    
};

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    测试控制器categroy添加block传值
    [self testOfControllerBlockDeliver];
//    测试按钮复制
    [self testOfButtonResponser];
//    测试md5加密和base64加密解密
//    [self testOfBase64_md5];
//    手写板测试
//    [self testOfPathView];
//    测试数组排序用法
//    [self testSortArray];
//    枚举写法测试
//    [self enumeration_reason];
//    日期比较
//    [self compareStartTime:@"2015-10-10 10:10:20.433" toEndTime:@"2015-10-10 10:10:10.432" withFormat:@"yyyy/MM/dd HH:mm:ss.zzz"];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
//    应用间调用
//    [self openAnotherApp];
//    地图页面
//    [self pushToMapVC];
}
#pragma mark - 地图页面
/**
 *  ----------------------------------------------------------------------
 *  地图页面
 */
- (void)pushToMapVC{
    MapController *map = [MapController new];
    [self.navigationController pushViewController:map animated:YES];
}
#pragma mark - 应用间跳转
/**
 *  ----------------------------------------------------------------------
 *  应用间跳转
 *  详细介绍参考博客园
 *  需要被跳转应用设置info.plist如下：
 *  URL types --> item --> URL Schemes --> item --> 设置值为(随意命名)com.appName
 *  此处是：test.name，调用如下
 */
- (void)openAnotherApp{
    NSURL *url = [NSURL URLWithString:@"test.name://"];
    [[UIApplication sharedApplication] openURL:url];
}
#pragma mark - 日期比较
/**
 *  ----------------------------------------------------------------------
 *  日期比较
 *  时区参数zzz也会计算入时间比较
 */
- (NSString *)compareStartTime:(NSString *)start toEndTime:(NSString *)end withFormat:(NSString *)format{
    //zzz：时区
    //@"yyyy/MM/dd HH:mm:ss.zzz"
    //    [self compareStartTime:@"2015-10-10 10:10:20.433" toEndTime:@"2015-10-10 10:10:10.432" withFormat:@"yyyy/MM/dd HH:mm:ss.zzz"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *startDate = [dateFormatter dateFromString:start];
    NSDate *endDate = [dateFormatter dateFromString:end];
    NSTimeInterval lastInt = [startDate timeIntervalSinceDate:endDate];
    NSString *last = [@(lastInt) stringValue];
    NSLog(@"%@",last);
    return last;
}
#pragma mark - 枚举<<写法测试
/**
 *  ----------------------------------------------------------------------
 *  枚举写法测试
 *  枚举中左移运算<<写法的原因
 *  3 << 4 = 3*(2^4)
 *  因为在枚举值得或|运算时，相当于
 *  3 | 4 = 3 + 4
 *  而左移运算<<可以避免这种或|运算造成的可能与枚举值一样的冲突
 */
- (void)enumeration_reason{
    NSLog(@"测试：\nTEST_FIV(2^1)的值：%ld\nTEST_TWO(2^0)的值：%ld\nTEST_TWO | TEST_THR的值：%ld",TEST_THR,TEST_TWO,TEST_TWO | TEST_THR);
}
#pragma mark - 数组排序用法
/**
 *  ----------------------------------------------------------------------
 *  测试数组排序用法
 *  系统自带方法，按数字大小和英文顺序排列，不支持汉字排序
 */
- (void)testSortArray{
    NSArray *arr = @[@"Hrr",@"Kads",@"Isd",@"12er",@"5ii",@"9oo",@"哇哈哈",@"你哇哈哈"];
    NSArray *sort = [arr sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSLog(@"%@\n%@",arr,sort);
}
#pragma mark - md5加密和base64加密解密
/**
 *  ----------------------------------------------------------------------
 *  测试md5加密和base64加密解密
 */
- (void)testOfBase64_md5{
    NSLog(@"\ndecodeLocation:%@\nmd5_base64:%@\n%@\n%@\n%@\nencodebase64:%@\ndecode:%@\n",[GTMBase64 decodeBase64String:@"MTE2LjQyNzA1NzgzNDI="],[GTMBase64 md5_base64:@"HelloWorld"],[GTMBase64 md5_base64:@"Helloworld"],[GTMBase64 md5_base64:@"helloWorld"],[GTMBase64 md5_base64:@"helloworld"],[GTMBase64 encodeBase64String:@"HelloWorld"],[GTMBase64 decodeBase64String:[GTMBase64 encodeBase64String:@"HelloWorld"]]);
}
#pragma mark - 手写板测试
/**
 *  ----------------------------------------------------------------------
 *  手写板测试
 */
- (void)testOfPathView{
    PathView *pathView = [[PathView alloc] initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, SCREEN_WIDTH)];
    pathView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:pathView];
}
#pragma mark - button的canBecomeFirstResponser方法
/**
 *  ----------------------------------------------------------------------
 *  测试button的canBecomeFirstResponser方法，可以复制粘贴
 */
- (void)testOfButtonResponser{
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(0, 100, 90, 100);
    textField.placeholder = @"占位文字";
    textField.backgroundColor = [UIColor lightGrayColor];
    textField.font = [UIFont fontName_Zapfino_Size:14];
    textField.textColor = [UIColor blackColor];
    [self.view addSubview:textField];
}
- (void)longCopy:(UIGestureRecognizer *)ges{
    UIButton *btn = (UIButton *)ges.view;
    NSLog(@"%@",btn.titleLabel.text);
    [btn becomeFirstResponder];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"自定义复制" action:@selector(copyItem)];
    menu.menuItems = @[item];
    [menu setTargetRect:btn.frame inView:self.view];
    [menu setMenuVisible:YES animated:YES];
}
- (void)copyItem{
    NSLog(@"%s",__func__);
    [[UIPasteboard generalPasteboard] setValue:_btn_test.titleLabel.text forPasteboardType:[UIPasteboardTypeListString objectAtIndex:0]];
}
#pragma mark - 控制器categroy添加block传值
/**
 *  ----------------------------------------------------------------------
 *  测试控制器categroy添加block传值
 *  替代叶面间方向传值delegate模式
 */
- (void)testOfControllerBlockDeliver{
    UIButton *btn = [self createCustomerButtonWithTitle:@"blockTest(longCopy)" sel:@selector(blockDeliver:) frame:CGRectMake(100, 100, 100, 100)];
    [btn addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longCopy:)]];
    _btn_test = btn;
}
- (void)blockDeliver:(UIButton *)btn{
    TestController *test = [TestController new];
    test.sendText = ^(NSString *text){
        [btn setTitle:text forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:test animated:YES];
}


@end
