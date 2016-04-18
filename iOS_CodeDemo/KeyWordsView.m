//
//  KeyWordsView.m
//  firstNursingWorkers
//
//  Created by mac book on 16/3/16.
//  Copyright © 2016年 HB. All rights reserved.
//


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define DEFAULT_FONT [UIFont systemFontOfSize:14]
#define DEFAULT_COLOR_BACKGROUND [UIColor whiteColor]
#define DEFAULT_COLOR_TEXT [UIColor blackColor]
#define DEFAULT_LINE_HEIGHT 30.f


#import "KeyWordsView.h"

@interface KeyWordsView()
@property (nonatomic, strong) NSMutableArray *keyWordsLables;
@property (nonatomic, strong) NSMutableArray *keyWordsViews;
@end

@implementation KeyWordsView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.keyWordsLables = [NSMutableArray array];
        self.keyWordsViews = [NSMutableArray array];
    }
    return self;
}
- (void)setAttributes:(NSDictionary *)attributes{
    _attributes = attributes;
    if (self.keyWordsLables.count != 0) {
        for (UILabel *keyWordLabel in self.keyWordsLables) {
            [self layoutKeyWordsLabelAttributeToLabel:keyWordLabel];
        }
    }
}
- (void)setKeyWords:(NSArray *)keyWords{
    _keyWords = keyWords;
    for (int i = 0; i < keyWords.count; i ++) {
        
        UIView *keyView = [[UIView alloc] init];
        keyView.backgroundColor = COLOR_RANDOM;
        [self addSubview:keyView];
        [self.keyWordsViews addObject:keyView];
        
        
        UILabel *keyWordLabel = [[UILabel alloc] init];
        [self layoutKeyWordsLabelAttributeToLabel:keyWordLabel];
        keyWordLabel.text = keyWords[i];
//        keyWordLabel.numberOfLines = 0;
        [self addSubview:keyWordLabel];
        [self.keyWordsLables addObject:keyWordLabel];
    }
    
}
- (void)layoutKeyWordsLabelAttributeToLabel:(UILabel *)keyWordLabel{
    keyWordLabel.font = self.attributes[KWAttributesFont] ? self.attributes[KWAttributesFont] : DEFAULT_FONT
    ;
    keyWordLabel.backgroundColor = self.attributes[KWAttributesBackgroundColor] ? self.attributes[KWAttributesBackgroundColor] : DEFAULT_COLOR_BACKGROUND;
    keyWordLabel.textColor = self.attributes[KWAttributesTextColor] ? self.attributes[KWAttributesTextColor] : DEFAULT_COLOR_TEXT;
    keyWordLabel.textAlignment = [_attributes[KWAttributesTextAlignment] intValue];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    int column = [self.attributes[KWAttributesColumn] intValue];
    CGFloat maxWidth = [self.attributes[KWAttributesMaxWidth] floatValue] ? [self.attributes[KWAttributesMaxWidth] floatValue] : SCREEN_WIDTH;
    CGFloat lineHeight = [self.attributes[KWAttributesLineHeight] floatValue] ? [self.attributes[KWAttributesLineHeight] floatValue] :DEFAULT_LINE_HEIGHT;
    CGFloat insidePadding = [self.attributes[KWAttributesInsidePadding] floatValue];
    CGFloat lineSpacing = [self.attributes[KWAttributesLineSpacing] floatValue];
    CGFloat outsideMargin = [self.attributes[KWAttributesOutsideMargin] floatValue];
    float radious = [self.attributes[KWAttributesRadious] floatValue];
    UIFont *font = self.attributes[KWAttributesFont] ? self.attributes[KWAttributesFont] : DEFAULT_FONT;
    
    if (column <= 1) {
        CGFloat beginX = 0;
        CGFloat beginY = 0;
        for (int i = 0; i < self.keyWordsLables.count; i ++) {
            
            UILabel *keyWordLabel = self.keyWordsLables[i];
            
            CGSize keyWordSize = [keyWordLabel.text boundingRectWithSize:CGSizeMake(maxWidth, 999) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: font} context:nil].size;
            
            CGFloat standardRowHeight = [@"" boundingRectWithSize:CGSizeMake(maxWidth, 999) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: font} context:nil].size.height;
            
            CGFloat keyLabWidth = keyWordSize.width + insidePadding;
            
            /**
             *  默认行高设置
             */
            CGFloat keyLabHeight = lineHeight ? lineHeight : keyWordSize.height;
            
            //纠偏设置
            //在行宽超过最大宽度时，设置行宽为最大行宽，行高为一行文本的行高
            if (keyLabWidth >= maxWidth) {
                keyLabWidth = maxWidth;
                keyLabHeight = lineHeight ? lineHeight : standardRowHeight;
            }
            
            keyWordLabel.frame = CGRectMake(beginX, beginY, keyLabWidth, keyLabHeight);
            
            
            beginX = CGRectGetMaxX(keyWordLabel.frame) + outsideMargin;
            if (beginX >= maxWidth) {
                
                beginX = 0;
                beginY = CGRectGetMaxY(keyWordLabel.frame) + lineSpacing;
                keyWordLabel.frame = CGRectMake(beginX, beginY, keyLabWidth, keyLabHeight);
                beginX = CGRectGetMaxX(keyWordLabel.frame) + outsideMargin;
            }
            keyWordLabel.layer.cornerRadius = radious;
            keyWordLabel.layer.masksToBounds = YES;
            
        }
        
        
    }else{
        for (int i = 0; i < self.keyWordsLables.count; i ++) {
            UILabel *keyWordLabel = self.keyWordsLables[i];
            
            CGFloat labWidth = maxWidth / column;
            CGFloat labHeight = lineHeight;
            CGFloat labX = (i % column) * labWidth;
            CGFloat labY = (i / column) * labHeight;
            
            keyWordLabel.frame = CGRectMake(labX, labY, labWidth, labHeight);
            keyWordLabel.layer.cornerRadius = radious;
            keyWordLabel.layer.masksToBounds = YES;
        }
        
    }
    
    
    
}

+ (CGFloat)getHeight:(NSArray<NSString *> *)arr attributes:(NSDictionary *)attributes{
    
    int column = [attributes[KWAttributesColumn] intValue];
    CGFloat maxWidth = [attributes[KWAttributesMaxWidth] floatValue] ? [attributes[KWAttributesMaxWidth] floatValue] : SCREEN_WIDTH;
    CGFloat lineHeight = [attributes[KWAttributesLineHeight] floatValue];
    CGFloat insidePadding = [attributes[KWAttributesInsidePadding] floatValue];
    CGFloat lineSpacing = [attributes[KWAttributesLineSpacing] floatValue];
    CGFloat outsideMargin = [attributes[KWAttributesOutsideMargin] floatValue];
    UIFont *font = attributes[KWAttributesFont] ? attributes[KWAttributesFont] : DEFAULT_FONT;
    
    if (column > 1) {
        int add = arr.count % column == 0 ? 0 : 1;
        return ((arr.count / column) + add) * lineHeight;
    }else{
        CGFloat beginX = 0;
        CGFloat beginY = 0;
        CGRect frame = CGRectZero;
        for (int i = 0; i < arr.count; i ++) {
            
            NSString *keyWordLabelText = arr[i];
            
            CGSize keyWordSize = [keyWordLabelText boundingRectWithSize:CGSizeMake(maxWidth, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size;
            
            CGFloat standardRowHeight = [@"" boundingRectWithSize:CGSizeMake(maxWidth, 999) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: font} context:nil].size.height;
            
            CGFloat keyLabWidth = keyWordSize.width + insidePadding;
            
            /**
             *  默认行高设置
             */
            CGFloat keyLabHeight = lineHeight ? lineHeight : keyWordSize.height;
            //纠偏设置
            //在行宽超过最大宽度时，设置行宽为最大行宽，行高为一行文本的行高
            if (keyLabWidth >= maxWidth) {
                keyLabWidth = maxWidth;
                keyLabHeight = lineHeight ? lineHeight : standardRowHeight;
            }
            //            if (keyWordSize.height >= SUB_HEIGHT) {
            //                keyLabHeight = keyWordSize.height;
            //            }else{
            //                keyLabHeight = SUB_HEIGHT;
            //            }
            frame = CGRectMake(beginX, beginY, keyLabWidth, keyLabHeight);
            
            beginX = CGRectGetMaxX(frame) + outsideMargin;
            if (beginX >= maxWidth) {
                beginX = 0;
                beginY = CGRectGetMaxY(frame) + lineSpacing;
                frame = CGRectMake(beginX, beginY, keyLabWidth, keyLabHeight);
                beginX = CGRectGetMaxX(frame) + outsideMargin;
            }
            
        }
        return CGRectGetMaxY(frame);
    }
}

@end
