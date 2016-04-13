//
//  MZPhoto.m
//  RateMyFashion
//
//  Created by Kai Mou on 4/6/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "MZPhoto.h"

@implementation MZPhoto

- (NSString *)description {
    return [NSString stringWithFormat:@"id: %d/nuser: %@/ndislikes: %d/nlikes: %d/nurl: %@", _photo_id, _user_id, _dislikes, _likes, _file_url];
}

@end
