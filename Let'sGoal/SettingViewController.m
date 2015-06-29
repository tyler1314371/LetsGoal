//
//  ViewController.m
//  Let'sGoal
//
//  Created by LTJ on 2015-06-24.
//  Copyright (c) 2015 LTJ. All rights reserved.
//

#import "SettingViewController.h"


@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet  UIButton *Logout_Button;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.5]
    //[self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x067AB7)];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setAlpha:0.5];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    UIColor* grey90 = [UIColor colorWithWhite: 0.90 alpha:1];
    self.view.backgroundColor = grey90;
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    
    
}


- (IBAction)LogoutClicked:(id)sender {
    
    UIColor* grey65 = [UIColor colorWithWhite: 0.65 alpha:1];
    _Logout_Button.backgroundColor = grey65;
    
}

- (IBAction)LogoutReleased:(id)sender {
    
    
    _Logout_Button.backgroundColor = [UIColor whiteColor];
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    FBSDKAccessToken.currentAccessToken = nil;
    //Remove the saved password on the phone
    // Create dictionary of search parameters
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)(kSecClassInternetPassword),  kSecClass, @"dummy", kSecAttrServer, kCFBooleanTrue, kSecReturnAttributes, kCFBooleanTrue, kSecReturnData, nil];
    
    // Remove any old values from the keychain
    OSStatus err = SecItemDelete((__bridge CFDictionaryRef) dict);
    if (err) {
        //skip, user probably is using facebook
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Back
{
    [self dismissViewControllerAnimated:YES completion:nil]; // ios 6
}

@end
