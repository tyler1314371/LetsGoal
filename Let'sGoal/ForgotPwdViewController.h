//
//  ViewController.h
//  Let'sGoal
//
//  Created by LTJ on 2015-06-24.
//  Copyright (c) 2015 LTJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Bolts/Bolts.h>
#import <QuartzCore/QuartzCore.h>
#import <Security/Security.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "KVNProgress.h"
#import "KVNProgressConfiguration.h"
@interface ForgotPwdViewController:UIViewController <UITextFieldDelegate, UITextViewDelegate, MFMailComposeViewControllerDelegate>

@end

