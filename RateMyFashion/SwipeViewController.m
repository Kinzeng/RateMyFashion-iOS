//
//  SwipeViewController.m
//  RateMyFashion
//
//  Created by Kevin on 4/7/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "SwipeViewController.h"
#import "DraggableViewBackground.h"

@interface SwipeViewController ()

@end

@implementation SwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DraggableViewBackground *bg = [[DraggableViewBackground alloc] initWithFrame:self.view.frame];
    bg.delegate = self;
    [self.view addSubview:bg];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)menuPressed {
    NSLog([[MZUser getCurrentUser] description]);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
