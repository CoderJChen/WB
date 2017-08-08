//
//  CJCompseTool.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/21.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJCompseTool.h"

@interface CJCompseTool ()
@property(strong,nonatomic)UIButton *emotionBtn;

@end

@implementation CJCompseTool
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //compose_toolbar_picture  compose_toolbar_picture_highlighted
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        [self setBtnImage:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" tag:CJComposeToolbarButtonTypeCamera];
        
        [self setBtnImage:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" tag:CJComposeToolbarButtonTypePicture];
        
        [self setBtnImage:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" tag:CJComposeToolbarButtonTypeMention];
        
        [self setBtnImage:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" tag:CJComposeToolbarButtonTypeTrend];
        
        self.emotionBtn =[self setBtnImage:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" tag:CJComposeToolbarButtonTypeEmotion];
        
    }
    return self;
}
- (void)setShowKeyboardBtn:(BOOL)showKeyboardBtn{
    _showKeyboardBtn =showKeyboardBtn;
    NSString *highImage = @"compose_emoticonbutton_background_highlighted";
    NSString *image = @"compose_emoticonbutton_background";
    
    if (showKeyboardBtn) {
        image = @"compose_keyboardbutton_background";
        highImage = @"compose_keyboardbutton_background_highlighted";
    }
    [self.emotionBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emotionBtn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    
}
- (UIButton *)setBtnImage:(NSString *)image highImage:(NSString *)highImage tag:(CJComposeToolbarButtonType)type{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    [self addSubview:btn];
    return btn;
}
- (void)btnClick:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(composeTool:buttonType:)]) {
        [self.delegate composeTool:self buttonType:(CJComposeToolbarButtonType)btn.tag];
    }
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width/self.subviews.count;
    CGFloat h = self.frame.size.height;
    for (int i = 0; i<self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat x = i * w;
        CGFloat y = 0;
        btn.frame = CGRectMake(x, y, w, h);
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
