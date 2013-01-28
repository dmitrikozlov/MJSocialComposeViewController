//
//  OSVersion.h
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

#ifndef OSVERSION_H
#define OSVERSION_H

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_2_0
#define kCFCoreFoundationVersionNumber_iPhoneOS_2_0 478.23
#endif

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_2_1
#define kCFCoreFoundationVersionNumber_iPhoneOS_2_1 478.26
#endif

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_2_2
#define kCFCoreFoundationVersionNumber_iPhoneOS_2_2 478.29
#endif

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_3_0
#define kCFCoreFoundationVersionNumber_iPhoneOS_3_0 478.47
#endif

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_3_1
#define kCFCoreFoundationVersionNumber_iPhoneOS_3_1 478.52
#endif

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_3_2
#define kCFCoreFoundationVersionNumber_iPhoneOS_3_2 478.61
#endif

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_4_0
#define kCFCoreFoundationVersionNumber_iPhoneOS_4_0 550.32
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_4_0
#define kCFCoreFoundationVersionNumber_iOS_4_0 550.32
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_4_1
#define kCFCoreFoundationVersionNumber_iOS_4_1 550.38
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_4_2
#define kCFCoreFoundationVersionNumber_iOS_4_2 550.52
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_4_3
#define kCFCoreFoundationVersionNumber_iOS_4_3 550.52
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_5_0
#define kCFCoreFoundationVersionNumber_iOS_5_0 675
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_5_1
#define kCFCoreFoundationVersionNumber_iOS_5_1 690.1
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_6_0
#define kCFCoreFoundationVersionNumber_iOS_6_0 793
#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
#define IF_IOS6_OR_GREATER(...) \
if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_6_0) \
{ \
__VA_ARGS__ \
}
#else
#define IF_IOS6_OR_GREATER(...)
#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 50000
#define IF_IOS5_OR_GREATER(...) \
if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_6_0) \
{ \
__VA_ARGS__ \
}
#else
#define IF_IOS5_OR_GREATER(...)
#endif

static inline BOOL isiPad()
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

static inline BOOL atOS6()
{
    return kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_6_0;
}

static inline BOOL atOS5()
{
    return kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_5_0;
}

#endif
