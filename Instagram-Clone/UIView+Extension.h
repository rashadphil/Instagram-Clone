//
//  Extension.h
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (AnchorExtension)

- (void) anchor:(nullable NSLayoutYAxisAnchor*)top left:(nullable NSLayoutXAxisAnchor*)left bottom:(nullable NSLayoutYAxisAnchor*)bottom right:(nullable NSLayoutXAxisAnchor*)right paddingTop:(CGFloat)paddingRight paddingLeft:(CGFloat)paddingLeft paddingBottom:(CGFloat)paddingBottom paddingRight:(CGFloat)paddingRight width:(CGFloat)width height:(CGFloat)height enableInsets:(BOOL)enableInsets;

@end

NS_ASSUME_NONNULL_END
