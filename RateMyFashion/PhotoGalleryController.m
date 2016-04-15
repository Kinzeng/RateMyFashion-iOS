//
//  PhotoGalleryController.m
//  RateMyFashion
//
//  Created by Kai Mou on 4/15/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "PhotoGalleryController.h"
#import "MZApi.h"
#import "MZUser.h"

@implementation PhotoGalleryController
@synthesize userPhotoList;

-(NSUInteger) numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return [self.userPhotoList count];
    
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    if(index<self.userPhotoList.count){
        NSString *temp = [[userPhotoList objectAtIndex:index]file_url];
        return [MWPhoto photoWithURL:[NSURL URLWithString:temp]];
    }
    return nil;
}
-(id <MWPhoto>) photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index{
    if(index<self.userPhotoList.count){
        NSString *temp = [[userPhotoList objectAtIndex:index]file_url];
        return [MWPhoto photoWithURL:[NSURL URLWithString:temp]];
    }
    return nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Make the HTTP request and setup the photo array in MZUser. Change from "kai1234" later. 
    [MZApi loadOwnPhotoWithUserID:@"kai1234" andCompletionHandler:^(NSMutableArray *photos, NSError *error) {
        if(photos!=nil){
            userPhotoList = photos;
            [[MZUser getCurrentUser]setPhotoList:self.userPhotoList];
            NSLog(@" %@", self.userPhotoList);
            //Should currently be null because CurrentUser is not created yet.
        }
        else{
            NSLog(@"Failed to allocate photos!");
        }
        
    }];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc]initWithDelegate:self];
    
    

    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = YES; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    [browser willMoveToParentViewController:self];
    [self.view addSubview:browser.view];
    [self.view bringSubviewToFront:browser.view];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
