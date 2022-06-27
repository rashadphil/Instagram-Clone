//
//  Extension.m
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/27/22.
//

#import "UIView+Extension.h"

@implementation UIView (AnchorExtension)


- (void) anchor:(nullable NSLayoutYAxisAnchor*)top left:(nullable NSLayoutXAxisAnchor*)left bottom:(nullable NSLayoutYAxisAnchor*)bottom right:(nullable NSLayoutXAxisAnchor*)right paddingTop:(CGFloat)paddingTop paddingLeft:(CGFloat)paddingLeft paddingBottom:(CGFloat)paddingBottom paddingRight:(CGFloat)paddingRight width:(CGFloat)width height:(CGFloat)height enableInsets:(BOOL)enableInsets {
    
    CGFloat topInset = 0;
    CGFloat bottomInset = 0;
    
    if (enableInsets) {
        UIEdgeInsets insets = self.safeAreaInsets;
        topInset = insets.top;
        bottomInset = insets.bottom;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = false;
    
    if (top) {
        [[self.topAnchor constraintEqualToAnchor:top constant:paddingTop + topInset] setActive:true];
    }
    if (left) {
        [[self.leftAnchor constraintEqualToAnchor:left constant:paddingLeft] setActive:true];
    }
    if (right) {
        [[self.rightAnchor constraintEqualToAnchor:right constant:-paddingRight] setActive:true];
    }
    if (bottom) {
        [[self.bottomAnchor constraintEqualToAnchor:bottom constant:-paddingBottom-bottomInset] setActive:true];
    }
    if (height != 0) {
        [[self.heightAnchor constraintEqualToConstant:height] setActive:true];
    }
    if (width != 0) {
        [[self.widthAnchor constraintEqualToConstant:width] setActive:true];
    }
    
    
}

@end

