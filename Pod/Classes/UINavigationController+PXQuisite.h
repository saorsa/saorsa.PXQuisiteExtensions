/////////////////////////////////////////////////////////////////////////////////
//
//  UINavigationController+PXQuisite.h
//  Pods
//
//  Created by Dragolov,Atanas on 25.03.15.
//
/////////////////////////////////////////////////////////////////////////////////
#import <UIKit/UIKit.h>

typedef enum {
    
    UINavigationRotationLeftToRight = 0,
    
    UINavigationRotationRightToLeft,

} UINavigationControllerRotationDirection;

@interface UINavigationController (PXQuisite)

- (void)pushViewController:(UIViewController*)viewController useRotation:(BOOL)useRotation;

- (void)popViewControllerUsingRotation:(BOOL)useRotation;

@end