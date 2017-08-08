//
//  CJMenuDownView.m
//  我的微博
//
//  Created by 陈杰 on 16/1/5.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJMenuDownView.h"

@interface CJMenuDownView ()

@property(nonatomic,strong)UIImageView * containerView;

@end

@implementation CJMenuDownView
-(UIImageView *)containerView{
    if (_containerView ==nil) {
        
        UIImageView *containerIcon = [[UIImageView alloc]init];
        containerIcon.image =[UIImage imageNamed:@"popover_background"];
        
        containerIcon.userInteractionEnabled =YES;
        
        [self addSubview:containerIcon];
        
        self.containerView = containerIcon;
    }
    return _containerView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)setContent:(UIView *)content{
    
    _content =content;
    
    content.x = 10;
    content.y = 15;
    
    self.containerView.height =CGRectGetMaxY(content.frame)+10;
    
    self.containerView.width = CGRectGetMaxX(content.frame)+10;
    [self.containerView addSubview:content];

}
-(void)setContentView:(UIViewController *)contentView{
    
    _contentView = contentView;
    
    self.content = contentView.view;
    
}
+(instancetype)menu{
    
    return [[self alloc]init];
    
}
-(void)showFrom:(UIView *)from{
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self];
    
    self.frame = window.bounds;
    
    CGRect newFrame = [from convertRect:from.bounds toView:window];
//    NSLog(@"=====%@=====",NSStringFromCGRect(newFrame));
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    if ([self.delegate respondsToSelector:@selector(menuDidClickDown:)]) {
        [self.delegate menuDidClickDown:self];
    }

}
-(void)dismiss{
    
    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(menuDidClickUp:)]) {
        [self.delegate menuDidClickUp:self];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}
@end
