//
//  FJWebViewController.m
//  LotteryTicketNews
//
//  Created by 樊静 on 2017/6/7.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "FJWebViewController.h"
#import <WebKit/WebKit.h>

@interface FJWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong) WKWebView * webView;
@property (nonatomic,assign) BOOL needNavigationBar;
@property (nonatomic,strong) WKUserContentController  * userContentController;

@property (nonatomic,copy) NSString    * urlString;
@property(nonatomic,copy)NSString *guanggao;

@property(nonatomic, strong)UIButton *backBtn;

@end




@implementation FJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureWebView];
}


-(instancetype)initWithURL:(NSString *)url  str:(NSString *)guanggao title:(NSString *)title Nav:(BOOL)ishave{
    self = [super init];
    if (self) {
        self.needNavigationBar = ishave;
        self.urlString = url;
        self.guanggao = guanggao;
        self.title = title;
    }
    return self;
}
- (void)configureWebView {
    
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
    self.userContentController =[[WKUserContentController alloc]init];
    configuration.userContentController = self.userContentController;
    
    
    if (self.needNavigationBar) {
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) configuration:configuration];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:(UIBarButtonItemStyleDone) target:self action:@selector(backAction)];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];


    } else {
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) configuration:configuration];
        self.navigationController.navigationBarHidden = YES;
        
        
        UIButton *back = [UIButton buttonWithType:(UIButtonTypeCustom)];
        back.frame = CGRectMake(5, 25, 30, 30);
        [back setBackgroundImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
        [back addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.backBtn = back;
        
        
    }
    
 
    
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    
    [self.view addSubview:self.webView];
    
    
    if (self.needNavigationBar) {
        
    } else {
        
        [self.webView addSubview:self.backBtn];

    }
    
    
    
    
    
  }
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
-(void)backAction {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSString *jsToGetHTMLSource = [NSString stringWithFormat: @"document.getElementsByClassName('%@')[0].style.display = 'none'", self.guanggao];
    
  
    [webView evaluateJavaScript:jsToGetHTMLSource  completionHandler:^(id _Nullable HTMLsource, NSError * _Nullable error) {
        
    }];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"======%@",navigationResponse.response.URL.absoluteString);
    
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"------%@",navigationAction.request.URL.absoluteString);
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}
#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return [[WKWebView alloc]init];
}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    completionHandler(@"http");
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    completionHandler(YES);
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%@",message);
    completionHandler();
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
