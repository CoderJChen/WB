//
//  RootViewController.m
//  我的微博
//
//  Created by 陈杰 on 16/1/3.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "RootViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "MyViewController.h"
#import "CJTabBar.h"
#import "CJComposeViewController.h"
@interface RootViewController ()<CJTabBarDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    FirstViewController *first =[[FirstViewController alloc]init];
    
    [self addChildView:first title:@"首页" image:@"tabbar_home" selectImage:@"tabbar_home_selected"];
//    
    SecondViewController *second =[[SecondViewController alloc]init];
    [self addChildView:second title:@"消息" image:@"tabbar_message_center" selectImage:@"tabbar_message_center_selected"];
    
    ThirdViewController *third = [[ThirdViewController alloc]init];
    [self addChildView:third title:@"发现" image:@"tabbar_discover" selectImage:@"tabbar_discover_selected"];
    
    FourthViewController *four =[[FourthViewController alloc]init];
    
    [self addChildView:four title:@"我"image:@"tabbar_profile" selectImage:@"tabbar_profile_selected"];
    
    CJTabBar *tabBar =[CJTabBar tabBar];
   // tabBar.delegate =self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
//    self.tabBar =tabBar;
    
    
}
#pragma mark -CJTabBarDelegate
- (void)tabBarDidClickBtn:(CJTabBar *)btn{
    
    CJComposeViewController *compose = [[CJComposeViewController alloc]init];
    MyViewController *nav = [[MyViewController alloc]initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   // NSLog(@"%@-----%lu",self.tabBar.subviews,self.tabBar.subviews.count);
}
- (void)addChildView:(UIViewController *)child title:(NSString *)string image:(NSString *)image selectImage:(NSString *)selectImage{
    //同时设置tabbar和navi字体
    child.title = string;
    
    child.tabBarItem.image =[UIImage imageNamed:image];
    child.tabBarItem.selectedImage =[[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *dictionary =[NSMutableDictionary dictionary];
    
    [dictionary setValue:[UIColor colorWithRed:123/255. green:123/255. blue:123/255. alpha:1.0] forKey:NSForegroundColorAttributeName];
    
    [child.tabBarItem setTitleTextAttributes:dictionary forState:UIControlStateNormal];
    
    NSMutableDictionary *selectDictionary = [NSMutableDictionary dictionary];
    
    [selectDictionary setValue:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    
    [child.tabBarItem setTitleTextAttributes:selectDictionary forState:UIControlStateSelected];
    
    MyViewController *navigationController =[[MyViewController alloc]initWithRootViewController:child];
    
    [self addChildViewController:navigationController];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
