//
//  SwipeViewController.m
//  RateMyFashion
//
//  Created by Kevin on 4/7/16.
//  Copyright © 2016 MouZhang. All rights reserved.
///Users/kaimou/Desktop/RateMyFashion-iOS/RateMyFashion/TestViewController.h

#import "SwipeViewController.h"
#import "DraggableViewBackground.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "CustomPhotoCaptionView.h"

@implementation SwipeViewController

@synthesize MWPhotoList;
@synthesize sidebarButton;

- (IBAction)openCamera:(id)sender {
    //Launch camera view controller.
    NSLog(@"Camera opened");
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //If user is null, initialize it, otherwise, don't touch it.
    
    if([MZUser getCurrentUser] == nil){
        [self fetchUserInfoWithCompletionHandler:^{
            
        }];

    }
    else{
        DraggableViewBackground *bg = [[DraggableViewBackground alloc] initWithFrame:self.view.frame];
        [self.view addSubview:bg];
    }
    
    SWRevealViewController *revealViewController = self.revealViewController;
    UITapGestureRecognizer *tap = [revealViewController tapGestureRecognizer];
    [self.view addGestureRecognizer:tap];
    if(revealViewController){
        [self.sidebarButton setTarget:self.revealViewController];
        [self.sidebarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Delegate methods for UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    //Upload the image, once the user has taken it. Do NOT save in phone photo gallery.
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [MZApi uploadPhotoWithID:[[MZUser getCurrentUser] getUserID] andPhotoImage:chosenImage andCompletionHandler:^(MZPhoto *photo, NSError *error) {
        NSLog(@"Photo Uploaded!");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Photo Upload" message:@"Photo Upload Complete!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okButton];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:    (FrontViewPosition)position
{
    if(position == FrontViewPositionLeft) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:    (FrontViewPosition)position
{
    if(position == FrontViewPositionLeft) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}

- (void)fetchUserInfoWithCompletionHandler:(void (^)(void))segue {
    if([FBSDKAccessToken currentAccessToken]){
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, email"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 if([result isKindOfClass:[NSDictionary class]]) {
                     NSDictionary *jsonDict = (NSDictionary * )result;
                     NSLog(@"%@", jsonDict);
                     [MZApi checkUserWithID:result[@"id"] andCompletionHandler:^(NSString *userID, NSError *error) {
                         if (error)
                             NSLog(@" %@", [error description]);
                         else {
                             MZUser *user = [[MZUser alloc] initWithJSON:jsonDict andUserId:userID];
                             [MZUser setCurrentUser:user];
                             DraggableViewBackground *bg = [[DraggableViewBackground alloc] initWithFrame:self.view.frame];
                             [self.view addSubview:bg];

                         }
                     }];
                 }
             }
             else {
                 NSLog(@"There was an error %@", error);
             }
         }];
    }
}






@end
