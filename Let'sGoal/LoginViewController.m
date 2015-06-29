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

    //Read username/pwd from disc, if exists, no need to even display this viewcontroller
    // Create dictionary of search parameters
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)(kSecClassInternetPassword),  kSecClass, @"dummy" , kSecAttrServer, kCFBooleanTrue, kSecReturnAttributes, kCFBooleanTrue, kSecReturnData, nil];
    
    // Look up server in the keychain
    NSDictionary* found = nil;
    CFDictionaryRef foundCF;
    OSStatus err_r = SecItemCopyMatching((__bridge CFDictionaryRef) dict, (CFTypeRef*)&foundCF);
    if (!err_r) {
        
    
    found = (__bridge NSDictionary*)(foundCF);
    
    if (found){
        
    // Found
    NSString* user = (NSString*) [found objectForKey:(__bridge id)(kSecAttrAccount)];
    NSString* pass = [[NSString alloc] initWithData:[found objectForKey:(__bridge id)(kSecValueData)] encoding:NSUTF8StringEncoding];
    _USN.text = user;
    _PWD.text = pass;
    [_Submit sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    
    }
    
    
    
    
    
    //set background img
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"BKG2.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    
    //FBlogin button
    [FBSDKLoginButton alloc];
    _loginButton.delegate = self;
    _loginButton.layer.cornerRadius = 15;
    
    
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
    [self LoginwithUsername:_USN.text Password:_PWD.text sender:sender];
   
    

}




- (void) LoginwithUsername:(NSString*)user Password:(NSString*)pass sender:(id)sender{

    //string for the URL request
    NSString *myUrlString = @"http://demo.mysamplecode.com/JQuery/CountryInfo";
    NSString *body =  [NSString stringWithFormat:@"countryCode=%@", pass];
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
                         //successful login, time to save username/pwd to disc
                         // Create dictionary of search parameters
                         NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)(kSecClassInternetPassword),  kSecClass,@"dummy" , kSecAttrServer, kCFBooleanTrue, kSecReturnAttributes, nil];
                         
                         // Remove any old values from the keychain
                         OSStatus err = SecItemDelete((__bridge CFDictionaryRef) dict);
                         
                         // Create dictionary of parameters to add
                         NSData* passwordData = [_PWD.text dataUsingEncoding:NSUTF8StringEncoding];
                         dict = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)(kSecClassInternetPassword), kSecClass, @"dummy" , kSecAttrServer, passwordData, kSecValueData, _USN.text, kSecAttrAccount, nil];
                         
                         // Try to save to keychain
                         err = SecItemAdd((__bridge CFDictionaryRef) dict, NULL);
                         
                         
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
