//
//  MJAppDelegate.h
//  SocialComposer
//
//  Created by Dmitri Kozlov on 24/01/13.
//  Copyright (c) 2013 Dmitri Kozlov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MJViewController;

@interface MJAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MJViewController *viewController;

@end
