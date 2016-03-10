//
//  MapSearchController.m
//  iOS_CodeDemo
//
//  Created by mac book on 16/3/10.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "MapSearchController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapSearchController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UITableView *addressListTeableView;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) NSMutableArray *mapItems;
@property (nonatomic, copy) NSString *currentString;

@end

@implementation MapSearchController
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
- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}
- (NSMutableArray *)mapItems{
    if (!_mapItems) {
        _mapItems = [NSMutableArray array];
    }
    return _mapItems;
}
- (void)viewWillAppear:(BOOL)animated{
    [_searchTextField becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTitle:@"MapSearch"];
    self.view.backgroundColor = COLOR_RANDOM;
    _searchTextField = [[UITextField alloc] init];
    CGFloat marginLeft = MARGIN(15);
    CGFloat marginHeight = MARGIN(15) + 64;
    CGFloat textHeight = MARGIN(30);
    _searchTextField.frame = CGRectMake(marginLeft, marginHeight, SCREEN_WIDTH - marginLeft * 2, textHeight);
    _searchTextField.layer.cornerRadius = 5.f;
    _searchTextField.layer.masksToBounds = YES;
    _searchTextField.backgroundColor = [UIColor whiteColor];
    _searchTextField.delegate = self;
    [_searchTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventAllEditingEvents];
    _searchTextField.returnKeyType = UIReturnKeySearch;
    _searchTextField.placeholder = @"请输入搜索地址";
    [self.view addSubview:_searchTextField];
    
    
    
    _addressListTeableView = [[UITableView alloc] init];
    CGFloat listY = CGRectGetMaxY(_searchTextField.frame) + marginHeight + 200;
    CGFloat listHeight = SCREEN_HEIGHT - listY;
    _addressListTeableView.frame = CGRectMake(0, listY, SCREEN_WIDTH, listHeight);
//    _addressListTeableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _addressListTeableView.delegate = self;
    _addressListTeableView.dataSource = self;
    [self.view addSubview:_addressListTeableView];
    
    [self.locationManager startUpdatingLocation];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [self encodeLocationCoordinateByAddress:@"北京大学"];
}
#pragma mark locationManager delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = locations[0];
    [self encodeAddressByLocationCoordinate:location.coordinate];
    [manager stopUpdatingLocation];
    //    [self locateToMapViewByLocationCoordinate:location.coordinate];
}
#pragma mark - textfield delegate
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    _currentString = newString;
//    //    NSString *newString = [textField.text stringByAppendingString:string];
//    NSLog(@"change:{\n1.textField.text--->%@\n2.replacementString--->%@\n3.newString--->%@\n-------------------------------------------------------------------}",textField.text,string,newString);
//    [self encodeLocationCoordinateByAddress:newString];
//    return YES;
//}
- (void)textFieldChanged:(UITextField *)textField{
    //    NSLog(@"self:{\n%@\n-------------------------------------------------------------------}",textField.text);
    [self encodeLocationCoordinateByAddress:textField.text];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //    NSLog(@"return:{\n1.textField.text--->%@\n2._currentString--->%@\n-------------------------------------------------------------------}",textField.text,_currentString);
    [self encodeLocationCoordinateByAddress:textField.text];
    [self.view endEditing:YES];
    return YES;
}
#pragma mark - mapItemsTableview delegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}
#pragma mark - 地理编码
- (void)encodeLocationCoordinateByAddress:(NSString *)address{
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = placemarks[0];
        NSMutableArray *arr = [NSMutableArray array];
        for (CLPlacemark *mark in placemarks) {
            [arr addObject:mark.addressDictionary];
        }
        //        NSLog(@"---->>keyword:%@ >>>---->>%@",address,arr);
        [self locateToMapViewByLocationCoordinate:placemark.location.coordinate naturalLanguageQuery:placemark.name];
    }];
}
- (void)encodeAddressByLocationCoordinate:(CLLocationCoordinate2D)coordinate{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = placemarks[0];
        [self locateToMapViewByLocationCoordinate:placemark.location.coordinate naturalLanguageQuery:placemark.name];
        self.searchTextField.text = placemark.name;
    }];
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
        [self.addressListTeableView reloadData];
    }];
    
}

@end
