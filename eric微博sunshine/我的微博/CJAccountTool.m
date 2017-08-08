//
//  CJAccountTool.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/13.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJAccountTool.h"
#define KAccount  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"acount.archiver"]

@implementation CJAccountTool
+ (void)saveAccount:(Acount *)account{
    //NSLog(@"%@",KAccount);
    ///Users/Eric/Library/Developer/CoreSimulator/Devices/6B9A6A74-F2AB-4FC1-BC06-44BBF647A825/data/Containers/Data/Application/B056F8E3-8C65-41CA-9FEF-3C6A12DBE70C/Documents/acount.archiver
    [NSKeyedArchiver archiveRootObject:account toFile:KAccount];
    
}

+ (Acount *)account{
    
    Acount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:KAccount];
    
    long long expires_in = [account.expires_in longLongValue];
    NSDate *expires_time = [account.create_time dateByAddingTimeInterval:expires_in];
    //现在的时间
    NSDate *now =[NSDate date];
    
    NSComparisonResult result = [expires_time compare:now];
   /*
    NSOrderedAscending = -1L,    升序  右边  》 左边
    NSOrderedSame,               相等  右边  =  左边
    NSOrderedDescending          降序  右边 《  左边
    boss                         直聘
    */
    if (result != NSOrderedDescending) {
        
        return nil;
        
    }
    return account;
}
@end
