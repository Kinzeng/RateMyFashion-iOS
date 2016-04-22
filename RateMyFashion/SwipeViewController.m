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


-(NSUInteger) numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return [[[MZUser getCurrentUser] photoList] count];
    
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
    
    if(index<[[[MZUser getCurrentUser] photoList] count]){
        
        return [[[MZUser getCurrentUser] photoList]objectAtIndex:index];
    }
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index{
    if(index<[[[MZUser getCurrentUser] photoList] count]){
        return [[[MZUser getCurrentUser] photoList]objectAtIndex:index];
    }

    return nil;
}
-(MWCaptionView *) photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index{
    MZPhoto *photo = [[[MZUser getCurrentUser] photoList]objectAtIndex:index];
    CustomPhotoCaptionView *captionView = [[CustomPhotoCaptionView alloc] initWithPhoto:photo];
    return captionView;
}
//Load the photobrowser once the menu button is pressed.
- (void)showPhotoBrowser{
    [MZApi loadOwnPhotoWithUserID:[[MZUser getCurrentUser] getUserID ]andCompletionHandler:^(NSMutableArray *photos, NSError *error) {
        if(error) {
            NSLog(@" %@",[error description]);
        }
        else {
            [[MZUser getCurrentUser] setPhotoList:photos];
            MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
            browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
            browser.startOnGrid = YES; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO
            
            [self.navigationController pushViewController:browser animated:YES];
        }
    }];
}

@end
