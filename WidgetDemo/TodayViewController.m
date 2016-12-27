//
//  TodayViewController.m
//  WidgetDemo
//
//  Created by mac book on 16/11/30.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "WidgetDataManager.h"
#import "AppDelegate.h"

static NSString *const identifier = @"reuseidentifier";
static CGFloat const cellH = 50;

@interface TodayViewController () <NCWidgetProviding,UITableViewDelegate,UITableViewDataSource>
/**背景scrollview*/
//@property (nonatomic, strong) UIScrollView *backScrollView;
/**主页tableview*/
@property (nonatomic, strong) UITableView *mainTable;
/**页面模型*/
@property (nonatomic, strong) WidgetModel *widgetModel;
@end

@implementation TodayViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _mainTable = [[UITableView alloc] initWithFrame:self.view.bounds];
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    [self.view addSubview:_mainTable];
    [_mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    _mainTable.rowHeight = cellH;
    
    
    _widgetModel = [[[WidgetDataManager alloc] init] getWidgetData];
    
//    self.preferredContentSize = CGSizeMake(375, 44 * 5);
    NSLog(@"\n------------------%d------------------\n%s==%@",__LINE__,__func__,NSHomeDirectory());
}
#pragma mark - UITableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _widgetModel.models.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    
    WidgetModel *model = _widgetModel.models[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.content;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 处理耗时操作的代码块...
        //url请求实在UI主线程中进行的
        NSURL *photourl = [NSURL URLWithString:@"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=426502052,480543478&fm=58"];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:photourl]];//通过网络url获取uiimage
        if (image) {
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                cell.imageView.image = image;
                [tableView reloadData];
            });
        }
        
    });
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WidgetModel *model = _widgetModel.models[indexPath.row];
    NSString *widgetURL = [NSString stringWithFormat:@"suibianxiE://qu=%@",model.title];
    NSURL*url = [NSURL URLWithString:widgetURL];
    [self.extensionContext openURL:url completionHandler:nil];
}
#pragma mark - NCWidgetProviding代理
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize{
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, cellH * 2);
    } else {
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, cellH * _widgetModel.models.count);
    }
}
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets{
    return UIEdgeInsetsZero;
}
- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    completionHandler(NCUpdateResultNewData);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
