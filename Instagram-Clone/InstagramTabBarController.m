//
//  InstagramTabBarController.m
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/28/22.
//

#import "InstagramTabBarController.h"
#import "HomeViewController.h"
#import "ProfileViewController.h"

@interface InstagramTabBarController ()

@end

@implementation InstagramTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] init];
    [homeNav setViewControllers:@[homeVC]];
    
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    UINavigationController *profileNav = [[UINavigationController alloc] init];
    [profileNav setViewControllers:@[profileVC]];
    
    UIImage *homeImage = [UIImage imageNamed:@"feed_tab"];
    UITabBarItem *homeBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:homeImage tag:0];
    [homeNav setTabBarItem:homeBarItem];
    
    UIImage *profileImage = [UIImage imageNamed:@"profile_tab"];
    UITabBarItem *profileBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:profileImage tag:0];
    [profileNav setTabBarItem:profileBarItem];

    self.viewControllers = [NSArray arrayWithObjects:homeNav,profileNav, nil];
    
    self.tabBar.barTintColor = [UIColor blackColor];
    [self.tabBar setTranslucent:false];
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
