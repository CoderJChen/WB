//
//  AuthorizeViewController.m
//  我的微博
//
//  Created by 陈杰 on 16/1/10.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "AuthorizeViewController.h"
#import "AFNetworking.h"
#import "Acount.h"
#import "RootViewController.h"
#import "StartViewController.h"
#import "CJAccountTool.h"
#import "UIWindow+Extension.h"
#import "MBProgressHUD+MJ.h"
@interface AuthorizeViewController ()<UIWebViewDelegate>

@end

@implementation AuthorizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*App Key：1568399787
     App Secret：a836e144a43c013ef1456ef121e01111*/
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *url =[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1568399787&redirect_uri=http://"];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
    // Do any additional setup after loading the view.
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //code=1d7885f36e7b94eca55f26524ea3e11f
    NSString * url = request.URL.resourceSpecifier;
    
    NSRange range =[url rangeOfString:@"code="];
    
    if (range.length!=0) {
        
        unsigned long numberOfLength = range.location + range.length;
        NSString *code =[url substringFromIndex:numberOfLength];
        [self accessTokenWithCode:code];
        
       // return NO;
    }
    return YES;
}
- (void)accessTokenWithCode:(NSString *)code{
    /*
     URL：https://api.weibo.com/oauth2/access_token
     
     请求参数：
     client_id：申请应用时分配的AppKey
     client_secret：申请应用时分配的AppSecret
     grant_type：使用authorization_code
     redirect_uri：授权成功后的回调地址
     code：授权成功后返回的code
     */
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    dictionary[@"client_id"] = @"1568399787";
    dictionary[@"client_secret"] = @"a836e144a43c013ef1456ef121e01111";
    dictionary[@"grant_type"] = @"authorization_code";
    dictionary[@"redirect_uri"] = @"http://";
    dictionary[@"code"] =code;
    
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:dictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUD];
       //取得沙盒路径
        Acount *account =[Acount accountWithDictionary:responseObject];
        //保存数据
        [CJAccountTool saveAccount:account];
        
        UIWindow *window =[UIApplication sharedApplication].keyWindow;
        
        [window switchWithControllerView];
        
        NSLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
           NSLog(@"%@",error.localizedDescription);
        
    }];
   
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [MBProgressHUD showMessage:@"正在加载数据..."];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [MBProgressHUD hideHUD];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [MBProgressHUD showError:error.localizedDescription];
   // NSLog(@"-----%@",error.localizedDescription);

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
