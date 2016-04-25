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

+ (void)loadRandomPhotosWithID:(NSString *)userID
          andNumOfPhotos:(int)numOfPhotos
    andCompletionHandler:(void (^)(NSArray *results, NSError *error))callback;

+ (void)likePhotoWithPhotoID:(int)photoID
                   andUserID:(NSString *)userID
        andCompletionHandler:(void(^)(MZPhoto *photo, NSError *error))callback;

+ (void)dislikePhotoWithPhotoID:(int)photoID
                      andUserID:(NSString *)userID
           andCompletionHandler:(void(^)(MZPhoto *photo, NSError *error))callback;

+ (void)loadOwnPhotoWithUserID:(NSString * )userID
          andCompletionHandler:(void(^)(NSMutableArray *user, NSError *error))callback;

+ (void)deletePhotoWithID:(int)photoID
     andCompletionHandler:(void(^)(MZPhoto *photo, NSError *error))callback;

+ (void)checkUserWithID:(NSString *)userID
     andCompletionHandler:(void(^)(NSString *userID, NSError *error))callback;

+ (void)uploadPhotoWithID:(NSString* ) ownerID andPhotoImage: (UIImage* ) image
    andCompletionHandler:(void(^)(MZPhoto *photo, NSError *error))callback;

@end
