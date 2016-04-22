//
//  SideBarViewController.m
//  RateMyFashion
//
//  Created by Kai Mou on 4/22/16.
//  Copyright © 2016 MouZhang. All rights reserved.
//

#import "SideBarViewController.h"
#import "SWRevealViewController.h"

@implementation SideBarViewController
@synthesize menuItems;

-(void) viewDidLoad{
    [super viewDidLoad];
    //add recommendations later when UI is finished over there.
    menuItems = @[@"title", @"home", @"photogallery", @"recommendations"];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *) tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *) UITableView numberOfRowsInSection:(NSInteger) section{
    return menuItems.count;
}
-(UITableViewCell *) tableView: (UITableView * ) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSString * cellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController *) segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row]capitalizedString];
    
    if([segue.identifier isEqualToString:@"showPhoto"]){
        UINavigationController *navController = segue.destinationViewController;
        
    }
    
}


@end
