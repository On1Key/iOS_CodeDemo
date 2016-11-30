//
//  WidgetModel.h
//  iOS_CodeDemo
//
//  Created by mac book on 16/11/30.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WidgetModel : NSObject
/**标题*/
@property (nonatomic, copy) NSString *title;
/**图片*/
@property (nonatomic, copy) NSString *imageName;
/**内容*/
@property (nonatomic, copy) NSString *content;
/**多行介绍*/
@property (nonatomic, strong) NSArray<WidgetModel *> *models;
@end
