//
//  PostCell.m
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/27/22.
//

#import "PostCell.h"
#import "UIView+Extension.h"

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
}

- (void) initProperties {
    self.postImageView = [self createPostImageView];
}

- (PFImageView*)createPostImageView {
    PFImageView *imageView = [[PFImageView alloc] init];
    imageView.clipsToBounds = true;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    return imageView;
}

- (void)setupPostImageView {
    [self.postImageView anchor:self.topAnchor left:self.leftAnchor bottom:self.bottomAnchor right:self.rightAnchor paddingTop:0 paddingLeft:0 paddingBottom:0 paddingRight:0 width:self.frame.size.width height:self.frame.size.width enableInsets:false];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        [self initProperties];
        [self addSubview:self.postImageView];
        
        
        [self setupPostImageView];
        
    }
    
    return self;
    
}

@end
