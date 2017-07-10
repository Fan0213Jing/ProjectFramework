//
//  FJBaseViewController.m
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "FJBaseViewController.h"

@interface FJBaseViewController () {
UIView * _shawdowImage;
}
@property (nonatomic,assign) BOOL isNeedTransparent;

@end

@implementation FJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isNeedTransparent = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"ebebeb"];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"FF6347"]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (self.isNeedTransparent) {
        if (_shawdowImage) {
            _shawdowImage.hidden = NO;
        }
        
    }
}
#pragma mark private methods

- (void)setUpNavigationBarWithTransparent:(BOOL)transparent{
    
    self.isNeedTransparent = transparent;
    
    if (!transparent) {
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
        
        
    } else {
        [self needTransparent];
    }
    
    
}

- (void)needTransparent{
    //设置透明导航
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    
    
    for (UIView * v in self.navigationController.navigationBar.subviews) {
        
        //iOS10 改为_UIBarBackground
        if ([v isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            
            for (UIView * vv  in v.subviews) {
                
                if ([vv isKindOfClass:[UIImageView class]]) {
                    if (vv.height == 0.5) {
                        UIImageView * vvv = (UIImageView *)vv;
                        _shawdowImage = vvv;
                        vvv.hidden = YES;
                    }
                }
            }
        }
    }
}

- (void)setUpLeftBackButton{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftbackButtonTap:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

- (void)leftbackButtonTap:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
