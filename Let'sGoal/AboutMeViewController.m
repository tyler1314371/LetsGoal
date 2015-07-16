//
//  ViewController.m
//  Let'sGoal
//
//  Created by LTJ on 2015-06-24.
//  Copyright (c) 2015 LTJ. All rights reserved.
//

#import "AboutMeViewController.h"


@interface AboutMeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *Save;
@property (weak, nonatomic) IBOutlet UIButton *Profile_Button;
@property (weak, nonatomic) IBOutlet UIButton *Email_Button;


@end

@implementation AboutMeViewController

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
    
    _Save.layer.cornerRadius = 3;
    
    
    
}




- (IBAction)Save:(id)sender {
    
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
