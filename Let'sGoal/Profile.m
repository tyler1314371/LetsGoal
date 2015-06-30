//
//  ViewController.m
//  Let'sGoal
//
//  Created by LTJ on 2015-06-24.
//  Copyright (c) 2015 LTJ. All rights reserved.
//

#import "Profile.h"


@interface Profile()
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.5]
@property (weak, nonatomic) IBOutlet  UIButton *Profile_Button;
@property (weak, nonatomic) IBOutlet UIImageView *Profile_Pic;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (weak, nonatomic) IBOutlet  UIButton *Setting_Button;
@property (strong, nonatomic) IBOutlet UIImageView *Setting_Pic;
@property (weak, nonatomic) IBOutlet  UIButton *Donation_Button;
@property (strong, nonatomic) IBOutlet UIImageView *Donation_Pic;

@end

@implementation Profile

- (void)viewDidLoad {
    [super viewDidLoad];
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.5]
    //[self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x067AB7)];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setAlpha:0.5];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
//    [[UITabBar appearance] setTintColor:self.view.tintColor];
//    UILabel* lbNavTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,30,280,50)];
//    lbNavTitle.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
//    lbNavTitle.textAlignment = NSTextAlignmentLeft;
//    lbNavTitle.textColor = [UIColor whiteColor];
//    lbNavTitle.text = NSLocalizedString(@"Let's Goal",@"");
//    self.navigationItem.titleView = lbNavTitle;
    
    
    
    UIColor* grey90 = [UIColor colorWithWhite: 0.90 alpha:1];
    self.view.backgroundColor = grey90;
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];

   
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 _Name.text = [result objectForKey:@"name"];
             }
         }];
        
        
        
        NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/me/picture?type=large&return_ssl_resources=1&access_token=%@", [FBSDKAccessToken currentAccessToken].tokenString]];
        NSData *imageData = [NSData dataWithContentsOfURL:pictureURL];
        UIImage *fbImage = [UIImage imageWithData:imageData];
        _Profile_Pic.image = fbImage;
        _Profile_Pic.layer.cornerRadius=_Profile_Pic.frame.size.width/2;
        _Profile_Pic.clipsToBounds=YES;
        _Profile_Pic.layer.borderWidth=1.0f;
        _Profile_Pic.layer.borderColor=[[UIColor whiteColor] CGColor];
    }
    
    
    
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
[[UITabBar appearance] setTintColor:self.view.tintColor];
}


- (IBAction)SettingClicked:(id)sender {
    
    UIColor* grey65 = [UIColor colorWithWhite: 0.65 alpha:1];
    _Setting_Button.backgroundColor = grey65;
    
}
- (IBAction)SettingReleased:(id)sender {
    
    
    _Setting_Button.backgroundColor = [UIColor whiteColor];
    
    
}


- (IBAction)ProfileClicked:(id)sender {
    
    UIColor* grey65 = [UIColor colorWithWhite: 0.65 alpha:1];
    _Profile_Button.backgroundColor = grey65;
    
}

- (IBAction)ProfileReleased:(id)sender {
    
    
    _Profile_Button.backgroundColor = [UIColor whiteColor];
    
    
}


- (IBAction)DonationClicked:(id)sender {
    
    UIColor* grey65 = [UIColor colorWithWhite: 0.65 alpha:1];
    _Donation_Button.backgroundColor = grey65;
    
}

- (IBAction)DonationReleased:(id)sender {
    
    
    _Donation_Button.backgroundColor = [UIColor whiteColor];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
