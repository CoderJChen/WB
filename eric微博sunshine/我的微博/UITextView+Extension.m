//
//  UITextView+Extension.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/29.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)
- (void)insertAttribute:(NSAttributedString *)attribute{
    [self insertAttributedText:attribute settingBlock:nil];
    
}
- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *))settingBlock{
    
    NSMutableAttributedString *attributeText  =[[NSMutableAttributedString alloc]init];
    [attributeText appendAttributedString:self.attributedText];
    NSUInteger loc = self.selectedRange.location;
    [attributeText insertAttributedString:text atIndex:loc];
   // [attributeText replaceCharactersInRange:NSMakeRange(loc, 0) withAttributedString:attributeText];
    if (settingBlock) {
        settingBlock(attributeText);
    }
    self.attributedText = attributeText;
    self.selectedRange = NSMakeRange(loc +1, 0);
}
@end
