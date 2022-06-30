//
//  ComposeViewController.m
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/27/22.
//

#import "ComposeViewController.h"
#import "HomeViewController.h"
#import "Post.h"
#import "UIView+Extension.h"

@interface ComposeViewController ()

@property (strong, nonatomic) UINavigationController *myNav;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *shareButton;
@property (strong, nonatomic) UIImage *selectedImage;

@property (strong, nonatomic) UIImageView *selectedImageView;
@property (strong, nonatomic) UITextField *captionTextField;


@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];
    
    self.view.backgroundColor = [UIColor colorNamed:@"darkGrey"];
    self.myNav = self.navigationController;
    [self setupNavbar];
    
    [self.view addSubview:self.selectedImageView];
    [self.view addSubview:self.captionTextField];
    [self setupSelectedImageView];
    [self setupCaptionTextField];
}

- (void) cancelPost:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void) sharePost:(UIButton *)sender {
    if (self.selectedImage) {
        [Post postUserImage:self.selectedImage withCaption:self.captionTextField.text withCompletion:nil];
    }
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void) presentImagePicker:(id)sender {
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
    self.selectedImage = editedImage;
    self.selectedImageView.image = editedImage;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) setupNavbar {
    CGFloat barHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    
    UINavigationBar *navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, barHeight, self.myNav.view.frame.size.width, 44)];
    
    navbar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [navbar setBarTintColor:[UIColor blackColor]];
    [navbar setTranslucent:NO];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"New Post"];
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.cancelButton];
    UIBarButtonItem *shareButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.shareButton];

    [navItem setLeftBarButtonItem:cancelButtonItem];
    [navItem setRightBarButtonItem:shareButtonItem];
    [navbar setItems:@[navItem]];
    [self.myNav.view addSubview:navbar];
}

- (void) initProperties {
    self.cancelButton = [self createCancelButton];
    self.shareButton = [self createShareButton];
    self.selectedImageView = [self createSelectedImageView];
    self.captionTextField = [self createCaptionTextField];
    
}

- (UIButton*)createCancelButton {
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(cancelPost:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Cancel" forState:UIControlStateNormal];
    return button;
}
- (UIButton*)createShareButton {
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(sharePost:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Share" forState:UIControlStateNormal];
    return button;
}
- (UIImageView*)createSelectedImageView {
    UIImageView *view = [[UIImageView alloc] init];
    [view setClipsToBounds:true];
    view.image = [UIImage systemImageNamed:@"camera"];
    view.contentMode = UIViewContentModeScaleAspectFit;
    
    [view setTintColor:[UIColor whiteColor]];
    view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(presentImagePicker:)];
    tapGesture.numberOfTapsRequired = 1;

    [view addGestureRecognizer:tapGesture];
    
    return view;
}
- (UITextField*)createCaptionTextField {
    UITextField *textField = [[UITextField alloc] init];
    
    UIColor *color = [UIColor lightGrayColor];
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Write a caption..." attributes:@{NSForegroundColorAttributeName: color}];
    [textField setTextColor:[UIColor whiteColor]];
    
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    return textField;
}

- (void)setupSelectedImageView {
    CGFloat paddingTop = UIApplication.sharedApplication.statusBarFrame.size.height + self.myNav.navigationBar.frame.size.height;
    [self.selectedImageView anchor:self.view.topAnchor left:self.view.leftAnchor bottom:nil right:nil paddingTop:paddingTop paddingLeft:0 paddingBottom:10 paddingRight:0 width:120 height:120 enableInsets:false];
}
- (void)setupCaptionTextField {
    CGFloat paddingTop = UIApplication.sharedApplication.statusBarFrame.size.height + self.myNav.navigationBar.frame.size.height;
    [self.captionTextField anchor:self.view.topAnchor left:self.selectedImageView.rightAnchor bottom:nil right:self.view.rightAnchor paddingTop:paddingTop + 30 paddingLeft:10 paddingBottom:10 paddingRight:0 width:0 height:0 enableInsets:false];
}


@end
