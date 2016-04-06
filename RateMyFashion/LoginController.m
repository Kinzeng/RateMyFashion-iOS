//
//  ViewController.m
//  RateMyFashion
//
//  Created by Kai Mou on 3/28/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "LoginController.h"
#import "MZUser.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    [self.view addSubview:loginButton];
    loginButton.center = self.view.center;
    [loginButton addTarget:self action:@selector(fetchUserInfo) forControlEvents:UIControlEventTouchUpInside];
    
    
    //[self fetchUserInfo];
    
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonPressed:(id)sender {
    [self showUserInfo];
}
-(void) showUserInfo{
    NSLog(@"User %@", [[MZUser getCurrentUser]description]);
    NSLog(@"User Token %@", [[MZUser getCurrentUser]getUserToken]);
    
}
-(void)fetchUserInfo
{
    if([FBSDKAccessToken currentAccessToken]){

        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, email"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 if([result isKindOfClass:[NSDictionary class]]){
                     NSDictionary *jsonDict = (NSDictionary * )result;
                     MZUser * user = [[MZUser alloc] initWithJSON:jsonDict andAccessToken:[[FBSDKAccessToken currentAccessToken] tokenString]];
                     [MZUser setCurrentUser:user];
                     
                     
                 }
             }
             else{
                 NSLog(@"There was an error %@", error);
             }
            }];
    }
    
    
}

@end
