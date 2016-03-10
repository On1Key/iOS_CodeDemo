//
//  MapController.m
//  iOS_CodeDemo
//
//  Created by mac book on 16/3/10.
//  Copyright © 2016年 mac book. All rights reserved.
//

#pragma mark - 添加规范注释
/**
 *  ----------------------------------------------------------------------
 *  添加规范注释
 */

#import "MapController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MapSearchController.h"

@interface MapController ()<CLLocationManagerDelegate,MKMapViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
//manager
@property (nonatomic, strong) CLLocationManager *locationManager;
//地图
@property (nonatomic, strong) MKMapView *mapView;
//列表
@property (nonatomic, strong) UITableView *mapItemsTableView;
@property (nonatomic, strong) NSMutableArray *mapItems;
//编码
@property (nonatomic, strong) CLGeocoder *geocoder;
//搜索框
@property (nonatomic, strong) UITextField *inputTextField;
//地图中心点显示
@property (nonatomic, strong) UIView *pointView;
@end

@implementation MapController
#pragma mark - getter and setter
- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
            [_locationManager requestAlwaysAuthorization];
        }else{
            _locationManager.delegate = self;
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            _locationManager.distanceFilter = 10.f;
        }
    }
    return _locationManager;
}
- (MKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MKMapView alloc] init];
        //        _mapView.showsUserLocation = YES;
        _mapView.delegate = self;
        [self.view addSubview:_mapView];
    }
    return _mapView;
}
- (UITableView *)mapItemsTableView{
    if (!_mapItemsTableView) {
        _mapItemsTableView = [[UITableView alloc] init];
//        _mapItemsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mapItemsTableView.delegate = self;
        _mapItemsTableView.dataSource = self;
        [self.view addSubview:_mapItemsTableView];
    }
    return _mapItemsTableView;
}
- (NSMutableArray *)mapItems{
    if (!_mapItems) {
        _mapItems = [NSMutableArray array];
    }
    return _mapItems;
}
- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}
- (UITextField *)inputTextField{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.backgroundColor = [UIColor whiteColor];
        _inputTextField.placeholder = @"请输入地址";
        _inputTextField.font = [UIFont systemFontOfSize:14];
        _inputTextField.delegate = self;
        _inputTextField.returnKeyType = UIReturnKeySearch;
        [self.view addSubview:_inputTextField];
    }
    return _inputTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTitle:@"AMAP_MapTest"];
    //页面布局
    [self layoutUI];
    [self.locationManager startUpdatingLocation];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [self.view endEditing:YES];
}
#pragma mark - 系统自带高德定位
/**
 *  ----------------------------------------------------------------------
 *  系统自带高德定位
 *  系统定位需要修改info.plist文件，添加如下两行：
 *  NSLocationAlwaysUsageDescription和NSLocationWhenInUseUsageDescription
 *  两行的value都设置为yes
 */
#pragma mark locationManager delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = locations[0];
    //    CLLocationCoordinate2D coordinate = [WGS84TOGCJ02 transformFromWGSToGCJ:location.coordinate];
    //    coordinate = location.coordinate;
    [self encodeAddressByLocationCoordinate:location.coordinate];
    //    NSLog(@"\ncorrect:%f,%f\ncorrected:%f,%f",location.coordinate.longitude,location.coordinate.latitude,coordinate.longitude,coordinate.latitude);
    [manager stopUpdatingLocation];
    self.mapView.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.0045, 0.0045));
    //    [self locateToMapViewByLocationCoordinate:location.coordinate];
}
#pragma mark mapview delegate
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"---->%f,%f",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
    //    CLLocationCoordinate2D coord = [_mapView convertPoint:self.pointView.center toCoordinateFromView:self.view];
    [self encodeAddressByLocationCoordinate:mapView.centerCoordinate];
    self.mapView.region = mapView.region;
}
#pragma mark textfield delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"%s",__func__);
    [self.view endEditing:YES];
    MapSearchController *search = [MapSearchController new];
    [self.navigationController pushViewController:search animated:YES];
    return YES;
}

#pragma mark mapItemsTableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mapItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuse = @"map";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuse];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MKMapItem *mapItem = _mapItems[indexPath.row];
    cell.textLabel.text = mapItem.name;
    cell.detailTextLabel.text = mapItem.placemark.name;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MARGIN(44);
}
//初始化界面
- (void)layoutUI{
    
    self.mapView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT * 0.4);
    
    CGFloat mapTableY = CGRectGetMaxY(_mapView.frame);
    self.mapItemsTableView.frame = CGRectMake(0, mapTableY, _mapView.width, self.view.height - mapTableY);
    
    CGFloat inputX = 15.f;
    CGFloat inputWidth = self.mapView.width - inputX * 2;
    CGFloat inputHeight = 30.f;
    self.inputTextField.frame = CGRectMake(inputX, inputX + 64, inputWidth, inputHeight);
    self.inputTextField.layer.cornerRadius = 5.f;
    self.inputTextField.layer.masksToBounds = YES;
    
    UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(self.mapView.width * 0.5 - 3, self.mapView.height * 0.5 - 3 + 64, 6, 6)];
    pointView.backgroundColor = [UIColor redColor];
    [self.view addSubview:pointView];
    self.pointView = pointView;
    
}
//反地理编码
- (void)encodeAddressByLocationCoordinate:(CLLocationCoordinate2D)coordinate{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = placemarks[0];
        [self locateToMapViewByLocationCoordinate:placemark.location.coordinate naturalLanguageQuery:placemark.name];
    }];
    //    self.mapView.region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000);
    //    self.mapView.centerCoordinate = coordinate;
    //    MKCoordinateSpanMake(0.0045, 0.0045)
}
//地图定位显示附近兴趣点
- (void)locateToMapViewByLocationCoordinate:(CLLocationCoordinate2D)coordinate naturalLanguageQuery:(NSString *)naturalLanguageQuery{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000);
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.region = region;
    request.naturalLanguageQuery = naturalLanguageQuery;
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        [self.mapItems removeAllObjects];
        [self.mapItems addObjectsFromArray:response.mapItems];
        [self.mapItemsTableView reloadData];
    }];
}

@end
