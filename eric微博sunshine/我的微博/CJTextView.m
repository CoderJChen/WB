//
//  CJTextView.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/21.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJTextView.h"

@implementation CJTextView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.placehoderColor = [UIColor grayColor];
        //监听文本框内容
        [CJNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
- (void)dealloc{
    [CJNotificationCenter removeObserver:self];
}
- (void)textDidChange{
    [self setNeedsDisplay];
}
- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}
- (void)setPlacehoderColor:(UIColor *)placeholderColor{
    _placeholderColor =placeholderColor;
    [self setNeedsDisplay];
}
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];

}
- (void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (self.hasText) {
        return;
    }
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[NSFontAttributeName] = self.font;
    dictionary[NSForegroundColorAttributeName] =self.placeholderColor;
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat w = self.frame.size.width - 2*x;
    CGFloat h = self.frame.size.height - 2*y;
    CGRect placeholderRect = CGRectMake(x,y, w, h);
    
    [self.placeholder drawInRect:placeholderRect withAttributes:dictionary];
    
}


@end
