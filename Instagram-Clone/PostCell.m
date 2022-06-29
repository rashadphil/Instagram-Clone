//
//  PostCell.m
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/27/22.
//

#import "PostCell.h"
#import "UIView+Extension.h"
#import "PFUser+Extension.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    self.postImageView.file = post[@"image"];
    [self.postImageView loadInBackground];
    
    PFUser *author = post[@"author"];
    self.profilePictureView.file = [author getProfilePicture];
    [self.profilePictureView loadInBackground];
    
    self.authorLabel.text = author[@"username"];
    self.captionLabel.text = post[@"caption"];
}

- (void) initProperties {
    self.profilePictureView = [self createProfilePictureView];
    self.authorLabel = [self createAuthorLabel];
    
    self.topBannerView = [self createTopBannerView];
    self.postImageView = [self createPostImageView];
    
    self.bottomBannerView = [self createBottomBannerView];
    self.likeButton = [self createLikeButton];
    self.commentButton = [self createCommentButton];
    
    self.captionLabel = [self createCaptionLabel];
    
    
}

- (UIView*)createTopBannerView {
    UIView *banner = [[UIView alloc] init];
    banner.backgroundColor = [UIColor blackColor];
    return banner;
}

- (PFImageView*)createProfilePictureView {
    PFImageView *imageView = [[PFImageView alloc] init];
    imageView.clipsToBounds = true;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.backgroundColor = [UIColor grayColor];
    [imageView.layer setCornerRadius:18];
    imageView.userInteractionEnabled = true;
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentProfilePictureSelection:)];
//    tapGesture.numberOfTapsRequired = 1;
//    [imageView addGestureRecognizer:tapGesture];
    return imageView;
}

- (UILabel*)createAuthorLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    return label;
}

- (PFImageView*)createPostImageView {
    PFImageView *imageView = [[PFImageView alloc] init];
    imageView.clipsToBounds = true;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return imageView;
}

- (UIView*)createBottomBannerView {
    UIView *banner = [[UIView alloc] init];
    banner.backgroundColor = [UIColor blackColor];
    return banner;
}

- (UIButton*)createLikeButton {
    UIButton *button = [[UIButton alloc] init];
    UIImage *heartImage = [UIImage systemImageNamed:@"heart"];
    [button setImage:heartImage forState:UIControlStateNormal];
    [[button imageView] setContentMode: UIViewContentModeScaleAspectFit];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [button setTintColor:[UIColor whiteColor]];

    return button;
}

- (UIButton*)createCommentButton {
    UIButton *button = [self createLikeButton];
    UIImage *commentImage = [UIImage systemImageNamed:@"message"];
    [button setImage:commentImage forState:UIControlStateNormal];
    return button;
}

- (UILabel*)createCaptionLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    [label sizeToFit];
    return label;
}

- (void)setupTopBannerView {
    [self.topBannerView anchor:self.topAnchor left:self.leftAnchor bottom:nil right:self.rightAnchor paddingTop:0 paddingLeft:0 paddingBottom:0 paddingRight:0 width:self.frame.size.width height:50 enableInsets:false];
}
- (void)setupProfilePictureView {
    [self.profilePictureView anchor:self.topBannerView.topAnchor left:self.topBannerView.leftAnchor bottom:self.topBannerView.bottomAnchor right:nil paddingTop:8 paddingLeft:5 paddingBottom:8 paddingRight:5 width:35 height:35 enableInsets:false];
}
- (void)setupAuthorLabel {
    [self.authorLabel anchor:self.topBannerView.topAnchor left:self.profilePictureView.rightAnchor bottom:self.topBannerView.bottomAnchor right:self.rightAnchor paddingTop:0 paddingLeft:10 paddingBottom:0 paddingRight:0 width:self.frame.size.width height:0 enableInsets:false];
}
- (void)setupPostImageView {
    [self.postImageView anchor:self.topBannerView.bottomAnchor left:self.leftAnchor bottom:nil right:self.rightAnchor paddingTop:0 paddingLeft:0 paddingBottom:0 paddingRight:0 width:self.frame.size.width height:self.frame.size.width enableInsets:false];
}
- (void)setupBottomBannerView {
    [self.bottomBannerView anchor:self.postImageView.bottomAnchor left:self.leftAnchor bottom:self.bottomAnchor right:self.rightAnchor paddingTop:8 paddingLeft:0 paddingBottom:0 paddingRight:0 width:self.frame.size.width height:80 enableInsets:false];
}
- (void)setupLikeButton {
    [self.likeButton anchor:self.bottomBannerView.topAnchor left:self.leftAnchor bottom:nil right:nil paddingTop:0 paddingLeft:8 paddingBottom:0 paddingRight:8 width:30 height:30 enableInsets:false];
}
- (void)setupCommentButton {
    [self.commentButton anchor:self.bottomBannerView.topAnchor left:self.likeButton.rightAnchor bottom:nil right:nil paddingTop:0 paddingLeft:8 paddingBottom:0 paddingRight:8 width:30 height:30 enableInsets:false];
}

- (void)setupCaptionLabel {
    [self.captionLabel anchor:self.likeButton.bottomAnchor left:self.leftAnchor bottom:self.bottomAnchor right:self.rightAnchor paddingTop:0 paddingLeft:8 paddingBottom:0 paddingRight:0 width:self.frame.size.width height:0 enableInsets:false];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        [self initProperties];
        
        [self addSubview:self.topBannerView];
        [self.topBannerView addSubview:self.profilePictureView];
        [self.topBannerView addSubview:self.authorLabel];
        
        [self addSubview:self.postImageView];
        
        [self addSubview:self.bottomBannerView];
        [self.bottomBannerView addSubview:self.likeButton];
        [self.bottomBannerView addSubview:self.commentButton];
        [self.bottomBannerView addSubview:self.captionLabel];
        
        [self setupTopBannerView];
        [self setupPostImageView];
        [self setupAuthorLabel];
        [self setupProfilePictureView];
        
        [self setupBottomBannerView];
        [self setupLikeButton];
        [self setupCommentButton];
        [self setupCaptionLabel];
        
        
    }
    
    return self;
    
}

@end
