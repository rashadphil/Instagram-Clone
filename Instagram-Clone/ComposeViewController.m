//
//  ComposeViewController.m
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/27/22.
//

#import "ComposeViewController.h"
#import "HomeViewController.h"
#import "Post.h"

@interface ComposeViewController ()

@property (strong, nonatomic) UINavigationController *myNav;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *shareButton;
@property (strong, nonatomic) UIButton *selectPhotoButton;
@property (strong, nonatomic) UIImage *selectedImage;


@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];
    
    self.view.backgroundColor = [UIColor blueColor];
    self.myNav = self.navigationController;
    [self setupNavbar];
}

- (void) cancelPost:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (void) sharePost:(UIButton *)sender {
    if (self.selectedImage) {
        [Post postUserImage:self.selectedImage withCaption:@"Oh yeah" withCompletion:nil];
    }
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void) presentImagePicker:(UIButton *)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        NSLog(@"Camera not available, using photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    self.selectedImage = originalImage;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) setupNavbar {
    CGFloat barHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    
    UINavigationBar *navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, barHeight, self.myNav.view.frame.size.width, 44)];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.cancelButton];
    UIBarButtonItem *shareButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.shareButton];
    UIBarButtonItem *selectPhotoButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.selectPhotoButton];

//    [navItem setLeftBarButtonItem:cancelButtonItem];
    [navItem setLeftBarButtonItem:selectPhotoButtonItem];
    [navItem setRightBarButtonItem:shareButtonItem];
    [navbar setItems:@[navItem]];
    [self.myNav.view addSubview:navbar];
}

- (void) initProperties {
    self.cancelButton = [self createCancelButton];
    self.shareButton = [self createShareButton];
    self.selectPhotoButton = [self createSelectPhotoButton];
    
}

- (UIButton*)createCancelButton {
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(cancelPost:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Cancel" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    return button;
}
- (UIButton*)createShareButton {
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(sharePost:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Share" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    return button;
}
- (UIButton*)createSelectPhotoButton {
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(presentImagePicker:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Select Photo" forState:UIControlStateNormal];
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
