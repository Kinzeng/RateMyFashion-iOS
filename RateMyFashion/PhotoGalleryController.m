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
-(NSUInteger) numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    //testing
    return [MZUser getCurrentUser].photoList.count;
    
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    //testing
    return [MWPhoto photoWithURL:[NSURL URLWithString:@"https://i.ytimg.com/vi/tntOCGkgt98/maxresdefault.jpg"]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Make the HTTP request and setup the photo array in MZUser.
    [MZApi loadOwnPhotoWithUserID:@"kai1234" andCompletionHandler:^(NSMutableArray *photos, NSError *error) {
        if(photos!=nil){
            [[MZUser getCurrentUser]setPhotoList:photos];
            NSLog(@" %@", [[MZUser getCurrentUser]photoList]);
        }
        else{
            NSLog(@"Failed to allocate photos!");
        }
        
    }];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc]initWithDelegate:self];
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = YES; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
