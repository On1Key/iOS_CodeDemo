//
//  UIDevice+DeviceType.m
//
//  Created by mac book on 15/12/9.
//  Copyright © 2015年 HB. All rights reserved.
//

#import "UIDevice+DeviceType.h"
#import <sys/sysctl.h>
#import <sys/types.h>
#import <sys/utsname.h>

@implementation UIDevice (DeviceType)
+ (NSString*)currentMachine
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char* name = (char*)malloc(size);
    sysctlbyname("hw.machine", name, &size, NULL, 0);
    NSString* machine = [NSString stringWithCString:name];
    free(name);
    
    return machine;
}
+ (float)currentMachineFolat{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char* name = (char*)malloc(size);
    sysctlbyname("hw.machine", name, &size, NULL, 0);
    NSString* machine = [NSString stringWithCString:name];
    free(name);
    machine = [machine substringWithRange:NSMakeRange(6, 3)];
    machine = [machine stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"."];
    return [machine floatValue];
}
+ (NSString*)currentMachineName
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *model = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
//    NSString *model = [[UIDevice currentDevice] model];
    if ([model isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([model isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([model isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([model isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([model isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([model isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([model isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([model isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([model isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([model isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([model isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([model isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([model isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([model isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([model isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([model isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    
    if ([model isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([model isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([model isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([model isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([model isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    
    if ([model isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([model isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([model isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([model isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([model isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([model isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([model isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([model isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([model isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([model isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([model isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([model isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([model isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([model isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([model isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([model isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([model isEqualToString:@"iPad4,4"])      return @"iPad Mini 2G (WiFi)";
    if ([model isEqualToString:@"iPad4,5"])      return @"iPad Mini 2G (Cellular)";
    if ([model isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([model isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (Cellular)";
    if ([model isEqualToString:@"iPad6,8"])      return @"iPad Pro";
    
    
    if ([model isEqualToString:@"i386"])         return @"Simulator";
    if ([model isEqualToString:@"x86_64"])       return @"Simulator";
    
    NSLog(@"NOTE: Unknown device type: %@", model);
    return model;
}
+ (float)currentDeviceVersionFolat{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}
@end
