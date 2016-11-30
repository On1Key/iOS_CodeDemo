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
    
//    _backScrollView = [[UIScrollView alloc] init];
//    _backScrollView.frame = self.view.bounds;
//    [self.view addSubview:_backScrollView];
//    
//    _backScrollView.backgroundColor = [UIColor lightGrayColor];
//    _backScrollView.contentSize = CGSizeMake(0, 200);
    
//    717 * 292  72
    
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
    NSURL *photourl = [NSURL URLWithString:@"http://img1.imgtn.bdimg.com/it/u=3951583560,962001137&fm=21&gp=0.jpg"];
    //url请求实在UI主线程中进行的
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:photourl]];//通过网络url获取uiimage
    cell.imageView.image = image;
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
