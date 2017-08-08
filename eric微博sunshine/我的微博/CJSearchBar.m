//
//  CJSearchBar.m
//  我的微博
//
//  Created by 陈杰 on 16/1/5.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJSearchBar.h"

@implementation CJSearchBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索条件";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];//添加背景图片
        UIImageView * searchIcon =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        searchIcon.image =[UIImage imageNamed:@"searchbar_textfield_search_icon"];
        self.leftView =searchIcon;
        searchIcon.contentMode = UIViewContentModeCenter;//图片样式居中
        self.leftViewMode =UITextFieldViewModeAlways;

    }
    return self;
}
+(CJSearchBar *)searchBar{
    
    return [[self alloc]init]; // 通过init来创建初始化绝大部分控件，控件都是没有尺寸
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
