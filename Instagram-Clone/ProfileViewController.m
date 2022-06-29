//
//  ProfileViewController.m
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/28/22.
//

#import "ProfileViewController.h"
#import "UIView+Extension.h"
#import "PFUser+Extension.h"
#import <Parse/Parse.h>
#import "Post.h"

@import Parse;

@interface ProfileViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) UILabel *usernameLabel;
@property (strong, nonatomic) PFImageView *profilePictureView;
@property (strong, nonatomic) UINavigationController *myNav;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.myNav = self.navigationController;
    
    [self.view addSubview:self.profilePictureView];
    
    [self setupNavbar];
    [self setupProfilePictureView];
}

- (void)initProperties {
    self.usernameLabel = [self createUsernameLabel];
    self.profilePictureView = [self createProfilePictureView];
    
}

- (void)presentProfilePictureSelection:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *newImage = info[UIImagePickerControllerEditedImage];

    self.profilePictureView.image = newImage;
    [PFUser.currentUser setProfilePicture:newImage];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void) setupNavbar {
    CGFloat barHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    
    UINavigationBar *navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, barHeight, self.myNav.view.frame.size.width, 44)];
    [navbar setTranslucent:false];
    [navbar setBarTintColor:[UIColor blackColor]];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    UIBarButtonItem *usernameLabelItem = [[UIBarButtonItem alloc] initWithCustomView:self.usernameLabel];

    [navItem setLeftBarButtonItem:usernameLabelItem];
    [navbar setItems:@[navItem]];
    [self.myNav.view addSubview:navbar];
}

- (UILabel*)createUsernameLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:28 weight:UIFontWeightBold];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    label.text = @"rashadphil";
    return label;
}

- (PFImageView*)createProfilePictureView {
    PFImageView *imageView = [[PFImageView alloc] init];
    imageView.clipsToBounds = true;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.backgroundColor = [UIColor grayColor];
    [imageView.layer setCornerRadius:60];
    
    
    imageView.userInteractionEnabled = true;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentProfilePictureSelection:)];
    tapGesture.numberOfTapsRequired = 1;
    [imageView addGestureRecognizer:tapGesture];
    return imageView;
}

- (void) setupProfilePictureView {
    
    CGFloat paddingTop = UIApplication.sharedApplication.statusBarFrame.size.height + self.myNav.navigationBar.frame.size.height;
    [self.profilePictureView anchor:self.view.topAnchor left:self.view.leftAnchor bottom:nil right:nil paddingTop:paddingTop paddingLeft:0 paddingBottom:10 paddingRight:0 width:120 height:120 enableInsets:false];
    
    self.profilePictureView.file = [PFUser.currentUser getProfilePicture];
    [self.profilePictureView loadInBackground];

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
