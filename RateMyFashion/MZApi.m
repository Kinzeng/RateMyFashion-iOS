//
//  MZApi.m
//  RateMyFashion
//
//  Created by Kai Mou on 4/7/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "MZApi.h"

@implementation MZApi

+ (void)loadPhotosWithId:(NSString *)userId
          andNumOfPhotos:(int)numOfPhotos
    andCompletionHandler:(void (^)(NSArray *results))callback {
    
    NSDictionary *parameters = @{@"user_id": userId, @"num" : [@(numOfPhotos)stringValue]};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:load_photo_url parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id  responseObject) {
        NSArray *items = responseObject;
                    NSMutableArray *returnedPhotos = [NSMutableArray new];
                    [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        NSError *error = nil;
                        MZPhoto *photo = [[MZPhoto alloc]initWithDictionary:obj error:&error];
                        [returnedPhotos addObject:photo];
        
                    }];
                    
                    callback(returnedPhotos);

    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"Failed");
    }];

}

+ (void)likePhotoWithPhotoId:(int)photoID
        andCompletionHandler:(void(^)(MZPhoto *photo))callback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"photo_id": [@(photoID) stringValue]};

    [manager POST:like_photo_url
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Response: %@", responseObject);
        NSError *err = nil;
        MZPhoto *photo = [[MZPhoto alloc] initWithDictionary:responseObject error:&err];
        callback(photo);
        
    }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Photo liking Failed");
    }];
    
}

+ (void)dislikePhotoWithPhotoID:(int)photoID
           andCompletionHandler:(void (^)(MZPhoto *))callback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"photo_id": [@(photoID) stringValue]};
    
    [manager POST:dislike_photo_url
       parameters:parameters
         progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Response: %@", responseObject);
        NSError *err = nil;
        MZPhoto *photo = [[MZPhoto alloc] initWithDictionary:responseObject error:&err];
        callback(photo);
        
    }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Photo dislike Failed");
    }];

}

+ (void)loadOwnPhotoWithUserId:(NSString *)userID
          andCompletionHandler:(void(^)(NSArray *))callback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"user_id": userID};
    
    [manager GET:load_own_photos_url
      parameters:parameters
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *items = responseObject;
        NSMutableArray *returnedPhotos = [NSMutableArray new];
        [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSError *error = nil;
            MZPhoto *photo = [[MZPhoto alloc]initWithDictionary:obj error:&error];
            [returnedPhotos addObject:photo];
            
        }];
        
        callback(returnedPhotos);
        
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Photo dislike Failed");
    }];

}

+(void) deletePhotoWithId:(int)photoID
     andCompletionHandler:(void (^)(MZPhoto *))callback{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"photo_id": [@(photoID) stringValue]};
    
    [manager POST:delete_photo_url
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *err = nil;
        MZPhoto *photo = [[MZPhoto alloc] initWithDictionary:responseObject error:&err];
        callback(photo);
        
    }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Photo delete Failed");
    }];

}


                                                


@end