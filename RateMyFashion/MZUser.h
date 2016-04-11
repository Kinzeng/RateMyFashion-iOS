//
//  MZUser.h
//  RateMyFashion
//
//  Created by Kai Mou on 3/28/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MZUser : NSObject

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;

- (id)initWithJSON:(NSDictionary *)returnedJSON andAccessToken:(NSString *)accessToken;

@end
