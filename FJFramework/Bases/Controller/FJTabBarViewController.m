//
//  FJTabBarViewController.m
//  FJFramework
//
//  Created by 樊静 on 2017/6/30.
//  Copyright © 2017年 樊静. All rights reserved.
//

#import "FJTabBarViewController.h"
#import "FJBaseNavigationController.h"

@interface FJTabBarViewController ()

@end

@implementation FJTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTabBarVC];
    self.tabBar.translucent = NO;

}
// 初始化所有子控制器
- (void)setTabBarVC{
//    MainViewController * mainVc = [[MainViewController alloc] init];
//    [self setTabBarChildController:mainVc title:@"大厅" image:@"大厅" selectImage:@"大厅-2"];
//    
//    PredictViewController * foucusVC = [[PredictViewController alloc] init];
//    
//    [self setTabBarChildController:foucusVC title:@"论坛" image:@"论坛-2" selectImage:@"论坛"];
//    
//    FindViewController * searVc = [[FindViewController alloc] init];
//    [self setTabBarChildController:searVc title:@"发现" image:@"发现" selectImage:@"发现-2"];
//    
//    ShakeViewController *infoVc = [[ShakeViewController alloc] init];
//    [self setTabBarChildController:infoVc title:@"摇一摇" image:@"摇一摇-2" selectImage:@"摇一摇"];
//    
//    YDMineController * myVc = [[YDMineController alloc] init];
//    [self setTabBarChildController:myVc title:@"我的" image:@"我的" selectImage:@"我的-2"];
    
}


// 添加tabbar的子viewcontroller
- (FJBaseNavigationController *)setTabBarChildController:(UIViewController*)controller title:(NSString*)title image:(NSString*)imageStr selectImage:(NSString*)selectImageStr{
    
    FJBaseNavigationController *baseNav = [[FJBaseNavigationController alloc] initWithRootViewController:controller];
    baseNav.tabBarItem.title = title;
    
    baseNav.tabBarItem.image = [[UIImage imageNamed:imageStr]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    baseNav.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageStr]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [baseNav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [baseNav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    [self addChildViewController:baseNav];
    return baseNav;
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
