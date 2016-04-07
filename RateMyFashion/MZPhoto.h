//
//  MZPhoto.h
//  RateMyFashion
//
//  Created by Kai Mou on 4/6/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "JSONModel.h"

@interface MZPhoto : JSONModel
@property(assign, nonatomic) int photo_id;
@property(assign, nonatomic) NSString * user_id;
@property(assign, nonatomic) int dislikes;
@property(assign, nonatomic) NSString * file_url;
@property(assign, nonatomic) int likes;


@end
