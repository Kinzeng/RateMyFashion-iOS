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
#import "SWRevealViewController.h"

@interface SwipeViewController : UIViewController < UIImagePickerControllerDelegate, UINavigationControllerDelegate, SWRevealViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property(strong, nonatomic) NSMutableArray * MWPhotoList;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *toPhotoGallery;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *openCamera;



@end
