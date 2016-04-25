//
//  TestViewController.m
//  RateMyFashion
//
//  Created by Kevin on 4/5/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "TestViewController.h"
#import "MZUser.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://i.ytimg.com/vi/tntOCGkgt98/maxresdefault.jpg"]]];

    [MZApi uploadPhotoWithID:@"kai1234" andPhotoImage:image andCompletionHandler:^(MZPhoto *photo, NSError *error) {
        //Insert code here.
        NSLog(@"Photo Upload Successful!");
    }];
    
    // Do any additional setup after loading the view.
    [MZApi loadOwnPhotoWithUserID:@"kai1234" andCompletionHandler:^(NSMutableArray *photos, NSError *error) {
        if(!error){
            NSLog(@" Test  %@", photos);
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getUserInfo:(id)sender {
    //NSLog([[MZUser getCurrentUser] description]);
}


@end
