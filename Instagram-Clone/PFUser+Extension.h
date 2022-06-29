//
//  PFUser+Extension.h
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/28/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface PFUser (Extension)

- (PFFileObject *)getProfilePicture;

- (void) setProfilePicture:(UIImage *)picture ;

@end

NS_ASSUME_NONNULL_END
