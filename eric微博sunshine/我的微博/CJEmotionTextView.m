//
//  CJEmotionTextView.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/29.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJEmotionTextView.h"
#import "CJEmotionModel.h"
#import "CJEmotionTextAttachment.h"
@implementation CJEmotionTextView

- (void)insertEmotion:(CJEmotionModel *)emotion{
    
    if (emotion.code) {
        [self insertText:emotion.code.emoji];
    }else if (emotion.png){
        //加载图片
        CJEmotionTextAttachment *attach = [[CJEmotionTextAttachment alloc]init];
        attach.emotion =emotion;
        
        CGFloat attachWH = self.font.lineHeight;
        attach.bounds = CGRectMake(0, -4, attachWH, attachWH);
//        根据一个附件创建一个文字属性
        NSAttributedString *imageAttr = [NSAttributedString attributedStringWithAttachment:attach];
       //拼接之前的内容
//        NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc]init];
//        [attributeText appendAttributedString:self.attributedText];
//        
//        NSUInteger loc = self.selectedRange.location;
//        
//        [attributeText insertAttributedString:imageAttr atIndex:loc];
//        
      //  self.attributedText = attributeText;
        
//        self.selectedRange = NSMakeRange(loc+1, 0);
      //  [self insertAttribute:imageAttr];
        [self insertAttributedText:imageAttr settingBlock:^(NSMutableAttributedString *attributeText) {
            [attributeText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributeText.length)];
        }];
        // 设置字体
//        NSMutableAttributedString *text = (NSMutableAttributedString *)self.attributedText;
////
//        
//        [text addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
//        
//        self.attributedText = text;
//        
    }
}
- (NSString *)fullText{
    
    NSMutableString *fullText = [NSMutableString string];
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        CJEmotionTextAttachment *attach =attrs[@"NSAttachment"];
        if (attach) {
            [fullText appendString:attach.emotion.chs];
        }else{
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
            
        }
    }];
    return fullText;
}
/**
 selectedRange :
 1.本来是用来控制textView的文字选中范围
 2.如果selectedRange.length为0，selectedRange.location就是textView的光标位置
 
 关于textView文字的字体
 1.如果是普通文字（text），文字大小由textView.font控制
 2.如果是属性文字（attributedText），文字大小不受textView.font控制，应该利用NSMutableAttributedString的- (void)addAttribute:(NSString *)name value:(id)value range:(NSRange)range;方法设置字体
 **/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
