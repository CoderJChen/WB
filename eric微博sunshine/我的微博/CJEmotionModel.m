//
//  CJEmotionModel.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/26.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJEmotionModel.h"

@implementation CJEmotionModel
//解析
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.png = [coder decodeObjectForKey:@"png"];
        self.chs = [coder decodeObjectForKey:@"chs"];
        self.code = [coder decodeObjectForKey:@"code"];
    }
    return self;
}
//写入
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.png forKey:@"png"];
    [aCoder encodeObject:self.chs forKey:@"chs"];
    [aCoder encodeObject:self.code forKey:@"code"];
}
@end
