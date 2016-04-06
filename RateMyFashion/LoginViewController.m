//
//  ViewController.m
//  RateMyFashion
//
//  Created by Kai Mou on 3/28/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "TestViewController.h"
#import "LoginViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    //check if the user is already logged in
    if ([FBSDKAccessToken currentAccessToken]) {
        TestViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL]instantiateViewControllerWithIdentifier:@"test"];
        controller.text = @"Hello World!";
        [self presentViewController:controller animated:YES completion:nil];
    }
    */
    
    self.loginButton = [[FBSDKLoginButton alloc] init];
    self.loginButton.center = self.view.center;
    self.loginButton.delegate = self;
    [self.view addSubview: self.loginButton];
    //[self fetchUserInfo];
    
    // Do any additional setup after loading the view, typically from a nib.
}
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    [self fetchUserInfo];
}

//login delegate method, called when user returns from the login dialog
- (void)loginButton:(FBSDKLoginButton *)loginButton
        didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
        error:(NSError *)error {
    if ([FBSDKAccessToken currentAccessToken]) {
        NSLog(@"Logged in");
        TestViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL]instantiateViewControllerWithIdentifier:@"test"];
        controller.text = @"Hello World!";
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    NSLog(@"Logged out");
}

-(void)fetchUserInfo {
    if ([FBSDKAccessToken currentAccessToken]) {
        NSLog(@"Token is available : %@", [[FBSDKAccessToken currentAccessToken]tokenString]);
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email, birthday, bio, location, friends, hometown, friendlists"}]
                           startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                        id result,
                                                        NSError *error) {
             if (!error) {
                 NSLog(@"results:%@", result);
             }
             else {
                 NSLog(@"Error %@", error);
             }
         }];
    }
}

@end
