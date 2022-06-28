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
@property (strong, nonatomic) UIImageView *instagramCursiveView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    [self initProperties];
    [self setUpLoginView];
    
}

- (void) initProperties {
    self.loginContentView = [self createLoginContentView];
    self.usernameField = [self createUsernameField];
    self.passwordField = [self createPasswordField];
    self.instagramCursiveView = [self createInstagramCursiveView];
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


- (UIImageView*)createInstagramCursiveView {
    UIImageView *view = [[UIImageView alloc] init];
    view.image = [UIImage imageNamed:@"instagram-cursive"];
    view.tintColor = [UIColor whiteColor];
    view.clipsToBounds = true;
    view.contentMode = UIViewContentModeScaleAspectFit;
    
    return view;
}

- (UIView*)createLoginContentView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor blackColor];
    return view;
}

- (UITextField*)createUsernameField {
    UITextField *usernameField = [[UITextField alloc] init];
    usernameField.backgroundColor = [UIColor colorNamed:@"darkGrey"];
    usernameField.textColor = [UIColor whiteColor];
    
    UIColor *placeholderColor = [UIColor lightGrayColor];
    usernameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    [usernameField.layer setCornerRadius:5];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    usernameField.leftView = paddingView;
    usernameField.leftViewMode = UITextFieldViewModeAlways;
    
    [usernameField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [usernameField setAutocorrectionType:UITextAutocorrectionTypeNo];
    return usernameField;
}

- (UITextField*)createPasswordField {
    // same styling as usernamefield
    UITextField *passwordField = [self createUsernameField];
    UIColor *placeholderColor = [UIColor lightGrayColor];
    passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    [passwordField setSecureTextEntry:true];
    return passwordField;
}

- (UIButton*)createLoginButton {
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(loginUser:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor colorNamed:@"instagramBlue"];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"Log in" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, [attributedString length])];
    [button setAttributedTitle:attributedString forState:UIControlStateNormal];
    
    [button.layer setCornerRadius:5];
    return button;
}

- (UIButton*)createSignupButton {
    UIButton *button = [self createLoginButton];
    [button addTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:[ button attributedTitleForState:UIControlStateNormal]];
    [attributedString replaceCharactersInRange:NSMakeRange(0, attributedString.length) withString:@"Sign up"];
    [button setAttributedTitle:attributedString forState:UIControlStateNormal];
    
    return button;
}

- (void)setUpLoginView {
    CGFloat barHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    CGFloat displayWidth = self.view.frame.size.width;
    CGFloat displayHeight = self.view.frame.size.height;
    
    [self.view addSubview:self.instagramCursiveView];
    [self.view addSubview:self.loginContentView];
    [self.loginContentView addSubview:self.usernameField];
    [self.loginContentView addSubview:self.passwordField];
    [self.loginContentView addSubview:self.loginButton];
    [self.loginContentView addSubview:self.signupButton];
    
    [self.loginContentView anchor:self.instagramCursiveView.bottomAnchor left:self.view.leftAnchor bottom:nil right:self.view.rightAnchor paddingTop:0 paddingLeft:0 paddingBottom:0 paddingRight:0 width:displayWidth height:displayHeight/3 enableInsets:false];
    [[self.loginContentView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:true];
    
    [self setupInstagramCursiveView];
    [self setupUsernameField];
    [self setupPasswordField];
    [self setupLoginButton];
    [self setupSignupButton];
}

- (void)setupInstagramCursiveView {
    [self.instagramCursiveView anchor:nil left:self.view.leftAnchor bottom:nil right:self.view.rightAnchor paddingTop:10 paddingLeft:0 paddingBottom:20 paddingRight:0 width:self.view.frame.size.width/2 height:65 enableInsets:false];
    [[self.usernameField.centerXAnchor constraintEqualToAnchor:self.loginContentView.centerXAnchor] setActive:true];
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
