//
//  AppDelegate.m
//  iOS_CodeDemo
//
//  Created by mac book on 16/3/9.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTableViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "NotificateController.h"
// 3D Touch标签
#define AppItem_BezerPath  @"BezerPath"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //webCache
    [NSURLProtocol registerClass:[RNCachingURLProtocol class]];//way1
//    [NSURLProtocol registerClass:[CacheURLProtocol class]];//way2
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MainTableViewController *vc = [MainTableViewController new];
    //此处可以适用一个CustomNaviViewController
    _window.rootViewController = [[CustomNaviViewController alloc] initWithRootViewController:vc];
//    _window.rootViewController = [NSClassFromString(@"CoreAnimationController") new];
    [vc setUpTitle:@"Main"];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
//    NSLog(@"\n------------------%d------------------\n%s==%@",__LINE__,__func__,NSHomeDirectory());
    //3D touch
    [self shortcutButton];
    
    //本地通知注册 |:位移运算符
    UIUserNotificationSettings *seting=[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication]registerUserNotificationSettings:seting];
    /**注册通知category*/
    [self registNotiCategory];
    
    return YES;
}
/**从widget跳转回来进入对应界面*/
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    NSArray *arr = @[@"ViewController",
      @"PhoneViewController",
      @"MapController",
      @"FontTableController",
      @"Bezier_CGRefController",
      @"BezierTORefreshController",
      @"WQItemController",
      @"CoreAnimationController",
      @"WebCacheController",
      @"NotificateController"];
    
    NSString* prefix = @"suibianxiE://qu=";
    
    if ([[url absoluteString] rangeOfString:prefix].location != NSNotFound) {
        NSString* action = [[url absoluteString] substringFromIndex:prefix.length];
        if ([arr containsObject:action]) {
            [(UINavigationController *)_window.rootViewController pushViewController:[NSClassFromString(action) new] animated:YES];
        }
    }
    
    return YES;
}
/**
 * 创建快捷app图标
 */
- (void)shortcutButton{
    if(IOS_VERSION<9.0)return;
    
    //创建app快捷图标
    UIApplicationShortcutItem * itemPath = [[UIApplicationShortcutItem alloc]initWithType:AppItem_BezerPath localizedTitle:AppItem_BezerPath localizedSubtitle:@"💕" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeFavorite] userInfo:nil];
    // 添加
    [UIApplication sharedApplication].shortcutItems = @[itemPath];
    
}
/**通过3D Touch进入*/
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler{
    
    if([shortcutItem.type isEqualToString:AppItem_BezerPath] && shortcutItem){
        CustomNaviViewController *naviVC = (CustomNaviViewController*)[UIApplication sharedApplication].delegate.window.rootViewController;
        [naviVC pushViewController:[NSClassFromString(@"Bezier_CGRefController") new] animated:YES];
    }
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"\n------------------%d------------------\n%s\n%@",__LINE__,__func__,notification.userInfo);
}
/**注册一个unnotification的category*/
- (void)registNotiCategory{
    
    UNTextInputNotificationAction *textAct = [UNTextInputNotificationAction actionWithIdentifier:@"textAct" title:@"textAct" options:UNNotificationActionOptionAuthenticationRequired textInputButtonTitle:@"去noti查看输出" textInputPlaceholder:@"textPlaceholder"];
    
    UNNotificationAction *jumpAct = [UNNotificationAction actionWithIdentifier:@"jumpAct" title:@"jumpAct" options:UNNotificationActionOptionNone];
    
    UNNotificationAction *cancelAct = [UNNotificationAction actionWithIdentifier:@"cancelAct" title:@"cancelAct" options:UNNotificationActionOptionDestructive];
    
    UNNotificationCategory *inputCat = [UNNotificationCategory categoryWithIdentifier:@"input" actions:@[textAct,jumpAct,cancelAct] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObject:inputCat]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
