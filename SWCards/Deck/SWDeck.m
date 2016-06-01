//
//  SWDeck.m
//  SWCards
//
//  Created by songlong on 16/5/23.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWDeck.h"
#import "SWHero.h"
#import "SWCard.h"

@implementation SWDeck

- (instancetype)init {
    if (self = [super init]) {
        self.deckHero = [[SWHero alloc] init];
    }
    return self;
}

+ (NSInteger)deckCapacity {
    return 16;
}



- (SWCard *)drawCard {
    int randomNumber = arc4random() % _cardsArray.count;
    SWCard *card = _cardsArray[randomNumber];
    
    SWCard *tempCard = [card copy];
//    tempCard.cardImageName = card.cardImageName;
//    tempCard.cardName = card.cardName;
//    tempCard.cardType = card.cardType;
//    tempCard.manaCost = card.manaCost;
//    tempCard.attack = card.attack;
//    tempCard.defense = card.defense;
//    tempCard.minionType = card.minionType;
    
    NSMutableArray *mutableArray = _cardsArray.mutableCopy;
    [mutableArray removeObjectAtIndex:randomNumber];
    _cardsArray = mutableArray.copy;
    return tempCard;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"cards left: %zd", _cardsArray.count];
}

@end
