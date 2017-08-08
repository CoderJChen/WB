//
//  CJFooterView.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/15.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJFooterView.h"

@implementation CJFooterView
+(instancetype)footerView{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"CJFooterView" owner:nil options:nil]lastObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
