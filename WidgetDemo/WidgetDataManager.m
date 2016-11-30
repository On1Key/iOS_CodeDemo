//
//  WidgetDataManager.m
//  iOS_CodeDemo
//
//  Created by mac book on 16/11/30.
//  Copyright © 2016年 mac book. All rights reserved.
//



#import "WidgetDataManager.h"

@implementation WidgetDataManager
static NSString *const groupID = @"group.com.WidgetDemo.iOS_CodeDemo";
static NSString *const saveID = @"WidgetDemo.saveID";

/**获取数据模型*/
- (WidgetModel *)getWidgetData{
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:groupID];
    NSDictionary *data = [defaults objectForKey:saveID];
    
    WidgetModel *mainModel = [WidgetModel new];
    mainModel.title = data[@"t"];
    mainModel.imageName = data[@"i"];
    
    NSArray *modelDics = data[@"c"];
    NSMutableArray *models = [NSMutableArray array];
    for (int i = 0; i < modelDics.count; i ++) {
        WidgetModel *model = [WidgetModel new];
        NSDictionary *dic = modelDics[i];
        model.title = dic[@"t"];
        model.imageName = dic[@"i"];
        model.content = dic[@"c"];
        [models addObject:model];
    }
    mainModel.models = models;
    
    return mainModel;
}
/**保存数据模型*/
- (void)saveWidgetData:(NSDictionary *)modelDic{
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:groupID];
    [defaults setObject:modelDic forKey:saveID];
    [defaults synchronize];
    
}

@end
