//
//  WQMenu.h
//  RSA
//
//  Created by mac book on 16/7/18.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WQItem : UIView
/**标题*/
@property (nonatomic, copy) NSString *title;
/**选中状态*/
@property (nonatomic) BOOL selected;

@end

//---------------------------------------------------

/**menu的显示样式*/
typedef NS_ENUM(NSInteger,WQMenuStyle){
    /**显示为最大字符长度的等长排布*/
    WQMenuStyleNormal,
    /**文本长+20*/
    WQMenuStyleTextLengthSame,
    /**自定义*/
    WQMenuStyleCustom,
};

/**底部线条(下滑线)的显示样式*/
typedef NS_ENUM(NSInteger,WQMenuUnderLineType){
    /**与item等长*/
    WQMenuUnderLineTypeItemLengthSame,
    /**item半长*/
    WQMenuUnderLineTypeItemLengthHalf,
    /**与文本等长*/
    WQMenuUnderLineTypeTextLengthSame,
    /**无下滑线*/
    WQMenuUnderLineTypeNone,
    /**自定义*/
    WQMenuUnderLineTypeCustom,
};

@class WQMenu;
@protocol WQMenuDelegate <NSObject>

- (void)wqMenuDidSelectedItemIndex:(NSInteger)index;

@end

@interface WQMenu : UIView
/**标题数组*/
@property (nonatomic, strong) NSArray *titleNames;
/**回调代理*/
@property (nonatomic, assign) id<WQMenuDelegate> delegate;
/**menu的显示样式*/
@property (nonatomic, assign) WQMenuStyle menuStyle;
/**底部线条的显示样式*/
@property (nonatomic, assign) WQMenuUnderLineType menuUnderLineType;
/**中间分割线*/
@property (nonatomic, assign) BOOL showCenterSpacingLine;
/**当前index*/
@property (nonatomic, assign) NSInteger selectedIndex;
@end
