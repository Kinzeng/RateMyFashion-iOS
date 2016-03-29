//
//  MZUser.m
//  RateMyFashion
//
//  Created by Kai Mou on 3/28/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "MZUser.h"

@implementation MZUser

@synthesize userId = _userId;
@synthesize firstName = _firstName;
@synthesize lastName = _lastName;

-(id) initWithFirstName:(NSString * )firstName{
    if((self = [super init])){
        self.firstName = firstName;
    }
    return self;
}
@end
