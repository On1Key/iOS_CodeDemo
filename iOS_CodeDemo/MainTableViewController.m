//
//  MainTableViewController.m
//  iOS_CodeDemo
//
//  Created by mac book on 16/4/1.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "MainTableViewController.h"
#import "RYCuteView.h"

@interface MainTableViewController ()<UIViewControllerTransitioningDelegate,UIViewControllerPreviewingDelegate>
/**所有标题数组*/
@property (nonatomic, strong) NSArray *data;
/**所有vc name数组*/
@property (nonatomic, strong) NSArray *vcClasses;
/**普通控制器name数组*/
@property (nonatomic, strong) NSArray *codeVCS;
/**srotyboard控制的控制器name数组*/
@property (nonatomic, strong) NSArray *storyboardVCs;
/**<#注释#>*/
//@property (nonatomic, strong) UIView *redView;

@end

@implementation MainTableViewController
//- (UIView *)redView{
//    if (!_redView) {
//        _redView = [UIView new];
//        [self.tableView.superview addSubview:_redView];
//    }
//    return _redView;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    id obj = @{@"t":@"for life",
               @"i":@"",
               @"c":@[@{@"t":self.codeVCS[0],@"i":@"",
                        @"c":@"132423爱打打分阿斯顿发的说法发送到发送到非23141234阿萨飒飒阿萨德法师打发斯蒂芬阿斯顿发生的发生大飒飒大师阿萨德法师打发"},
                      @{@"t":self.codeVCS[3],@"i":@"",
                        @"c":@"阿萨德法师打发斯蒂芬啊啊啊的"},
                      @{@"t":self.codeVCS[4],@"i":@"",
                        @"c":@"阿达阿士大夫的阿萨德大法师打发打发大啊阿萨德阿达的发送到发送到"},
                      @{@"t":self.codeVCS[5],@"i":@"",
                        @"c":@"啊阿萨德法师打发阿萨德法搜代发阿斯顿发阿斯顿发大水但是发的说法阿斯顿发的沙发斯蒂芬阿斯顿发按说"},
                      @{@"t":self.codeVCS[6],@"i":@"",
                        @"c":@"11111111111111111111111111"}]};
    [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.WidgetDemo.iOS_CodeDemo"] setObject:obj forKey:@"WidgetDemo.saveID"];
    [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.WidgetDemo.iOS_CodeDemo"] synchronize];
    
    
    
    
}
//- (void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//    self.tableView.width = SCREEN_WIDTH * 0.5;
//    
//    self.redView.frame = CGRectMake(SCREEN_WIDTH * 0.5 + 20, 200, 100, 100);
//    self.redView.backgroundColor = [UIColor redColor];
//    
//    NSLog(@"\n------------------%d------------------\n%s--%@--%@",__LINE__,__func__,NSStringFromClass(self.tableView.superview.class),self.tableView.superview);
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(SCREEN_WIDTH * 0.5 + 20, 64 + 20, 100, 100);
//    label.backgroundColor = [UIColor lightGrayColor];
//    label.text = @"label";
//    label.font = [UIFont systemFontOfSize:14];
//    label.textColor = [UIColor blackColor];
//    label.numberOfLines = 0;
//    label.textAlignment = NSTextAlignmentCenter;
//    [self.tableView.superview addSubview:label];
//}
- (NSArray *)data{
    if (!_data) {
        
        _data = @[//代码名称
                  @"Normal",
                  @"SystemPhoneBook",
                  @"MapTest",
                  @"FontFamilyNames",
                  @"Bezier&CGRef",
                  @"BezierTORefresh",
                  @"WQItem(3D Touch)",
                  @"CoreAnim",
                  @"WebCache",
                  @"Notificate",
                  
                  //storyBoard名称
                  @"StreamMedia"];
    }
    return _data;
}
- (NSArray *)codeVCS{
    if (!_codeVCS) {
        _codeVCS = @[@"ViewController",
                     @"PhoneViewController",
                     @"MapController",
                     @"FontTableController",
                     @"Bezier_CGRefController",
                     @"BezierTORefreshController",
                     @"WQItemController",
                     @"CoreAnimationController",
                     @"WebCacheController",
                     @"NotificateController"];
    }
    return _codeVCS;
}
- (NSArray *)storyboardVCs{
    if (!_storyboardVCs) {
        _storyboardVCs = @[@"StreamMediaController"];
    }
    return _storyboardVCs;
}
- (NSArray *)vcClasses{
    if (!_vcClasses) {
        _vcClasses = [NSArray arrayWithArray:self.codeVCS];
        _vcClasses = [_vcClasses arrayByAddingObjectsFromArray:self.storyboardVCs];
    }
    return _vcClasses;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifer = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifer];
    }
    if (IOS_VERSION >=9) {
        if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            NSLog(@"3D Touch  可用!");
            //给cell注册3DTouch的peek（预览）和pop功能
            [self registerForPreviewingWithDelegate:self sourceView:cell];
        } else {
            NSLog(@"3D Touch 无效");
        }
    }
    
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGPoint offset = scrollView.contentOffset;
//    _cuteView.height = offset.y;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *className = self.vcClasses[indexPath.row];
    UIViewController *nextVC;
    if ([self.codeVCS containsObject:className]) {
        nextVC = [[NSClassFromString(className) alloc] init];
    }else if ([self.storyboardVCs containsObject:className]){
        UIStoryboard *board = [UIStoryboard storyboardWithName:className bundle:nil];
        nextVC = [board instantiateViewControllerWithIdentifier:className];
    }
    
    //某些界面presnet过去
    if ([className containsString:@"Media"]) {
        //自定义present动画
        nextVC.transitioningDelegate = self;
        nextVC.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:nextVC animated:YES completion:nil];
        return;
    }
    
    if (nextVC != nil && [nextVC isKindOfClass:[UIViewController class]]) {
        nextVC.title = self.data[indexPath.row];
        [self.navigationController pushViewController:nextVC animated:YES];
        return;
    }
    

}
#pragma mark - UIViewControllerPreviewingDelegate
//peek(预览)
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    //获取按压的cell所在行，[previewingContext sourceView]就是按压的那个视图
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    
    //设定预览的界面
    NSString *className = self.vcClasses[indexPath.row];
    UIViewController *peekVC = [NSClassFromString(className) new];
    peekVC.preferredContentSize = CGSizeMake(0.0f,500.0f);
//    peekVC.str = [NSString stringWithFormat:@"我是%@,用力按一下进来",className];
    
    //调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面）
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width,40);
    previewingContext.sourceRect = rect;
    
    //返回预览界面
    return peekVC;
}

//pop（按用点力进入）
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self showViewController:viewControllerToCommit sender:self];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [PresentingAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [DismissingAnimator new];
}

@end
