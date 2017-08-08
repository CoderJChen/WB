//
//  StatusModel.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/14.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "StatusModel.h"
#import "UserModel.h"
#import "MJExtension.h"
#import "CJPhotoModel.h"
@implementation StatusModel

-(NSDictionary *)objectClassInArray{
    
    return @{@"pic_urls":[CJPhotoModel class]};
    
}

- (NSString *)created_at{
   // NSLog(@"----create_at");
    // _created_at == Thu Oct 16 17:06:25 +0800 2014
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //创建微博时间_
    NSDate *create_date = [fmt dateFromString:_created_at];
    //当前时间
    NSDate *current_date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    
    NSDateComponents *dateComponents = [calendar components:calendarUnit fromDate:create_date toDate:current_date options:0];
    
    if ([create_date isThisYear]) {
        if ([create_date isYestoday]) {
            fmt.dateFormat = @"昨天 HH-mm-ss";
            return [fmt stringFromDate:create_date];
        }else if ([create_date isToday]){
            
            if (dateComponents.hour>=1) {
                return [NSString stringWithFormat:@"%ld小时前",(long)dateComponents.hour];
            }else if (dateComponents.minute>=1){
                return [NSString stringWithFormat:@"%ld分钟前",(long)dateComponents.minute];
            }else{
                return [NSString stringWithFormat:@"刚刚"];
            }
        }else{
        fmt.dateFormat = @"MM-dd HH-mm-ss";
            return [fmt stringFromDate:create_date];
        }
    }else{
        fmt.dateFormat =@"yyyy-MM-dd HH-mm-ss";
        return [fmt stringFromDate:create_date];
    }
    
}
- (void)setSource:(NSString *)source{
    _source =source;
  //  NSLog(@"%@",source);
    // source == <a href="http://app.weibo.com/t/feed/2llosp" rel="nofollow">OPPO_N1mini</a>
    if (source.length !=0) {    
        NSRange range ;
        range.location = [source rangeOfString:@">"].location+1;
        range.length = [source rangeOfString:@"</"].location -range.location;
        //NSLog(@"%@",[source substringWithRange:range]);
        _source = [NSString stringWithFormat:@"来自 %@",[source substringWithRange:range]];
    }
    
}
@end
