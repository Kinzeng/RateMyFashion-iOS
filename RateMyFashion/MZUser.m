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


-(id) initWithJSON:(NSDictionary * )returnedJSON andAccessToken:(NSString *) accessToken{
    if((self = [super init])){
        self.userId = accessToken;
        self.firstName = [returnedJSON objectForKey:@"first_name"];
        self.lastName = [returnedJSON objectForKey:@"last_name"];
    }
    return self;
    
}

+(void) setCurrentUser:(MZUser *)user{
    currentUser = user;
}
+(void) clearCurrentUser{
    currentUser = nil;
}
+(MZUser *) getCurrentUser{
    return currentUser;
}
-(NSString *) getUserToken{
    return _userId;
}
-(NSString *) description{
    return [NSString stringWithFormat:@"User: FirstName=%@, LastName=%@", _firstName, _lastName];
}

@end


