//
//  MJViewController.h
//  SocialComposer
//
//  Created by Dmitri Kozlov on 24/01/13.
//  Copyright (c) 2013 Dmitri Kozlov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIButton *tweetButton;
@property (retain, nonatomic) IBOutlet UIButton *facebookButton;
@property (retain, nonatomic) IBOutlet UIButton *weiboButton;
@property (retain, nonatomic) IBOutlet UILabel *osVersionLabel;
@property (retain, nonatomic) IBOutlet UILabel *postResultLabel;

- (IBAction)sendToTwitter:(id)sender;
- (IBAction)sendToFacebook:(id)sender;
- (IBAction)sendToWeibo:(id)sender;
- (void)displayPostResult:(NSString *)text;

@end
