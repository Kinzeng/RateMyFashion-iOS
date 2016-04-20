//
//  MZApi.m
//  RateMyFashion
//
//  Created by Kai Mou on 4/7/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "MZApi.h"

@implementation MZApi

+ (void)loadRandomPhotosWithID:(NSString *)userID
                andNumOfPhotos:(int)numOfPhotos
          andCompletionHandler:(void (^)(NSArray *results, NSError *error))callback {
    
    NSDictionary *parameters = @{@"user_id": userID, @"num" : [@(numOfPhotos) stringValue]};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:load_photos_url
      parameters:parameters
        progress:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             if ([responseObject isKindOfClass:[NSDictionary class]]) {
                 NSLog(@"HTTP error in load random");
                 callback(nil, [NSError errorWithDomain:responseObject[@"message"] code:[responseObject[@"error"] integerValue] userInfo:NULL]);
             }
             else {
                 NSLog(@"load random");
                 NSArray *items = (NSArray*)responseObject;
                 NSMutableArray *returnedPhotos = [NSMutableArray new];
                 [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                     MZPhoto *photo = [[MZPhoto alloc] initWithJSON:obj];
                     [returnedPhotos addObject:photo];
                 }];
                 callback(returnedPhotos, nil);
             }
         }
         failure:^(NSURLSessionDataTask *operation, NSError *error) {
             NSLog(@"Failed");
         }];
}

+ (void)likePhotoWithPhotoID:(int)photoID
        andCompletionHandler:(void(^)(MZPhoto *photo, NSError *error))callback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"photo_id": [@(photoID) stringValue]};
    
    [manager POST:like_photo_url
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"Response: %@", responseObject);
              if (responseObject[@"error"])
                  callback(nil, [NSError errorWithDomain:responseObject[@"message"] code:[responseObject[@"error"] integerValue] userInfo:NULL]);
              else {
                  MZPhoto *photo = [[MZPhoto alloc] initWithJSON:responseObject];
                  callback(photo, nil);
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"Photo liking Failed");
          }];
}

+ (void)dislikePhotoWithPhotoID:(int)photoID
           andCompletionHandler:(void (^)(MZPhoto *photo, NSError *error))callback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"photo_id": [@(photoID) stringValue]};
    
    [manager POST:dislike_photo_url
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"Response: %@", responseObject);
              if (responseObject[@"error"])
                  callback(nil, [NSError errorWithDomain:responseObject[@"message"] code:[responseObject[@"error"] integerValue] userInfo:NULL]);
              else {
                  MZPhoto *photo = [[MZPhoto alloc] initWithJSON:responseObject];
                  callback(photo, nil);
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"Photo dislike Failed");
          }];
}

+ (void)loadOwnPhotoWithUserID:(NSString *)userID
          andCompletionHandler:(void(^)(NSMutableArray *photos, NSError *error))callback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"user_id": userID};
    [manager GET:load_own_photos_url
      parameters:parameters
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             if ([responseObject isKindOfClass:[NSDictionary class]]) {
                 NSDictionary *item = (NSDictionary *) responseObject;
                 callback(nil, [NSError errorWithDomain:item[@"message"] code:[item[@"error"] integerValue] userInfo:NULL]);
             }
             else{
                 NSMutableArray *returnedPhotos = [NSMutableArray new];
                 NSArray *photos = (NSArray *) responseObject;
                 for(id obj in photos){
                     
                     MZPhoto *photo = [[MZPhoto alloc] initWithJSON:obj];
                     [returnedPhotos addObject:photo];
                 }
                 
                 callback(returnedPhotos, nil);
             }
             
        }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Photo dislike Failed");
         }];
}

+ (void)deletePhotoWithID:(int)photoID
     andCompletionHandler:(void (^)(MZPhoto *photo, NSError *error))callback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"photo_id": [@(photoID) stringValue]};
    
    [manager POST:delete_photo_url
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              MZPhoto *photo = [[MZPhoto alloc] initWithJSON:responseObject];
              
              if (responseObject[@"error"])
                  callback(nil, [NSError errorWithDomain:responseObject[@"message"] code:[responseObject[@"error"] integerValue] userInfo:NULL]);
              else
                  callback(photo, nil);
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"Photo delete Failed");
          }];
}

+ (void)checkUserWithID:(NSString *)userID
   andCompletionHandler:(void (^)(NSString *userID, NSError *error))callback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"user_id":userID};
    
    [manager GET:check_user_url
      parameters:parameters
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             if (responseObject[@"error"])
                 callback(nil, [NSError errorWithDomain:responseObject[@"message"] code:[responseObject[@"error"] integerValue] userInfo:NULL]);
             else
                 callback(responseObject[@"user_id"], nil);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Check User Failed");
         }];
}

+ (void)uploadPhotoWithID:(NSString *)ownerID andPhotoImage:(UIImage *)image andCompletionHandler:(void (^)(MZPhoto *, NSError *))callback{
    
    NSData *imageData = UIImageJPEGRepresentation(image, .5);
    NSDictionary *parameters = @{@"owner_id": ownerID};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:upload_photo_url]];
    [manager POST:upload_photo_url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    [formData appendPartWithFileData:imageData name:@"photo" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
    }
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"%@", responseObject);
              
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"Failed");
          }];
}


@end
