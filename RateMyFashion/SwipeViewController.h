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


@interface SwipeViewController : UIViewController <DraggableViewBackgroundDelegate>

- (void)menuPressed;
- (void) segueToPhotoGallery;

@end
