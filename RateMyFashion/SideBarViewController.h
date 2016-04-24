//
//  SideBarViewController.h
//  RateMyFashion
//
//  Created by Kai Mou on 4/22/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZApi.h"
#import "MZUser.h"
#import "MWPhotoBrowser.h"
@interface SideBarViewController : UITableViewController < MWPhotoBrowserDelegate, UITableViewDelegate>
@property(strong, nonatomic) NSArray * menuItems;

- (void)showPhotoBrowser;
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index;
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index;
-(NSUInteger) numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser;



@end
