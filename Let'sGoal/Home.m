//
//  ViewController.m
//  Let'sGoal
//
//  Created by LTJ on 2015-06-24.
//  Copyright (c) 2015 LTJ. All rights reserved.
//

#import "Home.h"


@interface UITabBarController ()


@end

@implementation Home

- (void)viewDidLoad {
    [super viewDidLoad];
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.5]
    //[self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x067AB7)];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setAlpha:0.5];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [[UITabBar appearance] setTintColor:self.view.tintColor];

   
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
