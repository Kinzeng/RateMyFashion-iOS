//
//  SwipeViewController.h
//  RateMyFashion
//
//  Created by Kevin on 4/7/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DraggableViewBackground.h"
#import "MZUser.h"
#import "MWPhotoBrowser.h"

@interface SwipeViewController : UIViewController <DraggableViewBackgroundDelegate, MWPhotoBrowserDelegate>
@property(strong, nonatomic) NSMutableArray * userPhotoList;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *toCameraView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *toPhotoGallery;
- (void)menuPressed;
-(NSUInteger) numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser;
-(id <MWPhoto>) photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index;
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index;


@end
