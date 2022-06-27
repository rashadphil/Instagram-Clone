//
//  HomeViewController.m
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/27/22.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import "LoginViewController.h"
#import "SceneDelegate.h"

@interface HomeViewController ()

@property (strong, nonatomic) UIButton *logoutButton;
@property (strong, nonatomic) UINavigationController *myNav;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];
    
    self.view.backgroundColor = [UIColor redColor];
    
    // nav bar setup
    self.myNav = self.navigationController;
    [self setupNavbar];
}

- (void) initProperties {
    self.logoutButton = [self createLogoutButton];
}

- (void) setupNavbar {
    CGFloat barHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    
    UINavigationBar *navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, barHeight, self.myNav.view.frame.size.width, 44)];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"Home Feed"];
    UIBarButtonItem *logoutButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.logoutButton];
    [navItem setLeftBarButtonItem:logoutButtonItem];
    [navbar setItems:@[navItem]];
    [self.myNav.view addSubview:navbar];
}

- (void) logoutUser:(UIButton *)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        myDelegate.window.rootViewController = loginVC;
    }];
}

- (UIButton*)createLogoutButton {
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(logoutUser:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Logout" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    return button;
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
