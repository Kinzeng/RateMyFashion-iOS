//
//  MZApi.m
//  RateMyFashion
//
//  Created by Kai Mou on 4/7/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "MZApi.h"
#import "AFNetworking.h"
#import "Constants.h"

@implementation MZApi

+(void)loadOwnPhotosWithCompletionHandler:(void (^)(NSMutableArray *results)) callback {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:base_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@",responseObject);
            NSArray *items = responseObject;
            NSMutableArray *returnedPhotos = [NSMutableArray new];
            [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSError *error = nil;
                
                MZPhoto *photo = [[MZPhoto alloc]initWithDictionary:obj error:&error];
                [returnedPhotos addObject:photo];
                //NSLog(@"Owner ID: %@ %@", photo.file_url, photo.user_id);
            }];
            
            callback(returnedPhotos);
        }
    }];
    [dataTask resume];

}

                                                


@end
