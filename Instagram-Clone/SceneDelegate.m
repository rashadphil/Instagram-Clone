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
#import "InstagramTabBarController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    
    
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene*)scene];
    self.window.rootViewController = loginVC;
    [self.window makeKeyAndVisible];
    
    
    
    // parse config
    ParseClientConfiguration *config = [ParseClientConfiguration  configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {

        configuration.applicationId = @"vvbIwlXyP84uRz4ZtrX1eT63OMAnZ85hcfTl141O";
        configuration.clientKey = @"3A9foPGWhcrDUHbul0UWcUfMfgXkt3OKOb2XCCph";
        configuration.server = @"https://parseapi.back4app.com";
    }];

    if ([Parse currentConfiguration] == nil) {
        [Parse initializeWithConfiguration:config];
    }
    
    // already logged in, present home screen
    if (PFUser.currentUser) {
        InstagramTabBarController *tabBarController = [[InstagramTabBarController alloc] init];
        self.window.rootViewController = tabBarController;
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
