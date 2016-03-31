

#import "CustomNaviViewController.h"
#import "UIImage+Color.h"
#import "UIBarButtonItem+Extension.h"
#import "CustomNavigationBar.h"

//这里的NSShadow用法参考如下链接
//    http://blog.csdn.net/ys410900345/article/details/25976179

@interface CustomNaviViewController ()<UIGestureRecognizerDelegate>

@end

@implementation CustomNaviViewController

#pragma mark - getter and setter
#pragma mark - life cycle 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // KVC 替换导航栏为自定义导航栏
//    [self setValue:[[CustomNavigationBar alloc]init] forKeyPath:@"navigationBar"];
    
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 64)] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage imageWithColor:[UIColor colorWithWhite:0.5 alpha:1.000] size:CGSizeMake(SCREEN_WIDTH, 0.2)];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationItem.backBarButtonItem.width = -50;
    
    // 设置导航栏手势滑动返回
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    
}

/**
 * 当第一次使用这个类的时候调用1次
 */
+ (void)initialize{
    // 设置NavigationBar的主题
    [self setupNavigationBarTheme];
    // 设置UIBarbuttonItem的主题
    [self setupBarButtonItemTheme];
    
}
/**
 * 拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    // 如果现在push的不是栈底控制器（根控制器）
    if (self.viewControllers.count>0) {
        // 隐藏底部tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置导航栏按钮
        UIBarButtonItem *leftBarButon =[UIBarButtonItem itemWithImageName:@"back" highImageName:@"back" taget:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem = leftBarButon;
        
        UIBarButtonItem *rightBarButon =[[UIBarButtonItem alloc]initWithTitle:@"ToRoot" style:UIBarButtonItemStyleDone target:self action:@selector(complateClick)];
        viewController.navigationItem.rightBarButtonItem = rightBarButon;
    }
//    如何防止navigation多次push一个页面?有时候网慢，点了一下没反应，用户可能就多点几下，这时候会打开好几个一样的页面:
//    
//    写了一个navigation基类,重写了push方法:传进来要push的控制器,然后判断该控制器是否已经压入栈顶,
    if (![[super topViewController] isKindOfClass:[viewController class]]) {
        [super pushViewController:viewController animated:animated];
    }
    
}



#pragma mark - delegate 代理方法
#pragma mark - private methods 私有方法
/**
 * 设置NavigationBar的主题
 */
+ (void)setupNavigationBarTheme{
    UINavigationBar *appearance = [UINavigationBar appearance];
    // 设置导航栏背景
    [appearance setBackgroundImage:[UIImage imageWithColor:COLOR_RANDOM size:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 64)] forBarMetrics:UIBarMetricsDefault];
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //    textAttrs[UITextAttributeFont]=[UIFont boldSystemFontOfSize:20];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    // 设置取消阴影 UIOffsetZero是结构体，只有包装成NSValue对象，才能放进字典/数组
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    
//    textAttrs[NSShadowAttributeName] = [NSShadow alloc]
    [appearance setTitleTextAttributes:textAttrs];
    
    
}
/**
 * 设置UIBarbuttonItem的主题
 */
+ (void)setupBarButtonItemTheme{
    
    
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    /**设置文字属性**/
    // 设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[UITextAttributeTextColor] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置高亮状态的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[NSFontAttributeName] = [UIColor whiteColor];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    // 设置不可用状态(disable)的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    /**设置背景**/
    // 技巧: 为了让某个按钮的背景消失, 可以设置一张完全透明的背景图片
    //    [appearance setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

#pragma mark - Response event 响应事件

/**
 * 返回上级控制器
 */
- (void)back{
    [self popViewControllerAnimated:YES];
}
/**
 * 返回主控制器
 */
- (void)complateClick{
    [self popToRootViewControllerAnimated:YES];
}

@end
