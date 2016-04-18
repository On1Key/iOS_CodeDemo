//
//  MainTableViewController.m
//  iOS_CodeDemo
//
//  Created by mac book on 16/4/1.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *vcClasses;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (NSArray *)data{
    if (!_data) {
        _data = @[@"Normal",
                  @"SystemPhoneBook",
                  @"MapTest"];
    }
    return _data;
}
- (NSArray *)vcClasses{
    if (!_vcClasses) {
        _vcClasses = @[@"ViewController",
                       @"PhoneViewController",
                       @"MapController"];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *className = self.vcClasses[indexPath.row];
    
    UIViewController *subViewController = [[NSClassFromString(className) alloc] init];
    
    subViewController.title   = self.data[indexPath.row];
    
    [self.navigationController pushViewController:(UIViewController*)subViewController animated:YES];
}

@end
