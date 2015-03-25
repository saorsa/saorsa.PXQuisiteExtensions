/////////////////////////////////////////////////////////////////////////
//
//  UIView+PXQuisite.h
//  Pods
//
//  Created by Dragolov,Atanas on 19.03.15.
//
/////////////////////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>

#define UIViewAutoresizingAll \
    UIViewAutoresizingFlexibleLeftMargin | \
    UIViewAutoresizingFlexibleWidth | \
    UIViewAutoresizingFlexibleRightMargin | \
    UIViewAutoresizingFlexibleTopMargin | \
    UIViewAutoresizingFlexibleHeight | \
    UIViewAutoresizingFlexibleBottomMargin

@interface UIView (PXQuisite)

/**
    Applies an auto-resizing mask for the view that fits all edges
 
    @seealso UIViewAutoresizingAll
 */
- (void)applyAutoresizeAll;

/**
    Grabs the contents of the view and provides an UIImage for them.
 
    @param reductionFactor Controls the reduction factor for the image.
 */
- (UIImage *)takeScreenshot:(CGFloat)reductionFactor;

@end
