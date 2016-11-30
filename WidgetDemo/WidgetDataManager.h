//
//  WidgetDataManager.h
//  iOS_CodeDemo
//
//  Created by mac book on 16/11/30.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WidgetModel.h"

@interface WidgetDataManager : NSObject
/**获取数据模型*/
- (WidgetModel *)getWidgetData;
/**保存数据模型,由于group app和原app不能共用，所以此方法暂未使用，直接在MainTableViewController写的数据*/
- (void)saveWidgetData:(NSDictionary *)modelDic;
@end
