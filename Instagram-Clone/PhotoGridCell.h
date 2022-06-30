//
//  PhotoGridCell.h
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface PhotoGridCell : UICollectionViewCell

@property (nonatomic, strong) Post *post;
@property (nonatomic, strong) PFImageView *postImageView;

@end

NS_ASSUME_NONNULL_END
