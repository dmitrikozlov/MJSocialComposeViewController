MJSocialComposeViewController
=============================

MJSocialComposeViewController class allows to use SLComposeViewController interface in iOS 5.0.
MJSocialComposeViewController demonstrates a complete imlementation of a proxy class in Objectie C.

SLComposeViewController class supports posting messages on social networks Twitter, Facebook, SinaWeibo.
The class was added in iOS version 6.0 and functionally is an extension of TWTweetComposeViewController class
of IOS 5.0. But from an application perspective these are completely independant classes.

It may be desirable to take advantages of class SLComposeViewController on newer iOS but fallback
to TWTweetComposeViewController if the app is running on iOS 5.

MJSocialComposeViewController allows to use social API of SLComposeViewController provided by iOS 6.0
in applications which may be running on older iOS versions, 5.0 and above.
On versions below 6.0 the functionality degrades to supporting Twitter network only.

MJSocialComposeViewController is not intrusive when there is no need for that. If you compile you project
for iOS version 6.0 and above then MJSocialComposeViewController will cease to exist. You project will use
iOS 6.0 native SLComposeViewController class. You do not need to do anything special when you drop support
of older iOS versions in a future.

MJSocialComposeViewController class is also interesting as an illustration of a proxy class implementation
in Objective C and may serve as a tutorial.

How to use
==========

Add files from the folder MJSocialComposer to your project.
Add Social.framework and Twitter.framework in the project and mark them as Optional.
Set Deployment Target to 5.0. You may set it to a smaller number, but you want get any functionality from
MJSocialComposeViewController class (lower than 5.0 versions haven't been tested).
Import header "MJSocialComposeViewController.h" and maybe "OSVersion.h".
Start coding.

See implementation of SocialComposer.xcodeproj as an example, namely MJViewController class.

References
==========
http://www.mikeash.com/pyblog/friday-qa-2009-03-27-objective-c-message-forwarding.html
