//
//  CJEmotionToolModel.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/29.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJEmotionToolModel.h"
#import "CJEmotionModel.h"
#define KRecentEmotion  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archiver"]
@implementation CJEmotionToolModel

+ (void)addRecentEmotion:(CJEmotionModel *)emotion{
//    加载沙盒中的表情
    NSMutableArray *emotions = (NSMutableArray *)[self recentEmotion];
    if (emotions==nil) {
        emotions = [NSMutableArray array];
    }
//    添加表情到沙盒中
    [emotions insertObject:emotion atIndex:0];
    [NSKeyedArchiver archiveRootObject:emotions toFile:KRecentEmotion];
}
+ (NSArray *)recentEmotion{
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:KRecentEmotion];
    
}
@end
