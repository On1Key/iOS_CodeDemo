//
//  UIAlertController+Tellphone.m
//  firstNursingWorkers
//
//  Created by mac book on 15/12/15.
//  Copyright © 2015年 HB. All rights reserved.
//

#import "UIAlertController+Tellphone.h"

@implementation UIAlertController (Tellphone)
+ (void)alertControllerTelPhoneOfShowController:(UIViewController *)controller{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认拨打客服热线？" message:@"1234567890" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"1234567890"]]];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:sureAction];
    [alert addAction:cancelAction];
    [controller presentViewController:alert animated:YES completion:nil];
}
+ (void)alertControllerWithTitle:(NSString *)title subtitle:(NSString *)subTitle controller:(UIViewController *)controller sureAction:(SureClickd)sureClicked cancelAction:(SureClickd)cancelClicked{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:subTitle preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (sureClicked) {
             sureClicked(action);
        }
       
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelClicked) {
            cancelClicked(cancelAction);
        }
        
    }];
    [alert addAction:sureAction];
    [alert addAction:cancelAction];
    [controller presentViewController:alert animated:YES completion:nil];
}
/**进入设置界面*/
+ (void)openSettingOfShowController:(UIViewController *)controller{
    [UIAlertController alertControllerWithTitle:@"进入设置，修改定位权限" subtitle:@"" controller:controller sureAction:^(UIAlertAction *action) {
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }
    } cancelAction:^(UIAlertAction *action) {
        
    }];
}
@end
