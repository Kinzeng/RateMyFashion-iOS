//
//  PhotoGalleryController.h
//  RateMyFashion
//
//  Created by Kai Mou on 4/15/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"

@interface PhotoGalleryController : UIViewController <MWPhotoBrowserDelegate>
@property(strong, nonatomic) NSMutableArray * userPhotoList;

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser;
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index;
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index;

@end
