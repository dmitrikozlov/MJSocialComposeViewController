MJSocialComposeViewController
=============================

In iOS 5.0 Apple introduced an interface to support Twitter. iOS 6.0 replaced the interface with a new one
that allowed posting to three social networks: Twitter, Facebook and SinaWeibo.
The new interface is very similar to the old one, still they are different and applications
targeting both 5 and 6 versions have to program interactions with social networks twice.

MJSocialComposeViewController class solves this problem in an elegant way. It uses Objective C powerful
message forwarding mechanism and implements a proxy class exposing SLComposeViewController interface
to a caller. That allows to program to iOS 6.0 SDK interface while targeting earlier runtime versions of iOS.

MJSocialComposeViewController class provides an illustration of a proxy class implementation
in Objective C language and may serve as a tutorial. Message forwarding is not documented very
well by Apple. This small project may be helpful in filling in this gap.

MJSocialComposeViewController doesn't add functionality. It uses SLComposeViewController in iOS 6 and
falls back to TWTweetComposeViewController on iOS 5. It doesn't provide Facebook or SinaWeibo integration
for iOS 5.

MJSocialComposeViewController is not intrusive when there is no need for that. If you compile you project
for iOS version 6.0 and above then MJSocialComposeViewController will cease to exist (literally). You project
will use iOS 6.0 native SLComposeViewController class. You won't need to change anything in your code to drop
support of older iOS versions.

How to use
==========

Add files from the folder MJSocialComposer to your project.
Add Social.framework and Twitter.framework in to the project and mark them as Optional.
Set Deployment Target to 5.0. You may set it to a smaller number, but you won't get any functionality from
MJSocialComposeViewController class then. Be warned: lower than 5.0 versions haven't been tested, you are
on your own.
Import header "MJSocialComposeViewController.h" header in your source and start coding.

See implementation of SocialComposer.xcodeproj as an example, namely MJViewController class.

A glitch
========

Facebook implementation in iOS 6.0 (that is SLComposeViewController class) doesn't like proxy. A call to

[aViewController presentViewController:proxyComposer animated:NO completion:nil];

doesn't work with Facebook ('proxyComposer' is a pointer to MJSocialComposeViewController object).
The call works correctly with Twitter or SinaWeibo services as well as with a plain UIViewController object
(if proxyComposer object is a proxy of a UIViewController object).

A workaround is to pass an actual object:
[aViewController presentViewController:proxyComposer.actualController animated:NO completion:nil];

References
==========
http://www.mikeash.com/pyblog/friday-qa-2009-03-27-objective-c-message-forwarding.html
