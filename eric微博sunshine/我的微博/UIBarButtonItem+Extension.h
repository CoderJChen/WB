//
//  UIBarButtonItem+Extension.h
//  我的微博
//
//  Created by 陈杰 on 16/1/4.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)addItemWithTarget:(id)target action:(SEL)action image:(NSString *)image selectImage:(NSString *)selectImage;

@end
