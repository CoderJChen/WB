//
//  UIBarButtonItem+Extension.m
//  我的微博
//
//  Created by 陈杰 on 16/1/4.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)addItemWithTarget:(id)target action:(SEL)action image:(NSString *)image selectImage:(NSString *)selectImage {
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.size =btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
