

#import "CustomNavigationBar.h"

@implementation CustomNavigationBar


- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleTextAttributes = @{NSForegroundColorAttributeName:COLOR_RANDOM,NSFontAttributeName:[UIFont systemFontOfSize:16]};
    for (UIButton *button in self.subviews){
        if (![button isKindOfClass:[UIButton class]]) {
            continue;
        }
        if (button.centerX < self.width*0.5) {// 左边的按钮
            button.x=8;
            
        }else if(button.centerX > self.width*0.5){// 右边的按钮
//            button.x = self.width - button.width;
        }
    }
}

@end
