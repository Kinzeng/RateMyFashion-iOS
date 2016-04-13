//
//  MZApi.h
//  RateMyFashion
//
//  Created by Kai Mou on 4/7/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//


#include <UIKit/UIKit.h>
#include "AFNetworking.h"
#include "MZPhoto.h"
#include "Constants.h"

@interface MZApi : NSObject

+ (void)loadPhotosWithId:(NSString *)userId andNumOfPhotos:(int)numOfPhotos andCompletionHandler:(void (^)(NSArray *results))callback;
+ (void)likePhotoWithPhotoId:(int)photoID andCompletionHandler:(void(^)(MZPhoto *))callback;
+ (void)dislikePhotoWithPhotoID:(int)photoID andCompletionHandler:(void(^)(MZPhoto *))callback;
+ (void)loadOwnPhotoWithUserId:(NSString * )userID andCompletionHandler:(void(^)(NSArray *))callback;
+ (void)deletePhotoWithId:(int)photoID andCompletionHandler:(void(^)(MZPhoto *))callback;

@end