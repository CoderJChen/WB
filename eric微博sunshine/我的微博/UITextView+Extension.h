//
//  UITextView+Extension.h
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/29.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)

- (void)insertAttribute:(NSAttributedString *)attribute;
- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributeText))settingBlock;

@end
