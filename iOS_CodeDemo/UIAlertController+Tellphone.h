//
//  UIAlertController+Tellphone.h
//  firstNursingWorkers
//
//  Created by mac book on 15/12/15.
//  Copyright © 2015年 HB. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SureClickd)(UIAlertAction *action);

@interface UIAlertController (Tellphone)
/**
 *  弹出客服电话
 */
+ (void)alertControllerTelPhoneOfShowController:(UIViewController *)controller;
/**
 *  弹出提示
 */
+ (void)alertControllerWithTitle:(NSString *)title subtitle:(NSString *)subTitle controller:(UIViewController *)controller sureAction:(SureClickd)sureClicked cancelAction:(SureClickd)cancelClicked;
/**进入app权限设置界面*/
+ (void)openSettingOfShowController:(UIViewController *)controller;
@end
