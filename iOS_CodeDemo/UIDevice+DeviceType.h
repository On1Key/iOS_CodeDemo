//
//  UIDevice+DeviceType.h
//
//  Created by mac book on 15/12/9.
//  Copyright © 2015年 HB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (DeviceType)
+ (NSString *)currentMachine;
+ (float)currentMachineFolat;
+ (NSString*)currentMachineName;
+ (float)currentDeviceVersionFolat;
@end
