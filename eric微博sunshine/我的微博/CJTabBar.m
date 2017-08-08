//
//  CJTabBar.m
//  我的微博
//
//  Created by 陈杰 on 16/1/6.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJTabBar.h"
#import "UIView+Extension.h"
@interface CJTabBar ()
@property(strong,nonatomic)UIButton *plusBtn;

@end

@implementation CJTabBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        btn.size = btn.currentBackgroundImage.size;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        self.plusBtn = btn;
        
    }
    
    return self;
}
+(instancetype)tabBar{
    
    return [[self alloc]init];
    
}
- (void)btnClick:(UIButton *)btn{
    //实现代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickBtn:)]) {
        
        [self.delegate tabBarDidClickBtn:self];
    }
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.plusBtn.centerX = self.width/2;
    self.plusBtn.centerY = self.height/2;
    
    CGFloat tabBarButtonWidth = self.width/5;
    int tabBarNumber =0;
    
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        
        if ([child isKindOfClass:class]) {
            
            child.width =tabBarButtonWidth;
            
            child.x = tabBarNumber*tabBarButtonWidth;
            tabBarNumber++;
            
            if (tabBarNumber==2) {
                
                tabBarNumber++;
                
            }
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
