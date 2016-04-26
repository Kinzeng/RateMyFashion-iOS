//
//  SwipeViewController.m
//  RateMyFashion
//
//  Created by Kevin on 4/7/16.
//  Copyright © 2016 MouZhang. All rights reserved.
///Users/kaimou/Desktop/RateMyFashion-iOS/RateMyFashion/TestViewController.h

#import "SwipeViewController.h"
#import "DraggableViewBackground.h"
#import "TestViewController.h"
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
    DraggableViewBackground *bg = [[DraggableViewBackground alloc] initWithFrame:self.view.frame];
    [self.view addSubview:bg];
    NSLog(@"%@", [[MZUser getCurrentUser] description]);
    
    SWRevealViewController *revealViewController = self.revealViewController;
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



@end
