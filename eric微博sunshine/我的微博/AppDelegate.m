//
//  AppDelegate.m
//  我的微博
//
//  Created by 陈杰 on 16/1/3.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "StartViewController.h"
#import "AuthorizeViewController.h"
#import "Acount.h"
#import "CJAccountTool.h"
#import "UIWindow+Extension.h"
#import "SDWebImageManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    Acount *account = [CJAccountTool account];
    if (account) {
        //选择控制器
        [self.window switchWithControllerView];
        
    }else{
        
    self.window.rootViewController = [[AuthorizeViewController alloc]init];
        
    }
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        // 当申请的后台运行时间已经结束（过期），就会调用这个block
        
        // 赶紧结束任务
        [application endBackgroundTask:task];
    }];
    
    // 在Info.plst中设置后台模式：Required background modes == App plays audio or streams audio/video using AirPlay
    // 搞一个0kb的MP3文件，没有声音
    // 循环播放
    
    // 以前的后台模式只有3种
    // 保持网络连接
    // 多媒体应用
    // VOIP:网络电话
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    
    SDWebImageManager *manger =[SDWebImageManager sharedManager];
    //取消所有下载
    [manger cancelAll];
    //清除所有图片
    [manger.imageCache clearMemory];
}
@end
