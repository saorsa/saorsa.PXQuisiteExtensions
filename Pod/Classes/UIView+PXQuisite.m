/////////////////////////////////////////////////////////////////////////
//
//  UIView+PXQuisite.m
//  Pods
//
//  Created by Dragolov,Atanas on 19.03.15.
//
/////////////////////////////////////////////////////////////////////////
#import "UIView+PXQuisite.h"

@implementation UIView (PXQuisite)

- (void)applyAutoresizeAll {

    self.autoresizingMask = UIViewAutoresizingAll;
}

- (UIImage *)takeScreenshot:(CGFloat)reductionFactor {
    
    UIGraphicsBeginImageContext(CGSizeMake(self.frame.size.width/reductionFactor, self.frame.size.height/reductionFactor));
    
    [self drawViewHierarchyInRect:CGRectMake(0, 0, self.frame.size.width/reductionFactor, self.frame.size.height/reductionFactor) afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
