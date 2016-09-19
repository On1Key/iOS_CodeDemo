//
//  WQItemController.m
//  iOS_CodeDemo
//
//  Created by mac book on 16/8/4.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "WQItemController.h"
#import "WQMenu.h"

#define DATA @[@"绅士",@"不要说话",@"刚刚好",@"丑八怪",@"谢谢侬（国语）",@"Thrill",@"Updown Funk Will",@"浮夸"]

@interface WQItemController ()<WQMenuDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) WQMenu *menuSame;
@property (nonatomic, strong) WQMenu *menuNormal;
@property (nonatomic, strong) UILabel *numLabel;
@end

@implementation WQItemController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self YPTabBarTest];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 88, SCREEN_WIDTH, SCREEN_HEIGHT - 88 - 10)];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(DATA.count * SCREEN_WIDTH, 0);
    
    _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.5 - SCREEN_WIDTH * 0.1, SCREEN_WIDTH, SCREEN_WIDTH * 0.3)];
    _numLabel.text = @"0";
    _numLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_numLabel];
    
    
    [self WQMenuTest];
}

- (void)WQMenuTest{
    WQMenu *menu = [[WQMenu alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 44)];
    menu.delegate = self;
    //    menu.titleNames = DATA;
    [self.view addSubview:menu];
    _menuNormal = menu;
    
    _menuNormal.titleNames = DATA;
    _menuNormal.showCenterSpacingLine = YES;
    //    _menu.showCenterSpacingLine = YES;
    //    menu.menuStyle = WQMenuStyleNormal;
    //    menu.menuUnderLineType = WQMenuUnderLineTypeTextLengthSame;
    
    
    
    WQMenu *menu1 = [[WQMenu alloc] initWithFrame:CGRectMake(10, 44, SCREEN_WIDTH - 20, 44)];
    menu1.delegate = self;
    //    menu.titleNames = DATA;
    [self.view addSubview:menu1];
    _menuSame = menu1;
    
    _menuSame.titleNames = DATA;
    _menuSame.showCenterSpacingLine = YES;
    _menuSame.menuStyle = WQMenuStyleTextLengthSame;
    
}
- (void)wqMenuDidSelectedItemIndex:(NSInteger)index{
    [self setViewIndex:index];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    [self setViewIndex:index];
}
- (void)setViewIndex:(NSInteger)index{
    _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * index,0);
    _menuNormal.selectedIndex = index;
    _menuSame.selectedIndex = index;
    
    [UIView animateWithDuration:1.5 animations:^{
        _numLabel.backgroundColor = COLOR_RANDOM;
        _numLabel.text = [@(index) stringValue];
    }];
    
    
    //    _tabBar.selectedItemIndex = index;
}
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    // setup a list of preview actions
    NSArray *actionTitles = @[DATA[3],DATA[5],DATA[7]];
    NSMutableArray *actions = [NSMutableArray array];
    for (int i = 0; i < actionTitles.count; i++) {
        UIPreviewAction *action = [UIPreviewAction actionWithTitle:actionTitles[i] style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
            NSLog(@"Jump into---%@",previewViewController);
            CustomNaviViewController *naviVC = (CustomNaviViewController*)[UIApplication sharedApplication].delegate.window.rootViewController;
            [naviVC pushViewController:previewViewController animated:YES];
            [self setViewIndex:[DATA indexOfObject:actionTitles[i]]];
        }];
        [actions addObject:action];
    }
    
    NSMutableArray *allActions = [NSMutableArray array];
    for (int i = 0; i < DATA.count; i ++) {
        UIPreviewAction *action = [UIPreviewAction actionWithTitle:DATA[i] style:i % 3 handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
            NSLog(@"Jump into---%@",previewViewController);
            CustomNaviViewController *naviVC = (CustomNaviViewController*)[UIApplication sharedApplication].delegate.window.rootViewController;
            [naviVC pushViewController:previewViewController animated:YES];
            [self setViewIndex:i];
        }];
        [allActions addObject:action];
    }
    
    UIPreviewActionGroup *group = [UIPreviewActionGroup actionGroupWithTitle:@"查看全部" style:UIPreviewActionStyleDestructive actions:allActions];
    // and return them (return the array of actions instead to see all items ungrouped)
    [actions addObject:group];
    return actions;
}

@end
