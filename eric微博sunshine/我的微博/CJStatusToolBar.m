//
//  CJStatusToolBar.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/18.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJStatusToolBar.h"

@interface CJStatusToolBar ()

@property(copy,nonatomic)NSMutableArray *btns;

@property(strong,nonatomic) NSMutableArray * indivisibles;

@property (nonatomic, weak) UIButton *repostBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;
@end

@implementation CJStatusToolBar
- (NSMutableArray *)btns{
    if (_btns==nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
- (NSMutableArray *)indivisibles{
    if (_indivisibles == nil) {
        _indivisibles = [NSMutableArray array];
    }
    return _indivisibles;
}
+ (instancetype)StatusToolBar{
    
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame{
 
    if (self =[super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        self.repostBtn =  [self setTitle:@"转发" imageView:@"timeline_icon_retweet"];
        self.commentBtn = [self setTitle:@"评论" imageView:@"timeline_icon_comment"];
        self.attitudeBtn = [self setTitle:@"点赞" imageView:@"timeline_icon_unlike"];
        
        [self setIndivisibleLine];
        
        [self setIndivisibleLine];
    }
    return self;
    
}
- (UIButton *)setTitle:(NSString *)title imageView:(NSString *)image{
    
  UIButton * btn = [[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    
    return btn;
}
- (void)setIndivisibleLine{
    
    UIImageView *line = [[UIImageView alloc]init];
    line.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:line];
    [self.indivisibles addObject:line];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger btnCount = self.btns.count;
    
    for (int i =0; i<btnCount; i++) {
        UIButton *btn = self.btns[i];
        btn.width = self.frame.size.width/btnCount;
        btn.height= self.frame.size.height;
        btn.x = i*btn.width;
        btn.y = 0;
        if (i<btnCount-1) {
            
            UIImageView *lineImage = self.indivisibles[i];
            lineImage.width  = 1;
            lineImage.height = btn.height;
            lineImage.x = (i+1)*btn.width;
            lineImage.y =0;
        }
    }
}

-(void)setStatuses:(StatusModel *)statuses{
    _statuses =statuses;
    
    [self setBtn:self.repostBtn count:statuses.reposts_count title:@"转发"];
    
    [self setBtn:self.commentBtn count:statuses.comments_count title:@"评论"];
    
    [self setBtn:self.attitudeBtn count:statuses.attitudes_count title:@"点赞"];

}
- (void)setBtn:(UIButton *)btn count:(int)count title:(NSString *)title{
    
    if(count){
        
        if (count>10000) {
            
            double wan = count/10000.;
            title = [NSString stringWithFormat:@"%.f万",wan];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
            
        }else{
            
            title = [NSString stringWithFormat:@"%d",count];
            
        }
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
