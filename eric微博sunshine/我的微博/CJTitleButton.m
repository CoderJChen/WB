//
//  CJTitleButton.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/14.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJTitleButton.h"
#import "UIView+Extension.h"
#define CJMargin 5
@implementation CJTitleButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self =[super initWithFrame:frame]) {
        //self.backgroundColor = [UIColor redColor];
        
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   
    }
    return self;
}
// 目的：想在系统计算和设置完按钮的尺寸后，再修改一下尺寸
/**
 *  重写setFrame:方法的目的：拦截设置按钮尺寸的过程
 *  如果想在系统设置完控件的尺寸后，再做修改，而且要保证修改成功，一般都是在setFrame:中设置
 */
- (void)setFrame:(CGRect)frame{
   
    frame.size.width += CJMargin;
    [super setFrame:frame];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];

    self.titleLabel.x =self.imageView.x;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame)+CJMargin;

  // NSLog(@"%@----%@",NSStringFromCGRect(self.titleLabel.frame),NSStringFromCGRect(self.imageView.frame));
    
    
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    
    [super setTitle:title forState:state];
    //自适应
    [self sizeToFit];
}
- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    
    [super setImage:image forState:state];
    
    [self sizeToFit];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
