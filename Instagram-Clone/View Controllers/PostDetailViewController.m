//
//  PostDetailViewController.m
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/28/22.
//

#import "PostDetailViewController.h"
#import "UIView+Extension.h"
#import "Post.h"
@import Parse;

@interface PostDetailViewController ()
@property (strong, nonatomic) PFImageView *postImageView;
@property (strong, nonatomic) UILabel *timestampLabel;
@property (strong, nonatomic) UILabel *captionLabel;

@end

@implementation PostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.postImageView];
    [self.view addSubview:self.timestampLabel];
    [self.view addSubview:self.captionLabel];
    
    [self setupPostImageView];
    [self setupTimestampLabel];
    [self setupCaptionLabel];
    
    [self setViewValues];
}

- (void) initProperties {
    self.timestampLabel = [self createTimestampLabel];
    self.captionLabel = [self createCaptionLabel];
    self.postImageView = [self createPostImageView];
}

- (void)setViewValues{
    
    NSDate* createdAt = self.post.createdAt;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *stringDate = [dateFormatter stringFromDate:createdAt];
    
    self.timestampLabel.text = stringDate;
    self.captionLabel.text = self.post[@"caption"];
    
    self.postImageView.file = self.post[@"image"];
    [self.postImageView loadInBackground];
}



- (PFImageView*)createPostImageView {
    PFImageView *imageView = [[PFImageView alloc] init];
    imageView.clipsToBounds = true;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return imageView;
}

- (UILabel*)createTimestampLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    [label sizeToFit];
    return label;
}
- (UILabel*)createCaptionLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    [label sizeToFit];
    return label;
}

- (void)setupPostImageView {
    [self.postImageView anchor:self.view.topAnchor left:self.view.leftAnchor bottom:nil right:nil paddingTop:8 paddingLeft:5 paddingBottom:8 paddingRight:5 width:300 height:300 enableInsets:false];
}

- (void)setupCaptionLabel {
    [self.captionLabel anchor:self.postImageView.bottomAnchor left:self.view.leftAnchor bottom:nil right:self.view.rightAnchor paddingTop:10 paddingLeft:10 paddingBottom:0 paddingRight:20 width:0 height:0 enableInsets:false];
//    [[self.captionLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor] setActive:true];
}
- (void)setupTimestampLabel {
    [self.timestampLabel anchor:self.captionLabel.bottomAnchor left:self.view.leftAnchor bottom:nil right:self.view.rightAnchor paddingTop:10 paddingLeft:10 paddingBottom:0 paddingRight:20 width:0 height:0 enableInsets:false];
    [[self.timestampLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor] setActive:true];
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
