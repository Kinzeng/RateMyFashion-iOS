//
//  SettingsViewController.m
//  RateMyFashion
//
//  Created by Kai Mou on 4/24/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController
@synthesize menubarButton;

-(void) viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    UITapGestureRecognizer *tap = [revealViewController tapGestureRecognizer];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    if(revealViewController) {
        [self.menubarButton setTarget:self.revealViewController];
        [self.menubarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //deselect the row after selecting it for the "deselect" animation.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch(indexPath.row) {
        case 0: {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Desired Display Name"
                                                                           message:nil
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"Display Name";
            }];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      //Handle the name change here. Most likely with an Update user API call.
                                                                      //UITextField *desiredName = alert.textFields.firstObject;
                                                                      
                                                                  }];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    
}
- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:    (FrontViewPosition)position
{
    if(position == FrontViewPositionLeft) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:    (FrontViewPosition)position
{
    if(position == FrontViewPositionLeft) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}


@end
