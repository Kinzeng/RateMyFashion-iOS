//
//  MZUser.m
//  RateMyFashion
//
//  Created by Kai Mou on 3/28/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "MZUser.h"

static MZUser *currentUser;

@implementation MZUser
@synthesize photoList;


- (id)initWithJSON:(NSDictionary * )returnedJSON andUserId:(NSString *)userId{
    if((self = [super init])){
        self.userID = userId;
        self.firstName = [returnedJSON objectForKey:@"first_name"];
        self.lastName = [returnedJSON objectForKey:@"last_name"];
    }
    return self;
    
}

+ (void)setCurrentUser:(MZUser *)user{
    currentUser = user;
}

+ (void)clearCurrentUser{
    currentUser = nil;
}

+ (MZUser *)getCurrentUser{
    return currentUser;
}

+ (void)setPhotoList:(NSArray *)photosFromHTTP{
    self.photoList = photosFromHTTP;
}

- (NSString *) getUserID{
    return currentUser.userID;
}

- (NSString *) description{
    return [NSString stringWithFormat:@"User: First Name = %@, Last Name = %@ UserID = %@", currentUser.firstName, currentUser.lastName, currentUser.userID];
}

@end


