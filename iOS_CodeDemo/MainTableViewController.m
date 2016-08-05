//
//  MainTableViewController.m
//  iOS_CodeDemo
//
//  Created by mac book on 16/4/1.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "MainTableViewController.h"
#import "RYCuteView.h"

@interface MainTableViewController ()<UIViewControllerTransitioningDelegate>
/**所有标题数组*/
@property (nonatomic, strong) NSArray *data;
/**所有vc name数组*/
@property (nonatomic, strong) NSArray *vcClasses;
/**普通控制器name数组*/
@property (nonatomic, strong) NSArray *codeVCS;
/**srotyboard控制的控制器name数组*/
@property (nonatomic, strong) NSArray *storyboardVCs;

@end

@implementation MainTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (NSArray *)data{
    if (!_data) {
        
        _data = @[//代码名称
                  @"Normal",
                  @"SystemPhoneBook",
                  @"MapTest",
                  @"FontFamilyNames",
                  @"Bezier&CGRef",
                  @"BezierTORefresh",
                  @"WQItem",
                  @"CoreAnim",
                  
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
                     @"CoreAnimationController"];
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
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGPoint offset = scrollView.contentOffset;
//    _cuteView.height = offset.y;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
