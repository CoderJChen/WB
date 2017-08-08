//
//  NSDate+Extension.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/19.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**判断是否是今年*/
- (BOOL)isThisYear{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *current_date = [NSDate date];
    
    NSDateComponents *create_dateComps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *current_dateComp = [calendar components:NSCalendarUnitYear fromDate:current_date];
    
    return create_dateComps.year == current_dateComp.year;
}

- (BOOL)isYestoday{
    NSDateFormatter *fmt =[[NSDateFormatter alloc]init];
    fmt.dateFormat =@"yyyy-MM-dd";
    NSDate *now = [NSDate date];
    
    NSString *current_date_s =[fmt stringFromDate:now];
    NSString *create_date_s = [fmt stringFromDate:self];
    
    NSDate * current_date = [fmt dateFromString:current_date_s];
    NSDate *create_date = [fmt dateFromString:create_date_s];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    
    NSDateComponents *dateComps = [calendar components:calendarUnit fromDate:create_date toDate:current_date options:0];
    
    return (dateComps.year = 0) && (dateComps.month = 0) &&(dateComps.day = 1);
}

- (BOOL)isToday{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *now = [NSDate date];
    
    NSString *current_date = [fmt stringFromDate:now];
    NSString *create_date = [fmt stringFromDate:self];
    
    return [current_date isEqualToString:create_date];
}

@end
