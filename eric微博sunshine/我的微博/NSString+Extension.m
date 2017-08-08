//
//  NSString+Extension.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/19.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName]= font;
    CGSize maxSize = CGSizeMake(maxW, CGFLOAT_MAX);
    CGRect rect =  [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size;
    
}
- (CGSize)sizeWithFont:(UIFont *)font {
    
    return [self sizeWithFont:font maxW:CGFLOAT_MAX];
    
}
@end
