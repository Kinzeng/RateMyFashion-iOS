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
    
    UIButton *menuButton;
    UIButton *messageButton;
    UIButton *checkButton;
    UIButton *xButton;
}
//this makes it so only two cards are loaded at a time to
//avoid performance and memory costs
static const int MAX_BUFFER_SIZE = 2; //%%% max number of cards loaded at any given time, must be greater than 1
static float CARD_HEIGHT;
static float CARD_WIDTH;

@synthesize exampleCardLabels; //%%% all the labels I'm using as example data at the moment
@synthesize allCards;//%%% all the cards
@synthesize photoArray;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    CARD_HEIGHT = self.frame.size.height * 0.6; //%%% height of the draggable card
    CARD_WIDTH = self.frame.size.width * 0.8; //%%% width of the draggable card
    
    if (self) {
        [super layoutSubviews];
        [self setupView];
        exampleCardLabels = [[NSArray alloc]initWithObjects:@"first", @"second", @"third", @"fourth", @"last", nil]; //%%% placeholder for card-specific information
        
        MZPhoto *photo = [[MZPhoto alloc] init];
        photo.file_url = @"https://scontent.xx.fbcdn.net/v/t1.0-9/10559810_782711591760368_5184506463589103282_n.jpg?oh=7c7adb02fb54bd3c183ad01efadb7180&oe=5779FADD";
        photoArray = [[NSMutableArray alloc] initWithObjects:photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, photo, nil];
        loadedCards = [[NSMutableArray alloc] init];
        allCards = [[NSMutableArray alloc] init];
        cardsLoadedIndex = 0;
        
        //TODO: HTTP request to load X photos (10 or so)
        [self loadCards]; //put this in a callback
    }
    return self;
}

//%%% sets up the extra buttons on the screen
- (void)setupView {
    self.backgroundColor = [UIColor colorWithRed:.92 green:.93 blue:.95 alpha:1]; //the gray background colors
    
    int menuWidth = 22;
    int menuHeight = 15;
    menuButton = [[UIButton alloc]initWithFrame:CGRectMake(17, 34, menuWidth, menuHeight)];
    [menuButton setImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(menuPressed) forControlEvents:UIControlEventTouchUpInside];
    
    int messageWidth = 18;
    int messageHeight = 18;
    messageButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - (17 + messageWidth), 34, messageWidth, messageHeight)];
    [messageButton setImage:[UIImage imageNamed:@"messageButton"] forState:UIControlStateNormal];
    
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
- (DraggableView *)createDraggableViewWithDataAtIndex:(NSInteger)index {
    DraggableView *draggableView = [[DraggableView alloc]initWithFrame:CGRectMake((self.frame.size.width - CARD_WIDTH) / 2, (self.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT)
                                                              andPhoto:[photoArray objectAtIndex:index]];
    draggableView.index = index;
    draggableView.delegate = self;
    
    return draggableView;
}

//%%% loads all the cards and puts the first x in the "loaded cards" array
- (void)loadCards {
    
    NSInteger numLoadedCardsCap = (([photoArray count] > MAX_BUFFER_SIZE) ? MAX_BUFFER_SIZE : [photoArray count]);
    //%%% if the buffer size is greater than the data size, there will be an array error, so this makes sure that doesn't happen
    
    //%%% loops through the exampleCardsLabels array to create a card for each label.  This should be customized by removing "exampleCardLabels" with your own array of data
//    for (int i = 0; i < [exampleCardLabels count]; i++) {
//        DraggableView *newCard = [self createDraggableViewWithDataAtIndex:i];
//        [allCards addObject:newCard];
//        
//        if (i < numLoadedCardsCap) {
//            //%%% adds a small number of cards to be loaded
//            [loadedCards addObject:newCard];
//        }
//    }
    
    for (NSInteger i = 0; i < [photoArray count]; i++) {
        DraggableView *c = [self createDraggableViewWithDataAtIndex:i];
        [allCards addObject:c];
        if (i < numLoadedCardsCap)
            [loadedCards addObject:c];
    }
    
    //%%% displays the small number of loaded cards dictated by MAX_BUFFER_SIZE so that not all the cards
    // are showing at once and clogging a ton of data
    for (int i = 0; i < [loadedCards count]; i++) {
        if (i > 0) {
            [self insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i-1]];
        } else {
            [self addSubview:[loadedCards objectAtIndex:i]];
        }
        cardsLoadedIndex++; //%%% we loaded a card into loaded cards, so we have to increment
    }
}

//%%% action called when the card goes to the left.
- (void)cardSwipedLeft:(UIView *)card {
    DraggableView *c = (DraggableView *)card;
    [MZApi dislikePhotoWithPhotoID:c.photo.photo_id andCompletionHandler:^(MZPhoto *photo, NSError *error) {
        if (error)
            NSLog(@"%ld: %@", (long)error.code, error.domain);
        else
            NSLog(@"Disliked photo %d", c.photo.photo_id);
    }];
    
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    [allCards setObject:[NSNull null] atIndexedSubscript:c.index];
    
    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE - 1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE - 2)]];
    }
}

//%%% action called when the card goes to the right.
- (void)cardSwipedRight:(UIView *)card {
    DraggableView *c = (DraggableView *)card;
    [MZApi likePhotoWithPhotoID:c.photo.photo_id andCompletionHandler:^(MZPhoto *photo, NSError *error) {
        if (error)
            NSLog(@"%ld: %@", (long)error.code, error.domain);
        else
            NSLog(@"Liked photo %d", c.photo.photo_id);
    }];
    
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    [allCards setObject:[NSNull null] atIndexedSubscript:c.index];
    
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

- (void)menuPressed {
    [delegate menuPressed];
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
