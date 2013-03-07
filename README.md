MJSocialComposeViewController
=============================

With iOS 5.0 Apple introduced an interface to aid posting messages to Twitter. iOS 6.0 didn't extend that
interface but rather replaced it with a new one that allows posting to three social networks: Twitter, Facebook
and SinaWeibo. The new interface is very similar to the old one, still they are different and applications
targeting both 5.0 and 6.0 and above have to program interactions with social networks twice.

MJSocialComposeViewController class solves this problem in an elegant way. It uses Objective C powerful
message forwarding mechanism and implements a proxy class exposing SLComposeViewController interface
to a caller. That allows to program to iOS 6.0 SDK interface while targeting earlier runtime versions of iOS.

MJSocialComposeViewController class is also interesting as an illustration of a proxy class implementation
in Objective C language and may serve as a tutorial. I found that message forwarding is not documented very
well. This small project may be helpful in filling in this gap.

MJSocialComposeViewController doesn't add functionality. It uses SLComposeViewController in iOS 6 and
falls back to TWTweetComposeViewController on iOS 5. It doesn't provide Facebook or SinaWeibo integration
on iOS 5.

MJSocialComposeViewController is not intrusive when there is no need for that. If you compile you project
for iOS version 6.0 and above then MJSocialComposeViewController will cease to exist (literally). You project
will use iOS 6.0 native SLComposeViewController class. You do not need to do anything special when you drop
support of older iOS versions in a future.

How to use
==========

Add files from the folder MJSocialComposer to your project.
Add Social.framework and Twitter.framework in to the project and mark them as Optional.
Set Deployment Target to 5.0. You may set it to a smaller number, but you wont get any functionality from
MJSocialComposeViewController class then. Be warned: lower than 5.0 versions haven't been tested, you are
on your own.
Import header "MJSocialComposeViewController.h" header in your source and start coding.

See implementation of SocialComposer.xcodeproj as an example, namely MJViewController class.

A glitch
========

The proxy class implementation is all good but there is one glitch. Facebook implementation in iOS 6.0
(that is SLComposeViewController class) doesn't like proxy and call to

[aViewController presentViewController:proxyComposer animated:NO completion:nil];

doesn't work. 'proxyComposer' above is a pointer to MJSocialComposeViewController object.
This works alright with Twitter or SinaWeibo services. That also works fine if proxyComposer object is a
proxy of a plain UIViewController object.

A workaround is to pass an actual object:
[aViewController presentViewController:proxyComposer.actualController animated:NO completion:nil];

References
==========
http://www.mikeash.com/pyblog/friday-qa-2009-03-27-objective-c-message-forwarding.html
