//
//  MZPhoto.m
//  RateMyFashion
//
//  Created by Kai Mou on 4/6/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "MZPhoto.h"

@implementation MZPhoto

- (id)initWithJSON:(NSDictionary *)returnedJSON{
    if(self = [self initWithURL:[NSURL URLWithString:[returnedJSON objectForKey:@"file_url"]]]) {
        self.photo_id = [[returnedJSON objectForKey:@"photo_id"] intValue];
        self.file_url = [returnedJSON objectForKey:@"file_url"];
        self.likes = [[returnedJSON objectForKey:@"likes"] intValue];
        self.dislikes = [[returnedJSON objectForKey:@"dislikes"] intValue];
        self.user_id = [returnedJSON objectForKey:@"user_id"];
    }
    return self;
}
@end
