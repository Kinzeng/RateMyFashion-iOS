//
//  SwipeViewController.m
//  RateMyFashion
//
//  Created by Kevin on 4/7/16.
//  Copyright © 2016 MouZhang. All rights reserved.
///Users/kaimou/Desktop/RateMyFashion-iOS/RateMyFashion/TestViewController.h

#import "SwipeViewController.h"
#import "DraggableViewBackground.h"

@interface SwipeViewController ()

@end

@implementation SwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DraggableViewBackground *bg = [[DraggableViewBackground alloc] initWithFrame:self.view.frame];
    bg.delegate = self;
    [self.view addSubview:bg];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)menuPressed {
    //Temporarily, segue to photo gallery for now.
    NSLog(@"Menu Pressed");
    [self showPhotoBrowser];
    
}
-(NSUInteger) numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return [self.userPhotoList count];
    
}

//delegate methods from MWPhotoBrowser.
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    
    if(index<self.userPhotoList.count){
        return [self.userPhotoList objectAtIndex:index];
    }
    return nil;
}
-(id <MWPhoto>) photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index{
    if(index<self.userPhotoList.count){
        return [self.userPhotoList objectAtIndex:index];
    }
    return nil;
}
//Load the photobrowser once the menu button is pressed.
-(void) showPhotoBrowser{
    self.userPhotoList = [NSMutableArray array];
    [MZApi loadOwnPhotoWithUserID:@"kai1234" andCompletionHandler:^(NSMutableArray *photos, NSError *error) {
        if(photos!=nil){
            //self.userPhotoList = photos;
            [[MZUser getCurrentUser]setPhotoList:self.userPhotoList];
            //NSLog(@" %@", self.userPhotoList);
            //Should currently be null because CurrentUser is not created yet.
            for(int i = 0; i<photos.count; i++){
                [self.userPhotoList addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[[photos objectAtIndex:i]file_url]]]];
            }
            MWPhotoBrowser *browser = [[MWPhotoBrowser alloc]initWithDelegate:self];
            browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
            browser.startOnGrid = YES; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO
            
            [self.navigationController pushViewController:browser animated:YES];
            
        }
        else{
            NSLog(@"Failed to allocate photos!");
        }
        
        
    }];

}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
