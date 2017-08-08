//
//  CJComposeViewController.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/21.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJComposeViewController.h"
#import "CJAccountTool.h"
#import "CJEmotionTextView.h"
#import "CJCompseTool.h"
#import "CJEmotionModel.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "CJComposePhotoView.h"
#import "CJEmotionKeyboardView.h"
@interface CJComposeViewController ()<UITextViewDelegate,CJCompseToolDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(strong,nonatomic) CJEmotionTextView *textView;
@property(strong,nonatomic) CJComposePhotoView *photoView;
@property(strong,nonatomic) CJCompseTool *composeTool;
@property(strong,nonatomic) CJEmotionKeyboardView *keyboardView;
@property(assign,nonatomic)BOOL switchingKeybaord;
@end

@implementation CJComposeViewController
- (CJEmotionKeyboardView *)keyboardView{
    if (_keyboardView ==nil) {
        
        self.keyboardView = [[CJEmotionKeyboardView alloc]init];
        self.keyboardView.height = 216;
        self.keyboardView.width = self.view.width;
    }
    return _keyboardView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpNav];
    
    [self setUpTextView];
    
    [self setUpComposeTool];
    
    [self setUpPhotoLibrary];
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}
- (void)setUpNav{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
   // self.navigationItem.rightBarButtonItem.enabled = NO;

    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.width =150;
    titleLabel.height = 40;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines =0;
    
    NSString *name = [CJAccountTool account].name;
    NSString *prefix = @"发微博";
    
    if (name) {
        NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:[str rangeOfString:prefix]];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:[str rangeOfString:name]];
        
        titleLabel.attributedText = attr;
        self.navigationItem.titleView =titleLabel;
        
    }else{
        
        self.navigationItem.title = prefix;
    }
    
   // self.navigationItem.rightBarButtonItem.enabled = NO;
    
}

- (void)setUpTextView{
    
    CJEmotionTextView *textView = [[CJEmotionTextView alloc]initWithFrame:self.view.bounds];
    textView.font = [UIFont systemFontOfSize:15.0];
    textView.delegate =self;
    textView.alwaysBounceVertical = YES;
    textView.placeholder = @"分享新鲜事...";
    [self.view addSubview:textView];
    self.textView =textView;
    //监听文字发生改变
    [CJNotificationCenter addObserver:self selector:@selector(textViewChange) name:UITextViewTextDidChangeNotification object:textView];
//   监听键盘位置的改变
    [CJNotificationCenter addObserver:self selector:@selector(keyboardFrameDidChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    监听添加表情
    [CJNotificationCenter addObserver:self selector:@selector(emotionDidSelect:) name:CJEmotionDidSelectNotification object:nil];
//    监听删除按钮
    [CJNotificationCenter addObserver:self selector:@selector(emotionDidDelete) name:CJEmotionDidDeleteNotification object:nil];
}
- (void)emotionDidDelete{
    [self.textView deleteBackward];
}
- (void)emotionDidSelect:(NSNotification *)info{
    NSLog(@"%@",info.userInfo[CJSelectEmotionKey]);
    CJEmotionModel *emotion = info.userInfo[CJSelectEmotionKey];
    [self.textView insertEmotion:emotion];
}
- (void)keyboardFrameDidChange:(NSNotification *)notification{
//    NSLog(@"%@",notification);
    /**userInfo = {
     UIKeyboardFrameBeginUserInfoKey = NSRect: {{0, 667}, {375, 258}},
     UIKeyboardCenterEndUserInfoKey = NSPoint: {187.5, 538},
     UIKeyboardBoundsUserInfoKey = NSRect: {{0, 0}, {375, 258}},
     键盘弹出后的frame
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 409}, {375, 258}},
     键盘弹出所花费的时间
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     UIKeyboardCenterBeginUserInfoKey = NSPoint: {187.5, 796},
     键盘弹出的节奏（快慢）
     UIKeyboardAnimationCurveUserInfoKey = 7,
     UIKeyboardIsLocalUserInfoKey = 1
     }}*/
    if (self.switchingKeybaord) {
        return;
    }
    NSDictionary *info = notification.userInfo;
    
    CGRect keyboardFrame = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
   [UIView animateWithDuration:duration animations:^{
       if (keyboardFrame.origin.x>self.view.height) {
           self.composeTool.y = self.view.height - self.composeTool.height;
       }else{
           self.composeTool.y = keyboardFrame.origin.y - self.composeTool.height;
       }
     //  NSLog(@"%@",NSStringFromCGRect(self.composeTool.frame));
   }];

}
- (void)dealloc{
    
    [CJNotificationCenter removeObserver:self];
}

- (void)setUpComposeTool{
    
    CJCompseTool *composeTool =[[CJCompseTool alloc]init];
    composeTool.width = KScreenWidth;
    composeTool.height = 44;
    composeTool.delegate = self;
    composeTool.x =0;
    composeTool.y = self.textView.frame.size.height -composeTool.height;
    [self.view addSubview:composeTool];
    self.composeTool = composeTool;
    

}
- (void)setUpPhotoLibrary{
    
    CJComposePhotoView *photoView = [[CJComposePhotoView alloc]init];
    photoView.x =0;
    photoView.y = 100;
    photoView.width =self.view.width;
    photoView.height = self.view.height;
    [self.textView addSubview:photoView];
    self.photoView =photoView;
}
#pragma mark - CJCompseToolDelegate
- (void)composeTool:(CJCompseTool *)composeTool buttonType:(CJComposeToolbarButtonType)buttonType{
    
    switch (buttonType) {
        case CJComposeToolbarButtonTypeCamera:
            [self openCamera];
            break;
        case CJComposeToolbarButtonTypePicture:
            [self openLibraryPic];
            break;
        case CJComposeToolbarButtonTypeEmotion:
            [self switchKeyboard];
            break;
        case CJComposeToolbarButtonTypeMention:
            
            break;
        case CJComposeToolbarButtonTypeTrend:
            
            break;
            
        default:
            break;
    }
}
- (void)openCamera{
    [self openImagePicker:UIImagePickerControllerSourceTypeCamera];
}
- (void)openLibraryPic{
    [self openImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (void)openImagePicker:(UIImagePickerControllerSourceType)sourceType{
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = sourceType;
    picker.delegate =self;
    [self presentViewController:picker animated:YES completion:nil];
    

}
- (void)switchKeyboard{
    
    if (self.textView.inputView ==nil) {
        
        self.textView.inputView = self.keyboardView;
//       显示自定义键盘
        self.composeTool.showKeyboardBtn = YES;
        
    }else{
        self.textView.inputView = nil;
//        显示系统自带键盘
        self.composeTool.showKeyboardBtn = NO;
    }
    //切换键盘
    self.switchingKeybaord = YES;
    
    [self.textView endEditing:YES];
    
    self.switchingKeybaord =NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.textView becomeFirstResponder];
    });
    
}
#pragma mark - UINavigationControllerDelegate, UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
   // NSLog(@"%@",info);
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photoView addImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - nav方法
- (void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)send{
    // URL: https://api.weibo.com/2/statuses/update.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	pic false binary 微博的配图。*/
    /**	access_token true string*/
    if (self.photoView.photos.count) {//判断是否有图片
        
        [self sendWithImage];
        
    }else{
        [self sendWithoutImage];
    }
    // 4.dismiss
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)sendWithImage{
    //发送带有图片的微博
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"access_token"] = [CJAccountTool account].access_token;
    dictionary[@"status"] = self.textView.fullText;
    [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:dictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        UIImage *image = [self.photoView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"pic.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];

}
- (void)sendWithoutImage{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [CJAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
 
}
#pragma mark - UITextViewDelegate

//- (void)textViewDidChange:(UITextView *)textView{
//    
//    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
//}
- (void)textViewChange{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
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
