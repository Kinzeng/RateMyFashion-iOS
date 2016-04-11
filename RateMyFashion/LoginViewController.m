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
        controller.user = self.user;
        [self presentViewController:controller animated:YES completion:nil];
    }
    */
    
    self.loginButton = [[FBSDKLoginButton alloc] init];
    self.loginButton.center = self.view.center;
    self.loginButton.delegate = self;
    [self.view addSubview: self.loginButton];
    
    // Do any additional setup after loading the view, typically from a nib.
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
    if ([FBSDKAccessToken currentAccessToken]) {
        [self fetchUserInfoWithCompletionHandler:^() {
            TestViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL]instantiateViewControllerWithIdentifier:@"test"];
            controller.user = self.user;
            [self presentViewController:controller animated:YES completion:nil];
        }];
        NSLog(@"Logged in");
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    NSLog(@"Logged out");
}

-(void) showUserInfo {
    NSLog(@"User %@", [_user description]);
    NSLog(@"User Token %@", [_user userId]);
}


-(void)fetchUserInfoWithCompletionHandler:(void (^)(void))segue {
    if([FBSDKAccessToken currentAccessToken]){

        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" 
                                    parameters:@{@"fields": @"id, name, link, first_name, last_name, email"}]
                                    startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                                        if (!error) {
                                            if([result isKindOfClass:[NSDictionary class]]) {
                                                NSDictionary *jsonDict = (NSDictionary *)result;
                                                self.user = [[MZUser alloc] initWithJSON:jsonDict andAccessToken:[[FBSDKAccessToken currentAccessToken] tokenString]];
                                                segue();
                                            }
                                        }
                                        else
                                            NSLog(@"There was an error %@", error);
                                        
        }];
    }
}

@end
