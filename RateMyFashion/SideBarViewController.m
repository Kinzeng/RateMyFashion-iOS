//
//  SideBarViewController.m
//  RateMyFashion
//
//  Created by Kai Mou on 4/22/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "SideBarViewController.h"
#import "SWRevealViewController.h"

@implementation SideBarViewController
@synthesize menuItems;

- (void)viewDidLoad {
    [super viewDidLoad];
    //add recommendations later when UI is finished over there.
    menuItems = @[@"title", @"home", @"photogallery", @"recommendations", @"settings"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)UITableView
 numberOfRowsInSection:(NSInteger)section {
    return menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString * cellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
}

-       (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //This is the index of the "photo gallery."
    if(indexPath.row == 2) {
        NSLog(@"Photos Clicked");
        [self showPhotoBrowser];
    }
}

- (void)showPhotoBrowser {
    [MZApi loadOwnPhotoWithUserID:[[MZUser getCurrentUser] getUserID ]andCompletionHandler:^(NSMutableArray *photos, NSError *error) {
        if(error)
            NSLog(@" %@", [error description]);
        else {
            [[MZUser getCurrentUser] setPhotoList:photos];
            MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
            browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
            browser.startOnGrid = YES; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
            nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:nc animated:YES completion:nil];
        }
    }];
}

//delegate methods from MWPhotoBrowser.
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser
                photoAtIndex:(NSUInteger)index {
    if(index<[[[MZUser getCurrentUser] photoList] count]) {
        MZPhoto * photo = [[[MZUser getCurrentUser] photoList]objectAtIndex:index];
        photo.caption = [NSString stringWithFormat:@"Likes: %d   Dislikes: %d", photo.likes, photo.dislikes];
        return [[[MZUser getCurrentUser] photoList]objectAtIndex:index];
    }
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser
           thumbPhotoAtIndex:(NSUInteger)index {
    if(index<[[[MZUser getCurrentUser] photoList] count]) {
        return [[[MZUser getCurrentUser] photoList]objectAtIndex:index];
    }
    
    return nil;
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return [[[MZUser getCurrentUser] photoList] count];
}





@end
