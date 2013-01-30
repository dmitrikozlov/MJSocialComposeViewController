//
//  MJViewController.m
//  SocialComposer
//
//  Created by Dmitri Kozlov on 24/01/13.
//  Copyright (c) 2013 Dmitri Kozlov. All rights reserved.
//

#import "MJViewController.h"
#import "MJSocialComposeViewController.h"
#import "OSVersion.h"

@interface MJViewController ()
-(void)checkStatus;
-(void)loginToService:(NSString*)serviceId;
-(void)postToService:(NSString*)serviceId;
@end


@implementation MJViewController

typedef enum
{
    SNone,
    SNotHere,
    SNotSignedin,
    SOk,
} ServiceState;

void setButtonState(UIButton *btn, NSString *const service, ServiceState state)
{
    btn.enabled = state == SNotSignedin || state == SOk;
    btn.alpha = btn.enabled ? 1.0f : 0.5f;
    NSString *title = @"none";
    switch (state)
    {
        default:
        case SNone:
            title = [NSString stringWithFormat:@"%@, error", service];
            break;
        case SNotHere:
            title = [NSString stringWithFormat:@"%@ unavailable", service];
            break;
        case SNotSignedin:
            title = [NSString stringWithFormat:@"Login to %@", service];
            break;
        case SOk:
            title = [NSString stringWithFormat:@"Post to %@", service];
            break;
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self checkStatus];
    
    self.osVersionLabel.text = [NSString stringWithFormat:@"%f", kCFCoreFoundationVersionNumber];
}

-(void)checkStatus
{
    ServiceState state = SNone;
    
    if (!atOS5())
    {
        state = SNotHere;
        setButtonState(self.tweetButton, @"Twitter", state);
        setButtonState(self.facebookButton, @"Facebook", state);
        setButtonState(self.weiboButton, @"Weibo", state);
    }
    else  if (!atOS6())
    {
        state = [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter] ? SOk : SNotSignedin;
        setButtonState(self.tweetButton, @"Twitter", state);
        state = SNotHere;
        setButtonState(self.facebookButton, @"Facebook", state);
        setButtonState(self.weiboButton, @"Weibo", state);
    }
    else
    {
        SLComposeViewController *ctrl;
        ctrl = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        if (!ctrl)
            state = SNotHere;
        else
            state = [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter] ? SOk : SNotSignedin;
        setButtonState(self.tweetButton, @"Twitter", state);
        
        ctrl = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        if (!ctrl)
            state = SNotHere;
        else
            state = [SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook] ? SOk : SNotSignedin;
        setButtonState(self.facebookButton, @"Facebook", state);

        ctrl = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        if (!ctrl)
            state = SNotHere;
        else
            state = [SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo] ? SOk : SNotSignedin;
        setButtonState(self.weiboButton, @"Weibo", state);
    }

}

-(void)loginToService:(NSString*)serviceId
{
    SLComposeViewController *ctrl = [SLComposeViewController composeViewControllerForServiceType:serviceId];
    NSLog(@"Login to service of type %@", ctrl.serviceType);
    
    if (!ctrl)
    {
        NSLog(@"Can not use service %@", serviceId);
        if ([serviceId isEqualToString:SLServiceTypeSinaWeibo])
            NSLog(@"Do you have China keyboard setup?");
        return;
    }
    
    [[(id)ctrl view] setHidden:YES];
    
    ctrl.completionHandler = ^(SLComposeViewControllerResult result)
    {
        if (result == SLComposeViewControllerResultCancelled)
            [self dismissModalViewControllerAnimated:YES];
    };
    
    // The idea is to use the proxy as if it was a real object, the following should be alright
    //[self presentModalViewController:(id)ctrl animated:YES];
    //[self presentViewController:ctrl animated:YES completion:^(void){}];
    // but Facebook interface doesn't like it, pass real object
    [self presentViewController:ctrl.controller animated:NO completion:^(void){}];
    
    //hide the keyboard
    [[(UIViewController*)ctrl view] endEditing:YES];
}

-(void)postToService:(NSString*)serviceId
{
    SLComposeViewController *ctrl = [SLComposeViewController composeViewControllerForServiceType:serviceId];

    if (!ctrl)
    {
        NSLog(@"Can not use service %@", serviceId);
        if ([serviceId isEqualToString:SLServiceTypeSinaWeibo])
            NSLog(@"Do you have China keyboard setup?");
        return;
    }
    
    // Set the initial tweet text. See the framework for additional properties that can be set.
    [ctrl setInitialText:@"Hello. This is a post."];
    
    // Create the completion handler block.
    ctrl.completionHandler = ^(SLComposeViewControllerResult result)
    {
        NSString *output = @"";
        switch (result)
        {
             case SLComposeViewControllerResultCancelled:
                 output = @"Post cancelled.";
                 break;
             case SLComposeViewControllerResultDone:
                 output = @"Post done.";
                 break;
             default:
                 break;
         }
         
         [self performSelectorOnMainThread:@selector(displayPostResult:) withObject:output waitUntilDone:NO];
         
         // Dismiss the tweet composition view controller.
         [self dismissModalViewControllerAnimated:YES];
     };
    
    BOOL res;
    res = [ctrl addImage:[UIImage imageNamed:@"lime-cat.png"]];
    NSLog(@"add Image result %@", res ? @"OK" : @"Failed");
    res = [ctrl addURL:[NSURL URLWithString:@"http://example.com"]];
    NSLog(@"add URL result %@", res ? @"OK" : @"Failed");
    
    // The idea is to use the proxy as if it was a real object and the following call
    // should be alright. However Facebook service doesn't like it, so we pass the real object
    [self presentViewController:ctrl.controller animated:YES completion:^(void){}];
    //[self presentModalViewController:(id)ctrl animated:YES];
}

- (IBAction)sendToTwitter:(id)sender
{
    NSString *serviceId = SLServiceTypeTwitter;
    if ([SLComposeViewController isAvailableForServiceType:serviceId])
        [self postToService:serviceId];
    else
        [self loginToService:serviceId];
        
}

- (IBAction)sendToFacebook:(id)sender
{
    NSString *serviceId = SLServiceTypeFacebook;
    if ([SLComposeViewController isAvailableForServiceType:serviceId])
        [self postToService:serviceId];
    else
        [self loginToService:serviceId];
}

- (IBAction)sendToWeibo:(id)sender
{
    NSString *serviceId = SLServiceTypeSinaWeibo;
    if ([SLComposeViewController isAvailableForServiceType:serviceId])
        [self postToService:serviceId];
    else
        [self loginToService:serviceId];    
}

- (void)displayPostResult:(NSString *)text
{
    self.postResultLabel.text = text;
}

@end
