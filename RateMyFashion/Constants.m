//
//  Constants.m
//  RateMyFashion
//
//  Created by Kai Mou on 4/12/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "Constants.h"
#define BASE_URL @"http://localhost:3000/api/"

@implementation Constants
NSString *const load_photo_url = BASE_URL @"load_photo";
NSString * const like_photo_url = BASE_URL @"like_photo";
NSString * const dislike_photo_url = BASE_URL @"dislike_photo";
NSString * const load_own_photos_url = BASE_URL @"load_own";
NSString * const delete_photo_url = BASE_URL @"delete_photo";
NSString * const check_user_url = BASE_URL @"check_user";
@end
