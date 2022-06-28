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
    self.authorLabel.text = post[@"author"][@"username"];
    self.captionLabel.text = post[@"caption"];
}

- (void) initProperties {
    self.postImageView = [self createPostImageView];
    self.authorLabel = [self createAuthorLabel];
    self.captionLabel = [self createCaptionLabel];
}

- (UILabel*)createAuthorLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor orangeColor];
    return label;
}

- (PFImageView*)createPostImageView {
    PFImageView *imageView = [[PFImageView alloc] init];
    imageView.clipsToBounds = true;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return imageView;
}

- (UILabel*)createCaptionLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor redColor];
    return label;
}


- (void)setupAuthorLabel {
    [self.authorLabel anchor:self.topAnchor left:self.leftAnchor bottom:nil right:self.rightAnchor paddingTop:10 paddingLeft:0 paddingBottom:10 paddingRight:0 width:self.frame.size.width height:0 enableInsets:false];
}
- (void)setupPostImageView {
    [self.postImageView anchor:self.authorLabel.topAnchor left:self.leftAnchor bottom:nil right:self.rightAnchor paddingTop:0 paddingLeft:0 paddingBottom:0 paddingRight:0 width:self.frame.size.width height:self.frame.size.width enableInsets:false];
}
- (void)setupCaptionLabel {
    [self.captionLabel anchor:self.postImageView.bottomAnchor left:self.leftAnchor bottom:self.bottomAnchor right:self.rightAnchor paddingTop:0 paddingLeft:0 paddingBottom:0 paddingRight:0 width:self.frame.size.width height:0 enableInsets:false];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        [self initProperties];
        
        [self addSubview:self.postImageView];
        [self addSubview:self.authorLabel];
        [self addSubview:self.captionLabel];
        
        [self setupPostImageView];
        [self setupAuthorLabel];
        [self setupCaptionLabel];
        
    }
    
    return self;
    
}

@end
