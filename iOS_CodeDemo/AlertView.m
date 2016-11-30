//
//  AlertView.m
//  iOS_CodeDemo
//
//  Created by mac book on 16/9/26.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}

@end
