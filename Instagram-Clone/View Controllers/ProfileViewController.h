//
//  ProfileViewController.h
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/28/22.
//

#import <UIKit/UIKit.h>
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (strong, nonatomic) PFUser *user;


@end

NS_ASSUME_NONNULL_END
