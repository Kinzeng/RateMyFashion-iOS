//
//  CustomPhotoCaptionView.h
//  RateMyFashion
//
//  Created by Kai Mou on 4/20/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import <MWPhotoBrowser/MWPhotoBrowser.h>
#import "MZPhoto.h"

@interface CustomPhotoCaptionView : MWCaptionView
@property(assign, nonatomic) int likes;
@property(assign, nonatomic) int dislikes;
@property(weak, nonatomic)  id <MWPhoto> captionPhoto;
@property(weak, nonatomic) UILabel * label;

-(id) initWithPhoto:(id<MWPhoto>)photo;
-(void) setupCaption;
-(CGSize) sizeThatFits:(CGSize)size;
@end
