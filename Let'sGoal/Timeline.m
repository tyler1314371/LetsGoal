//
//  ViewController.m
//  Let'sGoal
//
//  Created by LTJ on 2015-06-24.
//  Copyright (c) 2015 LTJ. All rights reserved.
//

#import "Timeline.h"


@interface Timeline ()


@end

@implementation Timeline

- (void)viewDidLoad {
    [super viewDidLoad];
    
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.5]
    //[self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x067AB7)];
    [self.navigationController.navigationBar setTranslucent:YES];
    //[self.navigationController.navigationBar setAlpha:0.5];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [[UITabBar appearance] setTintColor:self.view.tintColor];
    UIColor* grey90 = [UIColor colorWithWhite: 0.90 alpha:1];
    self.view.backgroundColor = grey90;
//    UILabel* lbNavTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,30,280,50)];
//    lbNavTitle.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
//    lbNavTitle.textAlignment = NSTextAlignmentLeft;
//    lbNavTitle.textColor = [UIColor whiteColor];
//    lbNavTitle.text = NSLocalizedString(@"Let's Goal",@"");
//    self.navigationItem.titleView = lbNavTitle;
//    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
