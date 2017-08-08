//
//  MyViewController.m
//  我的微博
//
//  Created by 陈杰 on 16/1/3.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "MyViewController.h"
#import "UIView+Extension.h"
@interface MyViewController ()

@end

@implementation MyViewController

+(void)initialize{
    
    UIBarButtonItem *item =[UIBarButtonItem appearance];
    
    NSMutableDictionary *dictionary =[NSMutableDictionary dictionary];
    [ dictionary setValue:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [dictionary setValue:[UIFont systemFontOfSize:15.0] forKey:NSFontAttributeName];
    [item setTitleTextAttributes:dictionary forState:UIControlStateNormal];
    
   /**设置不可用状态*/
    NSMutableDictionary *disabledDict =[NSMutableDictionary dictionary];
    [ disabledDict setValue:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7] forKey:NSForegroundColorAttributeName];
    
    [disabledDict setValue:[UIFont systemFontOfSize:15.0] forKey:NSFontAttributeName];
    
    [item setTitleTextAttributes:disabledDict forState:UIControlStateDisabled];
    

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
   // NSLog(@"%lu--%@",self.viewControllers.count,viewController);
    
    if (self.viewControllers.count > 0) {// 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        /* 设置导航栏上面的内容 */

        UIButton *leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
        leftBtn.size = leftBtn.currentImage.size;
        [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
        
        UIButton *moreBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [moreBtn setImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
        [moreBtn setImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
        moreBtn.size = moreBtn.currentImage.size;
        [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    }
    
    [super pushViewController:viewController animated:animated];
    
}
- (void)back{
    
    [self popViewControllerAnimated:YES];
    
}
- (void)more{
    
    [self popToRootViewControllerAnimated:YES];
    
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
