//
//  MZUser.m
//  RateMyFashion
//
//  Created by Kai Mou on 3/28/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "MZUser.h"

@implementation MZUser


- (id)initWithJSON:(NSDictionary *)returnedJSON
      andAccessToken:(NSString *)accessToken {
    if((self = [super init])){
        self.userId = accessToken;
        self.firstName = [returnedJSON objectForKey:@"first_name"];
        self.lastName = [returnedJSON objectForKey:@"last_name"];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"User: FirstName=%@, LastName=%@", self.firstName, self.lastName];
}

@end


