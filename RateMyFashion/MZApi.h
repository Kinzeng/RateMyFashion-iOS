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
@interface MZApi : NSObject

+ (void)loadOwnPhotosWithCompletionHandler:(void (^)(NSMutableArray *results))callback;
//+(MZPhoto *) likePhoto;
//+(MZPhoto *) dislikePhoto;

@end
