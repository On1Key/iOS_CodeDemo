//
//  UITableView+Keyboard.h
//  firstNursingWorkers
//
//  Created by mac book on 16/3/22.
//  Copyright © 2016年 HB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Keyboard)
/**
 *  添加tableview的cell的键盘监听事件，修改对应cell的偏移量
 */
- (void)addResponserKeyboardNotification;
@end
