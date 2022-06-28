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

- (void) initProperties {
    self.postImageView = [self createPostImageView];
}

- (UIImageView*)createPostImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.clipsToBounds = true;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    return imageView;
}

- (void)setupPostImageView {
    [self.postImageView anchor:self.topAnchor left:self.leftAnchor bottom:nil right:self.rightAnchor paddingTop:0 paddingLeft:0 paddingBottom:0 paddingRight:0 width:300 height:300 enableInsets:false];
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
