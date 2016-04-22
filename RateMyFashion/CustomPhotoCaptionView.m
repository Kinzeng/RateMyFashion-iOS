//
//  CustomPhotoCaptionView.m
//  RateMyFashion
//
//  Created by Kai Mou on 4/20/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "CustomPhotoCaptionView.h"


@implementation CustomPhotoCaptionView


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
    return CGSizeMake(200, 200);
}
@end
