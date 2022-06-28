//
//  PostCell.h
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (nonatomic, strong) Post *post;

@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *captionLabel;
@property (nonatomic, strong) PFImageView *postImageView;
@property (nonatomic, strong) UILabel *likeCountLabel;
@property (nonatomic, strong) UILabel *commentCountLabel;

@end

NS_ASSUME_NONNULL_END
