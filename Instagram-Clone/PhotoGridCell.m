//
//  PhotoGridCell.m
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/29/22.
//

#import "PhotoGridCell.h"
#import "UIView+Extension.h"

@implementation PhotoGridCell

- (void) initProperties {
    self.postImageView = [self createPostImageView];
    
}

- (void)setPost:(Post *)post {
    _post = post;
    self.postImageView.file = post[@"image"];
    [self.postImageView loadInBackground];
}

- (PFImageView*)createPostImageView {
    PFImageView *imageView = [[PFImageView alloc] init];
    imageView.clipsToBounds = true;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.backgroundColor = [UIColor grayColor];
    imageView.userInteractionEnabled = true;
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentProfilePictureSelection:)];
//    tapGesture.numberOfTapsRequired = 1;
//    [imageView addGestureRecognizer:tapGesture];
    return imageView;
}

- (void)setupPostImageView {
    [self.postImageView anchor:self.topAnchor left:self.leftAnchor bottom:self.bottomAnchor right:self.rightAnchor paddingTop:0 paddingLeft:0 paddingBottom:0 paddingRight:0 width:100 height:100 enableInsets:false];
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initProperties];
        [self addSubview:self.postImageView];
        
        [self setupPostImageView];
        self.backgroundColor=[UIColor greenColor];
        self.layer.masksToBounds = YES;
    }
    return self;
}


@end
