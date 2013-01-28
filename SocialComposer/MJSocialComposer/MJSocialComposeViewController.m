//
//  MJSocialComposeViewController.m
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

#import "MJSocialComposeViewController.h"
#import "OSVersion.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0

#import <Twitter/Twitter.h>
//#import <Accounts/Accounts.h>

#ifdef SLComposeViewController
#undef SLComposeViewController
#endif

// To allow building with or without ARC
#ifndef __has_feature
// not LLVM Compiler
#define __has_feature(x) 0
#endif

// Tracing
#if !defined DEBUG_FORWARD || DEBUG_FORWARD == 0

#define MJLOGFN(s, ...)
#define MJLOG(s, ...)

#else

#define MJLOGFN(s, ...) \
NSLog(@"%s : %@",__FUNCTION__,[NSString stringWithFormat:(s), ##__VA_ARGS__])

#define MJLOG(s, ...) \
NSLog(@"%@",[NSString stringWithFormat:(s), ##__VA_ARGS__])

#endif

// Have to define these here to run under iOS 5.0 otherwise.
NSString *const SLServiceTypeTwitter = @"com.apple.social.twitter";
NSString *const SLServiceTypeFacebook = @"com.apple.social.facebook";
NSString *const SLServiceTypeSinaWeibo = @"com.apple.social.sinaweibo";

// Private interface
@interface MJSocialComposeViewController ()
- (id)initForServiceType:(NSString *)serviceType;
@end

//
@implementation MJSocialComposeViewController

// Tell the compiler not to implement this property
@dynamic completionHandler;

#pragma mark - initialization
//
+ (MJSocialComposeViewController *)composeViewControllerForServiceType:(NSString *)serviceType
{
    MJSocialComposeViewController *ctrl = [[MJSocialComposeViewController alloc] initForServiceType:serviceType];
    
#   if !__has_feature(objc_arc)
    [ctrl autorelease];
#   endif
    return ctrl;
}

//
- (id)initForServiceType:(NSString *)serviceType
{
    if (!self)
        return nil;

    if (atOS6())
    {
        self.controller = [SLComposeViewController composeViewControllerForServiceType:serviceType];
    }
    else if (atOS5() && [serviceType isEqualToString:SLServiceTypeTwitter])
    {
        self.controller = [[TWTweetComposeViewController alloc] init];
#       if !__has_feature(objc_arc)
        [self.controller autorelease];
#       endif
    }
    
    if (!self.controller)
    {
#       if !__has_feature(objc_arc)
        [self release];
#       endif
        self  = nil;
    }

    return self;
}

//
- (void)dealloc
{
#   if !__has_feature(objc_arc)
    [_controller release];
#   endif
    [super dealloc];
}

#pragma mark - Not forwarded
//
+ (BOOL)isAvailableForServiceType:(NSString *)serviceType
{
    if (atOS6())
    {
        return [SLComposeViewController isAvailableForServiceType:serviceType];
    }
    else if (atOS5())
    {
        if (![serviceType isEqualToString:SLServiceTypeTwitter])
            return NO;
        return [TWTweetComposeViewController canSendTweet];
    }
    return NO;
}

//
- (NSString *)serviceType
{
    if (atOS6())
        return [self.controller serviceType];
    else if (atOS5() && self.controller)
        return SLServiceTypeTwitter;
    return nil;
}

#pragma mark - Proxy implementation

// Class methods fast forward invocation.
+ (id)forwardingTargetForSelector:(SEL)sel
{
    MJLOG(@"+forwardingTargetForSelector %@", NSStringFromSelector(sel));
    if (atOS6())
        return [SLComposeViewController class];
    else if (atOS5())
        return [TWTweetComposeViewController class];
    return nil;

}

// Instance methods fast forward invocation. See NSObject reference.
- (id)forwardingTargetForSelector:(SEL)sel
{
    MJLOG(@"-forwardingTargetForSelector %@", NSStringFromSelector(sel));
    return self.controller;
}

// Instance methods forward invocation. See NSObject reference.
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    MJLOG(@"-forwardInvocation %@", NSStringFromSelector([anInvocation selector]));
    if ([self.controller respondsToSelector:[anInvocation selector]])
        [anInvocation invokeWithTarget:self.controller];
    else
        [super forwardInvocation:anInvocation];
}

// Required for forward invocation. See NSObject reference.
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    MJLOG(@"-methodSignatureForSelector: %@", NSStringFromSelector(sel));
    NSMethodSignature *sig = [self.controller methodSignatureForSelector:sel];
    return sig;
}

// Class methods forward invocation.
+ (void)forwardInvocation:(NSInvocation *)anInvocation
{
    MJLOG(@"+forwardInvocation %@", NSStringFromSelector([anInvocation selector]));
    if (atOS6())
    {
        if ([SLComposeViewController respondsToSelector:[anInvocation selector]])
        {
            [anInvocation invokeWithTarget:[SLComposeViewController class]];
            return;
        }
    }
    else if (atOS5())
    {
        if ([TWTweetComposeViewController respondsToSelector:[anInvocation selector]])
        {
            [anInvocation invokeWithTarget:[TWTweetComposeViewController class]];
            return;
        }
    }

    [super forwardInvocation:anInvocation];
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    MJLOG(@"+methodSignatureForSelector %@", NSStringFromSelector(sel));
    NSMethodSignature *sig = nil;

    if (atOS6())
    {
        sig = [SLComposeViewController methodSignatureForSelector:sel];
    }
    else if (atOS5())
    {
        sig = [TWTweetComposeViewController methodSignatureForSelector:sel];
    }
    
    return sig;
}

- (BOOL)respondsToSelector:(SEL)sel
{
    MJLOG(@"-respondsToSelector %@", NSStringFromSelector(sel));
    if ([self.controller respondsToSelector:sel])
        return YES;
    return NO;
}

- (BOOL)isKindOfClass:(Class)aClass
{
    MJLOG(@"-isKindOfClass %@", NSStringFromClass(aClass));
    return [self.controller isKindOfClass:aClass];
}


- (BOOL)isEqual:(id)object
{
    return [super isEqual:object];
}

- (NSUInteger)hash
{
    return [super hash];
}

- (Class)superclass
{
    return [super superclass];
}
- (Class)class;
{
    return [super class];
}

- (id)self;
{
    return [super self];
}

- (id)performSelector:(SEL)aSelector
{
    return [super performSelector:aSelector];
}

- (id)performSelector:(SEL)aSelector withObject:(id)object
{
    return [super performSelector:aSelector withObject:object];    
}

- (id)performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2
{
    return [super performSelector:aSelector withObject:object1 withObject:object2];
}

- (BOOL)isProxy
{
    return [super isProxy];
}


- (BOOL)isMemberOfClass:(Class)aClass
{
    return [super isMemberOfClass:aClass];
}
- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    return [super conformsToProtocol:aProtocol];
}

@end

#endif //__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
