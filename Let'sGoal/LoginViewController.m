//
//  ViewController.m
//  Let'sGoal
//
//  Created by LTJ on 2015-06-24.
//  Copyright (c) 2015 LTJ. All rights reserved.
//

#import "LoginViewController.h"
#import "Home.h"




@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *Submit;
@property (weak, nonatomic) IBOutlet UIView *FBLogin;
@property (strong, nonatomic) IBOutlet UITextField *PWD;
@property (strong, nonatomic) IBOutlet UITextField *USN;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@end

@implementation LoginViewController


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.textAlignment = NSTextAlignmentCenter;
    textField.placeholder = nil;
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 0) {
        textField.placeholder = @"UserName";
    }else
    {
        textField.placeholder = @"Password";
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    //set background img
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"BKG2.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    
    //FBlogin button
    [FBSDKLoginButton alloc];
    //loginButton.readPermissions = @[@"user_about_me", @"user_birthday"];
    //loginButton.accessibilityFrame = CGRectMake(40,430,200,10);
    //loginButton.center = self.view.center;
    _loginButton.delegate = self;
    _loginButton.layer.cornerRadius = 15;
    //loginButton.frame = CGRectMake(97,370,190,30);
    //[self.view addSubview:loginButton];
    
    
    
    
    //set up textfield rounded corner with quarz
    self.PWD.delegate = self;
    self.USN.delegate = self;
    _PWD.textAlignment = NSTextAlignmentCenter;
    _PWD.layer.cornerRadius = 15;
    _PWD.clipsToBounds = YES;
    _USN.layer.cornerRadius = 15;
    _USN.clipsToBounds = YES;
    _USN.textAlignment = NSTextAlignmentCenter;
    //set up loginbutton color
    #define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.5]
    _Submit.backgroundColor = UIColorFromRGB(0x66B2FF);
    _Submit.layer.cornerRadius = 15;
    _Submit.clipsToBounds = YES;
    
    
    //added keyboard dismiss
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
}

-(void)viewDidAppear:(BOOL)animated{
    if ([FBSDKAccessToken currentAccessToken]) {
        [self performSegueWithIdentifier:@"SuccessLogin" sender:self];
    }
}


-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    //TODO - bring grab fb profile data here
    
    [self performSegueWithIdentifier:@"SuccessLogin" sender:self];
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{    //logout

}



- (IBAction)LoginClicked:(id)sender {
    
    [KVNProgress showWithStatus:@"Authenticating"];
    
    //string for the URL request
    NSString *myUrlString = @"http://demo.mysamplecode.com/JQuery/CountryInfo";
    NSString *body =  [NSString stringWithFormat:@"countryCode=%@", _PWD.text];
    NSURL *myUrl = [NSURL URLWithString:myUrlString];
    
    //create a mutable HTTP request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:myUrl];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    //allocate a new operation queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         if ([data length] >0 && error == nil){
                              dispatch_async(dispatch_get_main_queue(), ^{
                                 
                                  
                                  NSString *myData = [[NSString alloc] initWithData:data
                                                                           encoding:NSUTF8StringEncoding];
                                  NSLog(@"JSON data = %@", myData);
                                  NSError *error = nil;
                                  
                                  //parsing the JSON response
                                  id jsonObject = [NSJSONSerialization
                                                   JSONObjectWithData:data
                                                   options:NSJSONReadingAllowFragments
                                                   error:&error];
                                  if (jsonObject != nil && error == nil){
                                      
                                      if([[[jsonObject objectForKey:@"countryInfo"] objectForKey:@"code"] isEqualToString:@"USA"])
                                      {
                                          [self performSegueWithIdentifier:@"SuccessLogin" sender:sender];
                                          
                                      }else
                                      {
                                          [KVNProgress showErrorWithStatus:@"Wrong Password"];
                                      }
                                      
                                  }
                                  
                                  
                                  
                                  
                                  
                              });
            
         }
         else if ([data length] == 0 && error == nil){
             NSLog(@"Empty Response, not sure why?");
         }
         else if (error != nil){
             NSLog(@"Not again, what is the error = %@", error);
         }
     }];
    

    

}







-(void)dismissKeyboard {
    [_USN resignFirstResponder];
    [_PWD resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
