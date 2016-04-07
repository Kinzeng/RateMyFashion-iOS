//
//  MZPhoto.h
//  RateMyFashion
//
//  Created by Kai Mou on 4/6/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@interface MZPhoto : JSONModel
@property(assign, nonatomic) int photoID;
@property(assign, nonatomic) NSString * ownerID;
@property(assign, nonatomic) int numberOfLikes;
@property(assign, nonatomic) int numberOfDislikes;


@end
