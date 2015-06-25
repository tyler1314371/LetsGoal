//
//  ViewController.m
//  Let'sGoal
//
//  Created by Chun-Chieh Niu on 2015-06-24.
//  Copyright (c) 2015 Chun-Chieh Niu. All rights reserved.
//

#import "Home.h"


@interface UITabBarController ()


@end

@implementation Home

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    //loginButton.accessibilityFrame = CGRectMake(40,430,200,10);
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    
    
   
}

-(void)viewDidAppear:(BOOL)animated
{
    [KVNProgress dismiss];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
