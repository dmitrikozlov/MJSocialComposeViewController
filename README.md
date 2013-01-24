MJSocialComposeViewController
=============================

MJSocialComposeViewController class allows to use iOS 6.0 SLComposeViewController interface in iOS 5.0.

MJSocialComposeViewController is useful because it allows to use social API provided by iOS 6.0
in applications which may run on older iOS versions: 5.0 and other below 6.0.
On versions below 6.0 the functionality degrades to supporting Twitter network only.

MJSocialComposeViewController is not intrusive if there is no need for it. If you compile you project for
iOS version 6.0 and above only then MJSocialComposeViewController ceases to exist. You project uses iOS 6.0
stock class SLComposeViewController. That means you do not need to do anything special when you drop support
of older iOS versions in a future.

MJSocialComposeViewController class is also interesting as an illustration of a proxy class implementation
in Objective C and may be used as a tutorial.

How to use
==========

Add files from the folder MJSocialComposer to your project.
Add Social.framework and Twitter.framework in the project and mark them as Optional.
Set Deployment Target to 5.0. You may set it to a smaller number, but you want get any functionality from
MJSocialComposeViewController class (lower than 5.0 versions haven't been tested).
Import header "MJSocialComposeViewController.h" and maybe "OSVersion.h".
Start coding.

See implementation of SocialComposer.xcodeproj as an example, namely MJViewController class.

