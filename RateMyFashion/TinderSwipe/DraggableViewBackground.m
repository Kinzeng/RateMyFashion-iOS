//
//  DraggableViewBackground.m
//  testing swiping
//
//  Created by Richard Kim on 8/23/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

#import "DraggableViewBackground.h"

@implementation DraggableViewBackground {
    NSInteger cardsLoadedIndex; //%%% the index of the card you have loaded into the loadedCards array last
    NSMutableArray *loadedCards; //%%% the array of card loaded (change max_buffer_size to increase or decrease the number of cards this holds)
    NSMutableSet *set;
    
    UIButton *menuButton;
    UIButton *messageButton;
    UIButton *checkButton;
    UIButton *xButton;
}
//this makes it so only two cards are loaded at a time to
//avoid performance and memory costs
static const int MAX_BUFFER_SIZE = 2; //%%% max number of cards loaded at any given time, must be greater than 1
static const int numToLoad = 5;
static float CARD_HEIGHT;
static float CARD_WIDTH;

@synthesize allCards;//%%% all the cards

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    CARD_HEIGHT = self.frame.size.height * 0.6; //%%% height of the draggable card
    CARD_WIDTH = self.frame.size.width * 0.9; //%%% width of the draggable card
    
    if (self) {
        [super layoutSubviews];
        [self setupView];
        
        //        MZPhoto *photo = [[MZPhoto alloc] init];
        //        photo.file_url = @"http://localhost:3000/static/photos/1.jpg";
        //        photo.user_id = 0;
        //        photo.photo_id = 1;
        
        loadedCards = [[NSMutableArray alloc] init];
        set = [[NSMutableSet alloc] init];
        allCards = [[NSMutableArray alloc] init];
        cardsLoadedIndex = 0;
        
        [MZApi loadRandomPhotosWithID:[[MZUser getCurrentUser] getUserID]
                       andNumOfPhotos:numToLoad
                 andCompletionHandler:^(NSArray *results, NSError *error) {
                     if (error)
                         NSLog(@"%ld: %@", (long)error.code, error.domain);
                     else
                         [self initCardsFromArray:results];
                 }];
    }
    return self;
}

//%%% sets up the extra buttons on the screen
- (void)setupView {
    self.backgroundColor = [UIColor colorWithRed:.92 green:.93 blue:.95 alpha:1]; //the gray background colors
    
    //    int menuWidth = 22;
    //    int menuHeight = 15;
    //    menuButton = [[UIButton alloc]initWithFrame:CGRectMake(17, 34, menuWidth, menuHeight)];
    //    [menuButton setImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
    //    [menuButton addTarget:self action:@selector(menuPressed) forControlEvents:UIControlEventTouchUpInside];
    //
    //    int messageWidth = 18;
    //    int messageHeight = 18;
    //    messageButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - (17 + messageWidth), 34, messageWidth, messageHeight)];
    //    [messageButton setImage:[UIImage imageNamed:@"messageButton"] forState:UIControlStateNormal];
    
    xButton = [[UIButton alloc]initWithFrame:CGRectMake((self.frame.size.width / 2) - 100, self.frame.size.height - 125, 60, 60)];
    [xButton setImage:[UIImage imageNamed:@"xButton"] forState:UIControlStateNormal];
    [xButton addTarget:self action:@selector(swipeLeft) forControlEvents:UIControlEventTouchUpInside];
    
    checkButton = [[UIButton alloc]initWithFrame:CGRectMake((self.frame.size.width / 2) + 40, self.frame.size.height - 125, 60, 60)];
    [checkButton setImage:[UIImage imageNamed:@"checkButton"] forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(swipeRight) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:menuButton];
    [self addSubview:messageButton];
    [self addSubview:xButton];
    [self addSubview:checkButton];
}

//%%% creates a card and returns it
- (DraggableView *)createDraggableViewWithPhoto:(MZPhoto *)photo {
    DraggableView *draggableView = [[DraggableView alloc]initWithFrame:CGRectMake((self.frame.size.width - CARD_WIDTH) / 2, (self.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT) andPhoto:photo];
    draggableView.delegate = self;
    
    return draggableView;
}

//%%% loads all the cards and puts the first x in the "loaded cards" array
- (void)initCardsFromArray:(NSArray *)photos {
    NSInteger numLoadedCardsCap = (([photos count] > MAX_BUFFER_SIZE) ? MAX_BUFFER_SIZE : [photos count]); //%%% if the buffer size is greater than the data size, there will be an array error, so this makes sure that doesn't happen
    
    NSLog(@"%d", (int)numLoadedCardsCap);
    for (NSInteger i = 0; i < [photos count]; i++) {
        NSLog(@"%d", (int)i);
        [set addObject:[NSNumber numberWithInteger:[[photos objectAtIndex:i] photo_id]]];
        DraggableView *c = [self createDraggableViewWithPhoto:[photos objectAtIndex:i]];
        [allCards addObject:c];
        if (i < numLoadedCardsCap)
            [loadedCards addObject:c];
    }
    
    NSLog(@"init");
    
    //%%% displays the small number of loaded cards dictated by MAX_BUFFER_SIZE so that not all the cards
    // are showing at once and clogging a ton of data
    for (int i = 0; i < [loadedCards count]; i++) {
        if (i > 0) {
            [self insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i-1]];
        }
        else {
            [self addSubview:[loadedCards objectAtIndex:i]];
        }
        cardsLoadedIndex++; //%%% we loaded a card into loaded cards, so we have to increment
    }
}

//%%% action called when the card goes to the left.
- (void)cardSwipedLeft:(UIView *)card {
    DraggableView *c = (DraggableView *)card;
    [MZApi dislikePhotoWithPhotoID:c.photo.photo_id
                         andUserID:[[MZUser getCurrentUser] getUserID]
              andCompletionHandler:^(MZPhoto *photo, NSError *error) {
                  if (error)
                      NSLog(@"%ld: %@", (long)error.code, error.domain);
                  else
                      NSLog(@"Disliked photo %d", c.photo.photo_id);
                  
                  if ([allCards count] - cardsLoadedIndex == 0)
                      [self findCards];
                  else
                      [self loadCard];
              }];
}

//%%% action called when the card goes to the right.
- (void)cardSwipedRight:(UIView *)card {
    DraggableView *c = (DraggableView *)card;
    [MZApi likePhotoWithPhotoID:c.photo.photo_id
                      andUserID:[[MZUser getCurrentUser] getUserID]
           andCompletionHandler:^(MZPhoto *photo, NSError *error) {
               if (error)
                   NSLog(@"%ld: %@", (long)error.code, error.domain);
               else
                   NSLog(@"Liked photo %d", c.photo.photo_id);
               
               if ([allCards count] - cardsLoadedIndex == 0)
                   [self findCards];
               else
                   [self loadCard];
           }];
    
}

- (void)findCards {
    [MZApi loadRandomPhotosWithID:[[MZUser getCurrentUser] getUserID]
                   andNumOfPhotos:numToLoad
             andCompletionHandler:^(NSArray *results, NSError *error) {
                 if (error)
                     NSLog(@"%ld: %@", (long)error.code, error.domain);
                 else {
                     for (NSInteger i = 0; i < [results count]; i++) {
                         if (![set containsObject:[NSNumber numberWithInteger:[[results objectAtIndex:i] photo_id]]]) {
                             [set addObject:[NSNumber numberWithInteger:[[results objectAtIndex:i] photo_id]]];
                             DraggableView *c = [self createDraggableViewWithPhoto:[results objectAtIndex:i]];
                             [allCards addObject:c];
                         }
                     }
                 }
                 
                 [self loadCard];
             }];
}

- (void)loadCard {
    if ([loadedCards count] > 0)
        [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE - 1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE - 2)]];
    }
}

//%%% when you hit the right button, this is called and substitutes the swipe
- (void)swipeRight {
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeRight;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView rightClickAction];
}

//%%% when you hit the left button, this is called and substitutes the swipe
- (void)swipeLeft {
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeLeft;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView leftClickAction];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
