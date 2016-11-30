//
//  NotificateController.m
//  iOS_CodeDemo
//
//  Created by mac book on 16/9/26.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "NotificateController.h"
//#import <NotificationCenter/NotificationCenter.h>
#import <UserNotifications/UserNotifications.h>
#import "AlertView.h"

@interface NotificateController ()<UNUserNotificationCenterDelegate>

@end

@implementation NotificateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"asdas" object:nil];
    
//    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
//        if (granted) {
//            NSLog(@"allow UNNotification");
//        }else{
//            NSLog(@"not allowd UNUserNotification");
//        }
//    }];
    
    NSArray *titles = @[@"UILocalNotification",@"UNUserNotificationCenter"];
    for (int i = 0; i < 2; i ++) {
        AlertView *alert = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AlertView class]) owner:self options:nil][0];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(localNoti:)];
        [alert addGestureRecognizer:tap];
        [self.view addSubview:alert];
        
        alert.tag = i;
        alert.width = SCREEN_WIDTH * 0.8;
        alert.x = SCREEN_WIDTH * 0.1;
        
        alert.y = i * alert.height + 100;
        alert.titleLabel.text = titles[i];
        
    }

    
    
}
/**将要发送通知的代理，和UNUserNotificationCenter的回调CompletionHandler是一致的*/
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSLog(@"\n------------------%d------------------\n%s",__LINE__,__func__);
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound);
}
/**接受本通知的代理会屏蔽appdelegate里面的接受*/
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler{
    NSLog(@"\n------------------%d------------------\n%s\
          \nres.actID=%@\
          \ncatID=%@\n%@",__LINE__,__func__,response.actionIdentifier,response.notification.request.content.categoryIdentifier, [response.actionIdentifier isEqualToString:@"textAct"] ? [(UNTextInputNotificationResponse *)response userText] : @"nil");
    
    if ([response.actionIdentifier isEqualToString:@"jumpAct"]) {
        [UIAlertController alertControllerWithTitle:@"jumpAct" subtitle:@"subTitlte" controller:self sureAction:^(UIAlertAction *action) {
            
        } cancelAction:^(UIAlertAction *action) {
            
        }];
    }
    
    completionHandler();
}
- (void)localNoti:(UIGestureRecognizer *)ges{
    NSLog(@"\n------------------%d------------------\n%s",__LINE__,__func__);
    
    NSInteger tag = ges.view.tag;
    if (tag == 1) {
        
        
        if (IOS_VERSION < 10.0){
            NSLog(@"版本低于10.0不支持");
            return;
        };
        
        //本地通知多媒体---图片
        UNNotificationAttachment *notiAtt0 = [UNNotificationAttachment attachmentWithIdentifier:@"notiAtt0" URL:[[NSBundle mainBundle] URLForResource:@"aa" withExtension:@"jpg"] options:nil error:nil];
        UNNotificationAttachment *notiAtt1 = [UNNotificationAttachment attachmentWithIdentifier:@"notiAtt1" URL:[[NSBundle mainBundle] URLForResource:@"bb" withExtension:@"jpg"] options:nil error:nil];
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObject:notiAtt0];
        [arr addObject:notiAtt1];
        
        //通知内容
        UNMutableNotificationContent *notiCon = [UNMutableNotificationContent new];
        notiCon.title = @"noti content title";
        notiCon.body = @"noti content body";
        notiCon.userInfo = @{@"unnoti userinfo key" : @"unnoti userinfo value"};
        notiCon.categoryIdentifier = @"input";
        notiCon.attachments = arr;
        
        //触发时机
        UNTimeIntervalNotificationTrigger *notiTri = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
        
        //通知请求
        UNNotificationRequest *notiReq = [UNNotificationRequest requestWithIdentifier:@"notiReq" content:notiCon trigger:notiTri];
        
        //通知中心添加请求
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center addNotificationRequest:notiReq withCompletionHandler:^(NSError * _Nullable error) {
            NSLog(@"UNNoti completionHandler");
        }];
        
        return;
    }
    
    
    
    
    //告诉它有一个本地通知
    //2:创建一个本地推送通知对象
    UILocalNotification*local=[[UILocalNotification alloc]init];
    
    
    //给这些属性赋值才能让通知有特定的内容
    local.alertBody=@"女神:在吗?";
    local.alertTitle = @"FROM GOD";
    
    //特定的时间让显示出来(从现在5秒后显示出来)
    local.fireDate=[NSDate dateWithTimeIntervalSinceNow:5];
    
    //滑动解锁的文字(在推送通知信息的下面一小行字)
    local.alertAction =@"约";
    
    //有声音给声音,没声音用默认的
    local.soundName=@"UILocalNotificationDefaultSoundName";
    
    //设置图标右上角数字
    local.applicationIconBadgeNumber=1;
    
    //用户信息
    local.userInfo=@{@"name":@"女神",@"content":@"在不",@"time":[[NSDate date] description]};
    
    //3:定制一个通知
    [[UIApplication sharedApplication]scheduleLocalNotification:local];
    
    
    
    /*
     
     // timer-based scheduling  特定的时间发出通知
     
     @property(nonatomic,copy) NSDate *fireDate;触发时间
     
     @property(nonatomic,copy) NSTimeZone *timeZone;时区
     
     @property(nonatomic) NSCalendarUnit repeatInterval;重复间隔
     
     @property(nonatomic,copy) NSCalendar *repeatCalendar;重复间隔
     
     @property(nonatomic,copy) CLRegion *region NS_AVAILABLE_IOS(8_0);区域
     
     @property(nonatomic,assign) BOOL regionTriggersOnce NS_AVAILABLE_IOS(8_0);决定区域的一个BOOL值
     
     // alerts警告
     
     @property(nonatomic,copy) NSString *alertBody; 提醒的主题
     
     @property(nonatomic) BOOL hasAction; NO不显示滑动解锁按钮  反之显示
     
     @property(nonatomic,copy) NSString *alertAction; 滑动解锁的文字
     
     @property(nonatomic,copy) NSString *alertLaunchImage;  点击通知横幅的时候启动程序的启动 图片
     
     @property(nonatomic,copy) NSString *alertTitle 提示的标题文字NS_AVAILABLE_IOS(8_2);
     
     // sound
     
     @property(nonatomic,copy) NSString *soundName; 伴随的声音,默认的是UILocalNotificationDefaultSoundName
     
     // badge
     
     @property(nonatomic) NSInteger applicationIconBadgeNumber;图标右上角的数字
     
     // user info
     
     @property(nonatomic,copy) NSDictionary *userInfo;用户指定的携带参数,转换成键值对放在字典里面
     
     @property (nonatomic, copy) NSString *category NS_AVAILABLE_IOS(8_0);分类
     
     */
    
}

@end
