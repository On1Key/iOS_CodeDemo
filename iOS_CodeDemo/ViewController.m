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
/**动画layer*/
@property (nonatomic, strong) CALayer *animateLayer;
/**动画图片*/
@property (nonatomic, strong) UIImageView *animateImageView;
/**按压值label*/
@property (nonatomic, strong) UILabel *forceLabel;
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
//    NSDictionary *dic = @{KWAttributesTextColor:[UIColor lightGrayColor]};
//    self.view.backgroundColor = dic[KWAttributesTextColor];
//    字符串长度的view
//    [self setUpKeyWordsView];
//    测试控制器categroy添加block传值
//    [self testOfControllerBlockDeliver];
//    测试按钮复制
//    [self testOfButtonResponser];
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
//    获取随机数字和字母组合
//    [self generateTradeNO];
    
    UIImage *image = [UIImage imageNamed:@"6.jpg"];
    CALayer *layer = [CALayer layer];
    layer.contents = (id)image.CGImage;
    layer.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    layer.position = CGPointMake(160, 200);
    [self.view.layer addSublayer:layer];
    _animateLayer = layer;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    imageView.frame = CGRectMake(100, 400, 100, 100);
    [self.view addSubview:imageView];
    _animateImageView = imageView;
    
    for (id layer in imageView.layer.sublayers) {
        NSLog(@"\n------------------%d------------------\n%s==%@",__LINE__,__func__,layer);
    }
    
    UILabel *forceLabel = [[UILabel alloc] init];
    forceLabel.frame = CGRectMake(100, 100, 100, 50);
    forceLabel.numberOfLines = 0;
    forceLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:forceLabel];
    _forceLabel = forceLabel;
    
}
//按住移动or压力值改变时的回调
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *arrayTouch = [touches allObjects];
    UITouch *touch = (UITouch *)[arrayTouch lastObject];
    //通过tag确定按压的是哪个view，注意：如果按压的是label，将label的userInteractionEnabled属性设置为YES
    NSLog(@"move压力 ＝ %f",touch.force);
    //红色背景的label显示压力值
    _forceLabel.text = [NSString stringWithFormat:@"压力：%f",touch.force];
        //红色背景的label上移的高度＝压力值*100
//        _bottom.constant = ((UITouch *)[arrayTouch lastObject]).force * 100;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
//    应用间调用
//    [self openAnotherApp];
//    地图页面
//    [self pushToMapVC];
    _animateLayer.transform = CATransform3DMakeScale(1.5, 1.5, 1);  // 将图片大小按照X轴和Y轴缩放90%，永久
    [UIView animateWithDuration:0.3 animations:^{
        _animateImageView.transform = CGAffineTransformScale(_animateImageView.transform, 1.5, 1.5);
    }];
    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity]; // 将目标值设为原值
//    animation.autoreverses = NO; // 自动倒回最初效果
//    animation.duration = 0.35;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.repeatCount = HUGE_VALF;
//    [_animateLayer addAnimation:animation forKey:@"pulseAnimation"];
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _animateLayer.transform = CATransform3DMakeScale(1.0/1.5, 1.0/1.5, 1);
    _animateImageView.transform = CGAffineTransformScale(_animateImageView.transform, 1.0/1.5, 1.0/1.5);
    _forceLabel.text = @"压力：0";
}
#pragma mark - WQLog == GET_NAME == CONTACT
- (void)logNameContactTest{
    NSString *helloworld = @"Hello, world!";
    NSString *jikkk = @"12121";
    TestController *spider;
    id vvv = [MapController new];
    WQLog(@"%@ \
          \n-----#start-----\
          \n%s\n%@\n%@\n%@\
          \n-----#e n d-----",CONCAT(hell, oworld),GET_NAME(spider),jikkk.class,spider.superclass,[vvv class]);
}
#pragma mark - 自定义关键词排列view，字符串长度的view
/**
 *  ----------------------------------------------------------------------
 *  字符串长度的view
 */
- (void)setUpKeyWordsView{
    NSArray *arr = @[@"撒大声地",@"爱上当",@"实打实",@"玩儿反而和妻儿和妻儿和妻儿啊飒飒大师大师的嘎嘎",@"阿司的风格的风格风格是地方东嘎",@"是打发斯蒂芬",@"爱上是对方复和史蒂夫是东风公司的分公司答复当上",@"阿斯顿噶尔",@"阿斯顿嘎斯蛋糕（）"];
    CGFloat maxWidth = SCREEN_WIDTH;
//    CGFloat height = [KeyWordsView getHeight:arr column:0 font:[UIFont systemFontOfSize:13] padding:5 margin:5 maxSubHeight:20 maxWidth:maxWidth];
    NSDictionary *attributes = @{KWAttributesMaxWidth:@(maxWidth),KWAttributesFont:[UIFont systemFontOfSize:20],KWAttributesLineHeight:@(30),KWAttributesLineSpacing:@(10),KWAttributesOutsideMargin:@(30)};
    CGFloat height = [KeyWordsView getHeight:arr attributes:attributes];
    
    KeyWordsView *keyWords = [[KeyWordsView alloc] initWithFrame:CGRectMake(0, 300, maxWidth, height)];
    keyWords.backgroundColor = [UIColor lightGrayColor];
    keyWords.keyWords = arr;
    keyWords.attributes = attributes;
    [self.view addSubview:keyWords];
}
#pragma mark - 获取随机数字和字母组合
/**
 *  ----------------------------------------------------------------------
 *  获取随机数字和字母组合
 */
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = arc4random() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
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
#pragma mark - 递归获取本地图片并保存到指定文件夹
//递归获取本地图片并保存到指定文件夹
- (void) findPictureAtPath:(NSString *)directoryPath
{
    // 保存递归到图片的文件夹路径  也可用代码创建文件夹 此处不在赘述
    NSString * saveDirectoryPath =@"/Users/macbook/Desktop/imageNames";
    // 获取文件管理器
    NSFileManager * fileManager = [NSFileManager defaultManager];
    // 获取路径下的所有文件和文件夹以字符串的形式保存在数组中
    NSArray * fileNames = [fileManager contentsOfDirectoryAtPath:directoryPath error:nil];
    // 遍历数组获取下级目录名
    for (NSString * fileName in fileNames) {
        // 拼接路径包括文件和文件夹的路径
        NSString * filePath = [directoryPath stringByAppendingPathComponent:fileName];
        // 判断 文件的后缀名是否是图片的格式  判断前缀名的方法是 hasPrefix:@" "
        if ([fileName hasSuffix:@"png"] ||
            [fileName hasSuffix:@"jpg"] ||
            [fileName hasSuffix:@"gif"]) {
            // 判断输入的字符是否有于文件相匹配的 模糊查询，去掉判断则直接把获取的图片复制到指定文件夹中
            //            if ([fileName rangeOfString:self.inputText.text].length >0) {
            // 为图片保存路径拼接文件名 下面的方法参数toPath:要求路径必须含有文件名
            NSString * newPath = [saveDirectoryPath stringByAppendingPathComponent:fileName];
            // 复制到指定路径
            [fileManager copyItemAtPath:filePath toPath:newPath error:nil];
            //            }
        }
        // 若是文件夹 则递归遍历
        BOOL isDirectory;
        if ([fileManager fileExistsAtPath:filePath isDirectory:&isDirectory] && isDirectory) {
            [self findPictureAtPath:filePath];
        }
    }
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
