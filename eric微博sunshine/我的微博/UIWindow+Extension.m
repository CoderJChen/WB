//
//  UIWindow+Extension.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/14.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "RootViewController.h"
#import "StartViewController.h"

@implementation UIWindow (Extension)

- (void)switchWithControllerView{
    
    NSString *key = @"CFBundleVersion";//版本号
    
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:key];
    NSString *lastCurrent = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    
    if ([currentVersion isEqualToString:lastCurrent]) {
        
        self.rootViewController = [[RootViewController alloc]init];
        
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];//同步信息
        self.rootViewController = [[StartViewController alloc]init];
        
    }

}
@end
