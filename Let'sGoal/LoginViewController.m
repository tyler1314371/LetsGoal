//
//  ViewController.m
//  Let'sGoal
//
//  Created by Chun-Chieh Niu on 2015-06-24.
//  Copyright (c) 2015 Chun-Chieh Niu. All rights reserved.
//

#import "LoginViewController.h"
#import "Home.h"



@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *Submit;
@property (weak, nonatomic) IBOutlet UITextField *PWD;
@property (weak, nonatomic) IBOutlet UITextField *USN;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.readPermissions = @[@"public_profile", @"email"];
    //loginButton.accessibilityFrame = CGRectMake(40,430,200,10);
    loginButton.center = self.view.center;
    loginButton.delegate = self;
    [self.view addSubview:loginButton];
    
    
    
}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    //transition && grabdata?
    [self performSegueWithIdentifier:@"SuccessLogin" sender:self];
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    //logout
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



@end
