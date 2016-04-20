//
//  CustomPhotoCaptionView.m
//  RateMyFashion
//
//  Created by Kai Mou on 4/20/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "CustomPhotoCaptionView.h"
static const CGFloat labelPadding = 10;


@implementation CustomPhotoCaptionView
@synthesize likes;
@synthesize dislikes;
@synthesize captionPhoto;
@synthesize label;

-(id) initWithPhoto:(id<MWPhoto>)photo{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 44)];
    if(self) {
        self.userInteractionEnabled = NO;
        self.barStyle = UIBarStyleBlackTranslucent;
        [self setBackgroundImage:nil forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];

        [self setupCaption];
    }
    return self;
}
-(void)setupCaption{
    
    
    
}
-(CGSize)sizeThatFits:(CGSize)size{
    //Testing: Should return width/height of caption.
    CGFloat maxHeight = 9999;
    if (label.numberOfLines > 0) maxHeight = label.font.leading* label.numberOfLines;
    CGSize textSize = [label.text boundingRectWithSize:CGSizeMake(size.width - labelPadding*2, maxHeight)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:label.font}
                                               context:nil].size;
    return CGSizeMake(size.width, textSize.height + labelPadding * 2);}
@end
