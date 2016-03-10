//
//  UIBarButtonItem+Extension.h
//  天天微博
//
//  Created by tarena on 15/6/13.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName
                         highImageName:(NSString *)highImageName
                                 taget:(id)target
                                action:(SEL)action;
@end
