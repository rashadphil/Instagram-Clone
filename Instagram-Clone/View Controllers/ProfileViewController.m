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
#import "PhotoGridCell.h"

@import Parse;

@interface ProfileViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UILabel *usernameLabel;
@property (strong, nonatomic) PFImageView *profilePictureView;
@property (strong, nonatomic) UINavigationController *myNav;
@property (strong, nonatomic) UICollectionView *gridView;
@property (strong, nonatomic) NSArray *userPosts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.myNav = self.navigationController;
    
    [self.view addSubview:self.profilePictureView];
    [self.view addSubview:self.gridView];
    
    [self setupNavbar];
    [self setupProfilePictureView];
    [self setupGridView];
    
    [self fetchUserPosts];
}

- (void)initProperties {
    if (self.user == nil){
        self.user = PFUser.currentUser;
    }
    self.usernameLabel = [self createUsernameLabel];
    self.profilePictureView = [self createProfilePictureView];
    
    self.gridView = [self createGridView];
}

- (void) fetchUserPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query whereKey:@"author" equalTo:self.user];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * posts, NSError * error) {
        if (posts != nil) {
            self.userPosts = [posts mutableCopy];
            [self.gridView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
    }];
    
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
    label.text = self.user.username;
    return label;
}

- (PFImageView*)createProfilePictureView {
    PFImageView *imageView = [[PFImageView alloc] init];
    imageView.clipsToBounds = true;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.backgroundColor = [UIColor grayColor];
    [imageView.layer setCornerRadius:50];
    
    // You cannot change someone else's profile picture!
    if (self.user.username == PFUser.currentUser.username) {
        imageView.userInteractionEnabled = true;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentProfilePictureSelection:)];
        tapGesture.numberOfTapsRequired = 1;
        [imageView addGestureRecognizer:tapGesture];
    }
    return imageView;
}

- (UICollectionView*) createGridView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *gridView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [gridView setDataSource:self];
    [gridView setDelegate:self];
    
    [gridView registerClass:[PhotoGridCell class] forCellWithReuseIdentifier:@"PhotoGridCell"];
    gridView.backgroundColor = [UIColor blackColor];
    return gridView;
}

- (void) setupProfilePictureView {
    
    CGFloat paddingTop = UIApplication.sharedApplication.statusBarFrame.size.height + self.myNav.navigationBar.frame.size.height;
    [self.profilePictureView anchor:self.view.topAnchor left:self.view.leftAnchor bottom:nil right:nil paddingTop:paddingTop + 10 paddingLeft:10 paddingBottom:10 paddingRight:0 width:100 height:100 enableInsets:false];
    
    self.profilePictureView.file = [self.user getProfilePicture];
    [self.profilePictureView loadInBackground];

}
- (void) setupGridView {
    
    [self.gridView anchor:self.profilePictureView.bottomAnchor left:self.view.leftAnchor bottom:nil right:self.view.rightAnchor paddingTop:10 paddingLeft:0 paddingBottom:10 paddingRight:0 width:self.view.frame.size.width height:900 enableInsets:false];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PhotoGridCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoGridCell" forIndexPath:indexPath];
    
    Post *currentPost = self.userPosts[indexPath.row];
    [cell setPost:currentPost];

    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0.5, 0, 0.5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.userPosts.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width/3 - 2, self.view.frame.size.width/3);
}


@end
