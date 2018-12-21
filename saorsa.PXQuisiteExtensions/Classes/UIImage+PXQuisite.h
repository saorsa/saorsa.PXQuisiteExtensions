/////////////////////////////////////////////////////////////////////////////////
//
//  UIImage+PXQuisite.h
//  Pods
//
//  Created by Dragolov,Atanas on 25.03.15.
//
/////////////////////////////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>

@interface UIImage (PXQuisite)

/**
    Ease-of-use method.
    Applies a lightened blur.
 */
- (UIImage *)applyLightEffect;

/**
    Ease-of-use method.
    Applies a extra-lightened blur.
 */
- (UIImage *)applyExtraLightEffect;

/**
    Ease-of-use method.
    Applies a darkened blur.
 */
- (UIImage *)applyDarkEffect;

/**
    Ease-of-use method.
    Applies blur with the specified color.
 */
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

/**
    Applies a blur effect to the image with the specified arguments
 
    @param blurRadius Defines the size of blurring
 
    @param tintColor Defines the tinting clouring of the blurred result
 
    @param saturationDeltaFactor When applying saturation - the delta factor for the algorythm
 
    @param maskImage The underlying mask image to be used.
 */
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end
