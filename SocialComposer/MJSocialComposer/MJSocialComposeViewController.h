//
//  MJSocialComposeViewController.h
//
//  Created by Dmitri Kozlov on 22/01/13.
//  Copyright (c) 2013 Dmitri Kozlov. All rights reserved.
//  Copyright (c) 2013 MetJungle Pty Ltd. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

// It doesn't make sense to compile these againts older SDKs
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_6_0
#error "Requires iOS SDK 6.0 or above"
#endif

#import <UIKit/UIKit.h>
#import <Social/Social.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0

// Social Proxy class
@interface MJSocialComposeViewController : NSProxy
+ (BOOL)isAvailableForServiceType:(NSString *)serviceType;
+ (MJSocialComposeViewController *)composeViewControllerForServiceType:(NSString *)serviceType;
@property(nonatomic, readonly) NSString *serviceType;
@property (nonatomic, copy) SLComposeViewControllerCompletionHandler completionHandler;

//Facebook service doesn't like proxy, so I have to expose real controller...
@property(nonatomic, retain) id controller;
@end

// Category declaration to tell the compiler that social related functions
// are implemented somewhere else. We list function declared by SLComposeViewController only
// If you need to use interface of UIViewController then you may want to typecast the object to (id) type.
@interface MJSocialComposeViewController (Social)
- (BOOL)setInitialText:(NSString *)text;
- (BOOL)addImage:(UIImage *)image;
- (BOOL)removeAllImages;
- (BOOL)addURL:(NSURL *)url;
- (BOOL)removeAllURLs;
@end

// Use SLComposeViewController in your app code; do not use MJSocialComposeViewController
#define SLComposeViewController MJSocialComposeViewController

#endif //__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0

