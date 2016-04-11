//
//  ViewController.h
//  RateMyFashion
//
//  Created by Kai Mou on 3/28/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "MZUser.h"

@interface LoginViewController : UIViewController <FBSDKLoginButtonDelegate>

@property (strong, nonatomic) FBSDKLoginButton *loginButton;
@property (strong, nonatomic) MZUser *user;

@end

