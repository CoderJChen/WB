//
//  CJEmotionTabBar.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/26.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJEmotionTabBar.h"
#import "CJEmotionButton.h"

@interface CJEmotionTabBar ()
@property(strong,nonatomic)CJEmotionButton *selectBtn;

@end

@implementation CJEmotionTabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setbtn: @"最近" buttonType:CJEmotionTabBarButtonTypeRecent];
        [self setbtn:@"默认" buttonType:CJEmotionTabBarButtonTypeDefault];
        [self setbtn:@"Emoji" buttonType:CJEmotionTabBarButtonTypeEmoji];
        [self setbtn:@"浪小花" buttonType:CJEmotionTabBarButtonTypeLxh];
    }
    return self;
}
- (CJEmotionButton *)setbtn:(NSString *)title buttonType:(CJEmotionTabBarButtonType)type{
    
    CJEmotionButton *btn = [[CJEmotionButton alloc]init];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag =type;
    [self addSubview:btn];
    
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count==1) {
        image =@"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    }else if(self.subviews.count==4){
    image = @"compose_emotion_table_right_normal";
        selectImage =@"compose_emotion_table_right_selected";
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    
    return btn;

}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat btnWidth = self.width/self.subviews.count;
    CGFloat btnHeight = self.height;
    
    for (int i = 0; i<self.subviews.count; i++) {
        CJEmotionButton *btn = self.subviews[i];
        btn.x = i*btnWidth;
        btn.y = 0;
        btn.width = btnWidth;
        btn.height =btnHeight;
    }
    
}
- (void)setDelegate:(id<CJEmotionTabBarDelegate>)delegate{
    
    _delegate =delegate;
    
    [self btnClick:[self viewWithTag:CJEmotionTabBarButtonTypeDefault]];
}
- (void)btnClick:(CJEmotionButton *)btn{
    
    self.selectBtn.enabled = YES;
    btn.enabled = NO;
    self.selectBtn = btn;
    if ([self.delegate respondsToSelector:@selector(emotionBtn:buttonType:)]) {
        
        [self.delegate emotionBtn:self buttonType:(CJEmotionTabBarButtonType)btn.tag];
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
