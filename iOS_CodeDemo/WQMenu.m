//
//  WQMenu.m
//  RSA
//
//  Created by mac book on 16/7/18.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "WQMenu.h"

#define WQ_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define WQ_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define DEFAULT_FONT [UIFont systemFontOfSize:14]
#define DEFAULT_MARGIN_INSIDE 10
#define TAG_LINE 121212121212


@interface WQItem()
/**下划线*/
@property (nonatomic, strong) UIView *bottomLineView;
/**标题*/
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation WQItem

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = DEFAULT_FONT;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
//        [self addSubview:_bottomLineView];
    }
    return _bottomLineView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}
- (void)setSelected:(BOOL)selected{
    _selected = selected;
    if (selected) {
        [UIView animateWithDuration:1 animations:^{
            self.backgroundColor = [UIColor lightGrayColor];
            self.titleLabel.textColor = [UIColor brownColor];
        }];
    }else{
        [UIView animateWithDuration:1 animations:^{
            self.backgroundColor = [UIColor whiteColor];
            self.titleLabel.textColor = [UIColor blackColor];
        }];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    CGFloat botLineH = 5;
    CGFloat botLineW = selfWidth * 0.5;
    CGFloat botLineX = (selfWidth - botLineW) * 0.5;
    CGFloat botLineY = selfHeight - botLineH;
    self.bottomLineView.frame = CGRectMake(botLineX, botLineY, botLineW, botLineH);
    
    
    self.titleLabel.frame = CGRectMake(0, 0, selfWidth, selfHeight - botLineH);
    
//    self.bottomLineView.backgroundColor = RandomColor;
//    self.titleLabel.backgroundColor = RandomColor;
    
}

@end

#pragma mark ---------------------------------------------------

@interface WQMenu()<UIScrollViewDelegate>
/**标题view数组*/
@property (nonatomic, strong) NSMutableArray *itemViews;
/**标题长度数组*/
@property (nonatomic, strong) NSMutableArray *itemLengths;
/**item右侧分割线数组*/
@property (nonatomic, strong) NSMutableArray *itemCenterRightLines;
/**滚动视图*/
@property (nonatomic, strong) UIScrollView *itemsScrollView;
/**page滚动条*/
@property (nonatomic, strong) UIView *pageView;
/**未选中字体缩放*/
@property (nonatomic) CGFloat itemTitleUnselectedFontScale;
/**选中字体缩放*/
@property (nonatomic) CGFloat itemTitleselectedFontScale;
@property (nonatomic, strong) UIFont *itemTitleSelectedFont;
@property (nonatomic, strong) UIFont *itemTitleFont;
@end

@implementation WQMenu

#pragma mark - self
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedIndex = 0;
        self.menuUnderLineType = WQMenuUnderLineTypeItemLengthSame;
        self.menuStyle = WQMenuStyleNormal;
    }
    return self;
}

#pragma mark - get/set

- (UIScrollView *)itemsScrollView{
    if (!_itemsScrollView) {
        _itemsScrollView = [[UIScrollView alloc] init];
        _itemsScrollView.delegate = self;
        [self addSubview:_itemsScrollView];
    }
    return _itemsScrollView;
}
- (UIView *)pageView{
    if (!_pageView) {
        _pageView = [[UIView alloc] init];
        _pageView.backgroundColor = [UIColor redColor];
//        [self addSubview:_pageView];
    }
    return _pageView;
}

- (void)setMenuStyle:(WQMenuStyle)menuStyle{
    _menuStyle = menuStyle;
    [self setMenuStyleAndUnderLineStyle];
}
- (void)setMenuUnderLineType:(WQMenuUnderLineType)menuUnderLineType{
    _menuUnderLineType = menuUnderLineType;
    [self setMenuStyleAndUnderLineStyle];
}
- (void)setMenuStyleAndUnderLineStyle{
//    NSLog(@"menu==%ld==%ld",_menuStyle,_menuUnderLineType);
    [self setUpItemFrame];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    if (self.itemViews.count == 0 || selectedIndex < 0 || selectedIndex >= self.itemViews.count) {
        return;
    }
    
    _selectedIndex = selectedIndex;
    
    WQItem *item = self.itemViews[selectedIndex];
    //================font================
    //================font================
    
    
    //================font================
    self.itemTitleSelectedFont = [UIFont systemFontOfSize:16];
    self.itemTitleFont = [UIFont systemFontOfSize:14];
    for (int i = 0;i < self.itemViews.count;i ++) {
        WQItem *forItem = self.itemViews[i];
        if (i == selectedIndex) {
            forItem.selected = YES;
//            forItem.transform = CGAffineTransformMakeScale(self.itemTitleSelectedFontScale,
//                                                        self.itemTitleSelectedFontScale);
        }else{
            forItem.selected = NO;
//            forItem.transform = CGAffineTransformMakeScale(self.itemTitleUnselectedFontScale,
//                                                        self.itemTitleUnselectedFontScale);
        }
    }
    //================offset================
    // 修改偏移量
    CGFloat offsetX = item.center.x - self.itemsScrollView.frame.size.width * 0.5f;
    
    // 处理最小滚动偏移量
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    // 处理最大滚动偏移量
    CGFloat maxOffsetX = self.itemsScrollView.contentSize.width - self.itemsScrollView.frame.size.width;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    [self.itemsScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    //================设置滚动条================
    CGFloat pageW = [self getUnderLineWidthByWQMenuUnderLineTypeWithCurrentIndex:_selectedIndex];
    
    [UIView animateWithDuration:1 animations:^{
        CGRect pageF = _pageView.frame;
        pageF.size.width = pageW;
        _pageView.frame = pageF;
        _pageView.center = CGPointMake(item.center.x , _pageView.center.y);
        
    }];
    
//    NSLog(@"selectIndex==%@==%f==%f==%f",NSStringFromCGRect(item.frame),_pageView.centerX,_pageView.x,item.x);
}


- (void)setTitleNames:(NSArray *)titleNames{
    if (titleNames.count == 0) {
        return;
    }
    _titleNames = titleNames;
    
    [self createUI];
    
//    NSLog(@"length==%@",_itemLengths);
    
}
- (void)setShowCenterSpacingLine:(BOOL)showCenterSpacingLine{
    _showCenterSpacingLine = showCenterSpacingLine;
    if (self.itemViews.count == 0) {
        return;
    }
    
    [self createUI];
    
}
#pragma mark - custom

/**创建界面*/
- (void)createUI{
    [self clearData];
    _itemViews = [NSMutableArray array];
    _itemLengths = [NSMutableArray array];
    for (int i = 0; i < _titleNames.count; i ++) {
        WQItem *itemView = [[WQItem alloc] init];
        itemView.title = _titleNames[i];
        [self.itemsScrollView addSubview:itemView];
        [_itemViews addObject:itemView];
        
        CGFloat textWidth = [self getWidthByText:itemView.title];
        [_itemLengths addObject:@(textWidth)];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [itemView addGestureRecognizer:tap];
    }
    
    [self.itemsScrollView addSubview:self.pageView];
    
    
    if (self.showCenterSpacingLine) {
        
        _itemCenterRightLines = [NSMutableArray array];
        for (int i = 0; i < self.itemViews.count; i ++) {
            UIView *lineView = [[UIView alloc] init];
            lineView.tag = TAG_LINE;
            lineView.backgroundColor = [UIColor greenColor];
            [_itemsScrollView addSubview:lineView];
            [_itemCenterRightLines addObject:lineView];
        }
    }
    
    [self setUpItemFrame];
}

/**根据数据源设置frame*/
- (void)setUpItemFrame{
    
    CGFloat selfHeight = self.frame.size.height;
    
    self.itemsScrollView.frame = self.bounds;
    
    
    NSInteger count = _itemViews.count;
    CGFloat beginX = 0;
    //item之间的外间距
    CGFloat itemRightSpacing = 1;
    //item中间分割线y、h、w
    CGFloat centerLineH = selfHeight * 0.5;
    CGFloat centerLineY = (selfHeight - centerLineH) * 0.5;
    CGFloat centerLineW = 0.5;
    
    
    //item frame设置 / 中间分割线设置
    for (int i = 0; i < count; i ++) {
        WQItem *itemView = _itemViews[i];
        CGFloat itemW = [self getItemWidthByWQMenuStyleWithCurrentIndex:i];
        CGFloat itemH = selfHeight;
        itemView.frame = CGRectMake(beginX, 0, itemW, itemH);
        beginX += itemW + itemRightSpacing;
        
        //中间分割线设置
        if (self.showCenterSpacingLine && i < (count - 1)) {
            CGFloat centerLineX = beginX - (itemRightSpacing - centerLineW) * 0.5 - centerLineW;
            UIView *lineView = _itemCenterRightLines[i];
            lineView.frame = CGRectMake(centerLineX, centerLineY, centerLineW, centerLineH);
        }
    }
    
    self.itemsScrollView.contentSize = CGSizeMake(beginX, 0);
    
    
    
    [self setUpPageViewFrame];
    
}
/**设置下滑线frame*/
- (void)setUpPageViewFrame{
    
    CGFloat selfHeight = self.frame.size.height;
    
    NSInteger curIndex = _selectedIndex;
    
    CGFloat tab0L = [self getItemWidthByWQMenuStyleWithCurrentIndex:curIndex];
    
    WQItem *itemView = _itemViews[curIndex];
    itemView.selected = YES;
    
    CGFloat pageW = [self getUnderLineWidthByWQMenuUnderLineTypeWithCurrentIndex:curIndex];
    CGFloat pageX = (tab0L - pageW) * 0.5;
    CGFloat pageH = 3;
    CGFloat pageY = selfHeight - 3;
    
    self.pageView.frame = CGRectMake(pageX, pageY, pageW, pageH);
//    NSLog(@"tab0l==%f==%@",tab0L,NSStringFromCGRect(self.pageView.frame));
}
/**
 *  根据WQMenuStyle获取item宽度
 *  等比分配或者最长分配
 */
- (CGFloat)getItemWidthByWQMenuStyleWithCurrentIndex:(NSInteger)index{
    
    NSInteger count = _itemLengths.count;
    CGFloat selfWidth = self.frame.size.width;
    
    CGFloat itemW = 0;
    //item的左右内边距
    CGFloat itemInsideLRSpacing = DEFAULT_MARGIN_INSIDE;
    
    CGFloat maxLength = [[_itemLengths valueForKeyPath:@"@max.floatValue"] floatValue] + itemInsideLRSpacing * 2;
    CGFloat maxContent = maxLength * count;
    CGFloat realContent = [[_itemLengths valueForKeyPath:@"@sum.floatValue"] floatValue]  + itemInsideLRSpacing * 2 * count;
    //判断最长的长度*count是否大于控件宽度
    if (maxContent > selfWidth) {
        
        //判断实际item长度是否大于控件宽度
        if (realContent > selfWidth) {
            if (_menuStyle == WQMenuStyleNormal) {
                itemW = maxLength;
            }else if (_menuStyle == WQMenuStyleTextLengthSame){
                itemW = [_itemLengths[index] floatValue] + itemInsideLRSpacing * 2;
            }
        }else{//小于控件宽度等比分配
            if (count > 0) {
                itemW = selfWidth / count;
            }
        }
        
        
    }else{//小于控件宽度等比分配
        if (count > 0) {
            itemW = selfWidth / count;
        }
    }
    
    
    return itemW;
    
}
/**
 *  根据WQMenuUnderLineType获取下滑线的宽度
 */
- (CGFloat)getUnderLineWidthByWQMenuUnderLineTypeWithCurrentIndex:(NSInteger)index{
    CGFloat itemW = [self getItemWidthByWQMenuStyleWithCurrentIndex:index];
    CGFloat underLineW = 0;
    if (_menuUnderLineType == WQMenuUnderLineTypeItemLengthSame) {
        underLineW = itemW;
    }else if (_menuUnderLineType == WQMenuUnderLineTypeItemLengthHalf){
        underLineW = itemW * 0.5;
    }else if (_menuUnderLineType == WQMenuUnderLineTypeTextLengthSame){
        underLineW = [_itemLengths[index] floatValue];
    }
    return underLineW;
}
/**
 *  获取未选中字体与选中字体大小的比例
 */
- (CGFloat)itemTitleUnselectedFontScale {
    //    if (_itemTitleSelectedFont) {
    //        return self.itemTitleFont.pointSize / _itemTitleSelectedFont.pointSize;
    //    }
    return 1.0f;
}
/**
 *  获取中字体与选中字体大小的比例
 */
- (CGFloat)itemTitleSelectedFontScale {
    if (_itemTitleSelectedFont) {
        return _itemTitleSelectedFont.pointSize / self.itemTitleFont.pointSize;
    }
    return 1.0f;
}
/**获取文本宽度*/
- (CGFloat)getWidthByText:(NSString *)text{
    return [text boundingRectWithSize:CGSizeMake(WQ_SCREEN_WIDTH, WQ_SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DEFAULT_FONT} context:nil].size.width;
}
/**清除旧数据*/
- (void)clearData{
    [_itemViews removeAllObjects];
    _itemViews = nil;
    [_itemLengths removeAllObjects];
    _itemLengths = nil;
    for (UIView *subView in self.itemsScrollView.subviews) {
        if ([subView isKindOfClass:[WQItem class]]) {
            [subView removeFromSuperview];
        }
    }
    
    [_itemCenterRightLines removeAllObjects];
    _itemCenterRightLines = nil;
    
    for (UIView *subView in self.itemsScrollView.subviews) {
        if ([subView isMemberOfClass:[UIView class]] && subView.tag == TAG_LINE) {
            [subView removeFromSuperview];
        }
    }
}

#pragma mark - action

/**item的点击滑动事件*/
- (void)tapAction:(UIGestureRecognizer *)ges{
    WQItem *itemView = (WQItem *)ges.view;
    self.selectedIndex = [self.itemViews indexOfObject:itemView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(wqMenuDidSelectedItemIndex:)]) {
        [self.delegate wqMenuDidSelectedItemIndex:_selectedIndex];
    }
}


@end
