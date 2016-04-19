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
@interface SwipeViewController ()

@end

@implementation SwipeViewController

- (IBAction)toPhotoGallery:(id)sender {
    //Launch photo browser.
    [self showPhotoBrowser];
}

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
    bg.delegate = self;
    [self.view addSubview:bg];
    NSLog(@"%@", [[MZUser getCurrentUser] description]);
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)menuPressed {
    //Temporarily, segue to photo gallery for now using the menu button.
    NSLog(@"Menu Pressed");
}

-(NSUInteger) numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return [self.userPhotoList count];
    
}

//Delegate methods for UIImagePickerDelegate

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    //Upload the image, once the user has taken it. Do NOT save in phone photo gallery.
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [MZApi uploadPhotoWithID:[[MZUser getCurrentUser] getUserID] andPhotoImage:chosenImage andCompletionHandler:^(MZPhoto *photo, NSError *error) {
        NSLog(@"Photo Uploaded!");
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

//delegate methods from MWPhotoBrowser.
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    
    if(index<self.userPhotoList.count){
        return [self.userPhotoList objectAtIndex:index];
    }
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index{
    if(index<self.userPhotoList.count){
        return [self.userPhotoList objectAtIndex:index];
    }
    return nil;
}
//Load the photobrowser once the menu button is pressed.
- (void)showPhotoBrowser{
    //Swap out kai1234 with the actual user_id later.
    [MZApi loadOwnPhotoWithUserID:[[MZUser getCurrentUser] getUserID]
             andCompletionHandler:^(NSMutableArray *photos, NSError *error) {
        if(error) {
            NSLog([error description]);
        }
        else {
            NSLog(@"No error");
            [[MZUser getCurrentUser] setPhotoList:photos];
            //Should currently be null because CurrentUser is not created yet.
            for(int i = 0; i<photos.count; i++){
                [self.userPhotoList addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[[photos objectAtIndex:i]file_url]]]];
            }
            
            MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
            browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
            browser.startOnGrid = YES; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO
            
            [self.navigationController pushViewController:browser animated:YES];
        }
    }];
}

@end
