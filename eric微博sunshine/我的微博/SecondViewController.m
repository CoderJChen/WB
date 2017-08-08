//
//  SecondViewController.m
//  我的微博
//
//  Created by 陈杰 on 16/1/3.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

//-(void)viewWillAppear:(BOOL)animated{
//    
//    [super viewWillAppear:animated];
//
//    self.navigationItem.rightBarButtonItem.enabled =NO;
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(compse)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    
    
    // Do any additional setup after loading the view.
}
- (void)compse{
    NSLog(@"compose");
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
