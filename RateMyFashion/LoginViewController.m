//
//  ViewController.m
//  RateMyFashion
//
//  Created by Kai Mou on 3/28/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "TestViewController.h"
#import "SwipeViewController.h"
#import "LoginViewController.h"
#import "MZUser.h"
#import "MZPhoto.h"
#import "MZApi.h"
#import "Constants.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize navController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginButton = [[FBSDKLoginButton alloc] init];
    self.loginButton.center = self.view.center;
    self.loginButton.delegate = self;
    [self.view addSubview: self.loginButton];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    //check if the user is already logged in
    if ([FBSDKAccessToken currentAccessToken])
        [self segueToSwipe];
}
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    [self showUserInfo];
}

//login delegate method, called when user returns from the login dialog
- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error {
    [self fetchUserInfoWithCompletionHandler:^{
        NSLog(@"Logged in");
        [self showUserInfo];
        [self segueToSwipe];
    }];
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    [MZUser clearCurrentUser];
    
    NSLog(@"Logged out");
}

-(void) showUserInfo {
    //Test methods for API endpoints.
    NSLog(@"User %@", [[MZUser getCurrentUser] description]);
    NSLog(@"User Token %@", [[MZUser getCurrentUser] getUserToken]);
}

//- (void)segueToTest {
//    TestViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL]instantiateViewControllerWithIdentifier:@"test"];
//    [self presentViewController:controller animated:YES completion:nil];
//}

- (void)segueToSwipe {
    SwipeViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL]instantiateViewControllerWithIdentifier:@"swipe"];
    navController = [[UINavigationController alloc]initWithRootViewController:controller];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)fetchUserInfoWithCompletionHandler:(void (^)(void))segue {
    if([FBSDKAccessToken currentAccessToken]){
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                           parameters:@{@"fields": @"id, name, link, first_name, last_name, email"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 if([result isKindOfClass:[NSDictionary class]]) {
                     NSDictionary *jsonDict = (NSDictionary * )result;
                     MZUser *user = [[MZUser alloc] initWithJSON:jsonDict andAccessToken:[[FBSDKAccessToken currentAccessToken] tokenString]];
                     [MZUser setCurrentUser:user];
                     //segue();
                 }
             }
             else {
                 NSLog(@"There was an error %@", error);
             }
         }];
    }
}

@end
