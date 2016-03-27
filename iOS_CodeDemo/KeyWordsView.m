//
//  KeyWordsView.m
//  firstNursingWorkers
//
//  Created by mac book on 16/3/16.
//  Copyright © 2016年 HB. All rights reserved.
//


//label高度
#define SUB_HEIGHT 20.f
//label内边距 / 2
#define SUB_PADDING 5.f
//lable 外边距
#define SUB_MARGIN 5.f
//label圆角
#define SUB_LAYER_RADIOUS 5.f
//label字号
#define SUB_FONT [UIFont systemFontOfSize:13]
//控件宽度
#define SELF_WIDTH SCREEN_WIDTH - 30



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
        keyWordLabel.numberOfLines = 0;
        [self addSubview:keyWordLabel];
        [self.keyWordsLables addObject:keyWordLabel];
    }
    
}
- (void)layoutKeyWordsLabelAttributeToLabel:(UILabel *)keyWordLabel{
    keyWordLabel.font = self.attributes[NSFontAttributeName] ? self.attributes[NSFontAttributeName] : SUB_FONT;
    keyWordLabel.textColor = self.attributes[NSForegroundColorAttributeName] ? self.attributes[NSForegroundColorAttributeName] : [UIColor redColor];
//    NSLog(@"%@--%@",keyWordLabel.textColor,self.textColor);
    keyWordLabel.backgroundColor = self.attributes[NSBackgroundColorAttributeName] ? self.attributes[NSBackgroundColorAttributeName] : [UIColor brownColor];
    keyWordLabel.textAlignment = self.textAlignment;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.column == 0) {
        CGFloat beginX = 0;
        CGFloat beginY = 0;
        for (int i = 0; i < self.keyWordsLables.count; i ++) {
            
            UILabel *keyWordLabel = self.keyWordsLables[i];
            
            
            CGSize keyWordSize = [keyWordLabel.text boundingRectWithSize:CGSizeMake(SELF_WIDTH, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: keyWordLabel.font} context:nil].size;
            
            CGFloat keyLabWidth = keyWordSize.width + SUB_PADDING;
            
            if (keyLabWidth >= SELF_WIDTH) {
                keyLabWidth = SELF_WIDTH;
            }
            
            CGFloat keyLabHeight = SUB_HEIGHT;
//            if (keyWordSize.height >= SUB_HEIGHT) {
//                keyLabHeight = keyWordSize.height;
//            }else{
//                keyLabHeight = SUB_HEIGHT;
//            }
            keyWordLabel.frame = CGRectMake(beginX, beginY, keyLabWidth, keyLabHeight);
            
            
            beginX = CGRectGetMaxX(keyWordLabel.frame) + SUB_MARGIN;
            if (beginX>= SELF_WIDTH) {
                
                beginX = 0;
                beginY = CGRectGetMaxY(keyWordLabel.frame) + SUB_MARGIN;
                keyWordLabel.frame = CGRectMake(beginX, beginY, keyLabWidth, keyLabHeight);
                beginX = CGRectGetMaxX(keyWordLabel.frame) + SUB_MARGIN;
            }
            keyWordLabel.layer.cornerRadius = self.radious;
            keyWordLabel.layer.masksToBounds = YES;
            
        }
        
        
    }else{
        for (int i = 0; i < self.keyWordsLables.count; i ++) {
            UILabel *keyWordLabel = self.keyWordsLables[i];
            
            CGFloat labWidth = SELF_WIDTH / self.column;
            CGFloat labHeight = SUB_HEIGHT;
            CGFloat labX = (i % self.column) * labWidth;
            CGFloat labY = (i / self.column) * labHeight;
            
            keyWordLabel.frame = CGRectMake(labX, labY, labWidth, labHeight);
            keyWordLabel.layer.cornerRadius = self.radious;
            keyWordLabel.layer.masksToBounds = YES;
        }
        
    }
    
    
    
}

+ (CGFloat)getHeight:(NSArray*)arr column:(int)column{
    
    if (column != 0) {
        int add = arr.count % column == 0 ? 0 : 1;
        return ((arr.count / column) + add) * SUB_HEIGHT;
    }else{
        CGFloat beginX = 0;
        CGFloat beginY = 0;
        CGRect frame = CGRectZero;
        for (int i = 0; i < arr.count; i ++) {
            
            NSString *keyWordLabelText = arr[i];
            
            CGSize keyWordSize = [keyWordLabelText boundingRectWithSize:CGSizeMake(SELF_WIDTH, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: SUB_FONT} context:nil].size;
            
            CGFloat keyLabWidth = keyWordSize.width + SUB_PADDING;
            CGFloat keyLabHeight = SUB_HEIGHT;
//            if (keyWordSize.height >= SUB_HEIGHT) {
//                keyLabHeight = keyWordSize.height;
//            }else{
//                keyLabHeight = SUB_HEIGHT;
//            }
            frame = CGRectMake(beginX, beginY, keyLabWidth, keyLabHeight);
            
            beginX = CGRectGetMaxX(frame) + SUB_MARGIN;
            if (beginX >= SELF_WIDTH) {
                beginX = 0;
                beginY = CGRectGetMaxY(frame) + SUB_MARGIN;
                frame = CGRectMake(beginX, beginY, keyLabWidth, keyLabHeight);
                beginX = CGRectGetMaxX(frame) + SUB_MARGIN;
            }
            
        }
        return CGRectGetMaxY(frame);
    }
    
}
+ (CGFloat)getHeight:(NSArray<NSString *> *)arr column:(int)column font:(UIFont*)font padding:(CGFloat)padding margin:(CGFloat)margin maxSubHeight:(CGFloat)maxHeight maxWidth:(CGFloat)maxWidth{
    
    
    if (column != 0) {
        int add = arr.count % column == 0 ? 0 : 1;
        return ((arr.count / column) + add) * maxHeight;
    }else{
        CGFloat beginX = 0;
        CGFloat beginY = 0;
        CGRect frame = CGRectZero;
        for (int i = 0; i < arr.count; i ++) {
            
            NSString *keyWordLabelText = arr[i];
            
            CGSize keyWordSize = [keyWordLabelText boundingRectWithSize:CGSizeMake(maxWidth, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size;
            
            CGFloat keyLabWidth = keyWordSize.width + padding;
            CGFloat keyLabHeight = maxHeight;
            //            if (keyWordSize.height >= SUB_HEIGHT) {
            //                keyLabHeight = keyWordSize.height;
            //            }else{
            //                keyLabHeight = SUB_HEIGHT;
            //            }
            frame = CGRectMake(beginX, beginY, keyLabWidth, keyLabHeight);
            
            beginX = CGRectGetMaxX(frame) + margin;
            if (beginX >= maxWidth) {
                beginX = 0;
                beginY = CGRectGetMaxY(frame) + margin;
                frame = CGRectMake(beginX, beginY, keyLabWidth, keyLabHeight);
                beginX = CGRectGetMaxX(frame) + margin;
            }
            
        }
        return CGRectGetMaxY(frame);
    }
    
}

@end
