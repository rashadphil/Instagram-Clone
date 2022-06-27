//
//  ViewController.m
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/26/22.
//

#import "LoginViewController.h"
#import "UIView+Extension.h"
#import "HomeViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (strong, nonatomic) UIView *loginContentView;
@property (strong, nonatomic) UITextField *usernameField;
@property (strong, nonatomic) UITextField *passwordField;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UIButton *signupButton;
@property (strong, nonatomic) UILabel *instagramLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initProperties];
    [self setUpLoginView];
    
}

- (void) initProperties {
    self.loginContentView = [self createLoginContentView];
    self.usernameField = [self createUsernameField];
    self.passwordField = [self createPasswordField];
    self.instagramLabel = [self createInstagramLabel];
    self.loginButton = [self createLoginButton];
    self.signupButton = [self createSignupButton];
}

- (void) registerUser:(UIButton *)sender {
    PFUser *newUser = [PFUser user];
        
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            // manually segue to logged in view
            [self presentHomeVC];
        }
    }];
}

- (void) loginUser:(UIButton *)sender {
    NSString* username = self.usernameField.text;
    NSString* password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self presentHomeVC];
        }
    }];
    
}

- (void) presentHomeVC {
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] init];
    
    [nav setViewControllers:@[homeVC]];
    [nav setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:nav animated:true completion:nil];
}


- (UILabel*)createInstagramLabel {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Instagram";
    return label;
}

- (UIView*)createLoginContentView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor greenColor];
    return view;
}

- (UITextField*)createUsernameField {
    UITextField *usernameField = [[UITextField alloc] init];
    [usernameField setPlaceholder:@"Username"];
    usernameField.backgroundColor = [UIColor redColor];
    return usernameField;
}

- (UITextField*)createPasswordField {
    UITextField *passwordField = [[UITextField alloc] init];
    [passwordField setPlaceholder:@"Password"];
    passwordField.backgroundColor = [UIColor orangeColor];
    return passwordField;
}

- (UIButton*)createLoginButton {
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(loginUser:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Log in" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    
    return button;
}

- (UIButton*)createSignupButton {
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Sign up" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    
    return button;
}

- (void)setUpLoginView {
    CGFloat barHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    CGFloat displayWidth = self.view.frame.size.width;
    CGFloat displayHeight = self.view.frame.size.height;
    
    [self.view addSubview:self.loginContentView];
    [self.loginContentView addSubview:self.usernameField];
    [self.loginContentView addSubview:self.passwordField];
    [self.loginContentView addSubview:self.loginButton];
    [self.loginContentView addSubview:self.signupButton];
    
    [self.loginContentView anchor:nil left:self.view.leftAnchor bottom:nil right:self.view.rightAnchor paddingTop:0 paddingLeft:0 paddingBottom:0 paddingRight:0 width:displayWidth height:displayHeight/3 enableInsets:false];
    [[self.loginContentView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:true];
    
    [self setupUsernameField];
    [self setupPasswordField];
    [self setupLoginButton];
    [self setupSignupButton];
}

- (void)setupUsernameField {
    [self.usernameField anchor:self.loginContentView.topAnchor left:self.loginContentView.leftAnchor bottom:nil right:self.loginContentView.rightAnchor paddingTop:10 paddingLeft:20 paddingBottom:0 paddingRight:20 width:0 height:40 enableInsets:false];
    [[self.usernameField.centerXAnchor constraintEqualToAnchor:self.loginContentView.centerXAnchor] setActive:true];
}

- (void)setupPasswordField {
    [self.passwordField anchor:self.usernameField.bottomAnchor left:self.loginContentView.leftAnchor bottom:nil right:self.loginContentView.rightAnchor paddingTop:10 paddingLeft:20 paddingBottom:0 paddingRight:20 width:0 height:40 enableInsets:false];
    [[self.passwordField.centerXAnchor constraintEqualToAnchor:self.loginContentView.centerXAnchor] setActive:true];
}
- (void)setupLoginButton {
    [self.loginButton anchor:self.passwordField.bottomAnchor left:self.loginContentView.leftAnchor bottom:nil right:self.loginContentView.rightAnchor paddingTop:20 paddingLeft:20 paddingBottom:0 paddingRight:20 width:0 height:40 enableInsets:false];
    [[self.loginButton.centerXAnchor constraintEqualToAnchor:self.loginContentView.centerXAnchor] setActive:true];
}

- (void)setupSignupButton {
    [self.signupButton anchor:self.loginButton.bottomAnchor left:self.loginContentView.leftAnchor bottom:nil right:self.loginContentView.rightAnchor paddingTop:10 paddingLeft:20 paddingBottom:0 paddingRight:20 width:0 height:40 enableInsets:false];
    [[self.signupButton.centerXAnchor constraintEqualToAnchor:self.loginContentView.centerXAnchor] setActive:true];
}



@end
