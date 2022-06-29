//
//  PFUser+Extension.m
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/28/22.
//

#import "PFUser+Extension.h"
#import "Post.h"
@import Parse;

@implementation PFUser (Extension)

- (PFFileObject *)getProfilePicture {
    PFFileObject *profilePictureObject = self[@"profilePicture"];
    return profilePictureObject;
}

- (void) setProfilePicture:(UIImage *)picture {
    PFFileObject *fileObject = [Post getPFFileFromImage:picture];
    [PFUser.currentUser setObject:fileObject forKey:@"profilePicture"];
    [PFUser.currentUser saveInBackground];
}

@end
