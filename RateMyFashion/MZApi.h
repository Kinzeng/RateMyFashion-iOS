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

+ (void)loadPhotosWithID:(NSString *)userID
          andNumOfPhotos:(int)numOfPhotos
    andCompletionHandler:(void (^)(NSArray *results, NSError *error))callback;

+ (void)likePhotoWithPhotoID:(int)photoID
        andCompletionHandler:(void(^)(MZPhoto *photo, NSError *error))callback;

+ (void)dislikePhotoWithPhotoID:(int)photoID
           andCompletionHandler:(void(^)(MZPhoto *photo, NSError *error))callback;

+ (void)loadOwnPhotoWithUserID:(NSString * )userID
          andCompletionHandler:(void(^)(NSArray *user, NSError *error))callback;

+ (void)deletePhotoWithID:(int)photoID
     andCompletionHandler:(void(^)(MZPhoto *photo, NSError *error))callback;

+ (void)checkUserWithID:(NSString *)userID
     andCompletionHandler:(void(^)(NSString *userID, NSError *error))callback;

@end
