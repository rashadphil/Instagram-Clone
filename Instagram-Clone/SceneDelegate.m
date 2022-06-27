//
//  SceneDelegate.m
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/26/22.
//

#import "SceneDelegate.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "HomeViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    UIViewController *vc1 = [[LoginViewController alloc] init];
//    [vc1.view setBackgroundColor:[UIColor redColor]];
    UIViewController *vc2 = [[LoginViewController alloc] init];
//    [vc2.view setBackgroundColor:[UIColor blueColor]];
    
    UITabBarItem *tabBar1 = [[UITabBarItem alloc] initWithTitle:@"Bar1" image:nil tag:0];
    UITabBarItem *tabBar2 = [[UITabBarItem alloc] initWithTitle:@"Bar2" image:nil tag:1];
    [vc1 setTabBarItem:tabBar1];
    [vc2 setTabBarItem:tabBar2];
    
    tabBarController.viewControllers = [NSArray arrayWithObjects:vc1,vc2, nil];
    
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene*)scene];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    
    // parse config
    ParseClientConfiguration *config = [ParseClientConfiguration  configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {

        configuration.applicationId = @"vvbIwlXyP84uRz4ZtrX1eT63OMAnZ85hcfTl141O";
        configuration.clientKey = @"3A9foPGWhcrDUHbul0UWcUfMfgXkt3OKOb2XCCph";
        configuration.server = @"https://parseapi.back4app.com";
    }];

    [Parse initializeWithConfiguration:config];
    
    // already logged in, present home screen
    if (PFUser.currentUser) {
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] init];

        [nav setViewControllers:@[homeVC]];
        self.window.rootViewController = nav;
    }
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
