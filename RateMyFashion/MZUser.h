//
//  MZUser.h
//  RateMyFashion
//
//  Created by Kai Mou on 3/28/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@interface MZUser : NSObject

@property (strong) NSString * userId;
@property (strong) NSString * firstName;
@property (strong) NSString * lastName;

-(id) initWithJSON:(NSDictionary * )returnedJSON andAccessToken:(NSString *) accessToken;
-(NSString *) getUserToken;

+(void) setCurrentUser: (MZUser *) currentUser;
+(void) clearCurrentUser;
+(MZUser *) getCurrentUser;
@end
