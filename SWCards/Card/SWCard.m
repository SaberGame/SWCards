//
//  SWCard.m
//  SWCards
//
//  Created by songlong on 16/5/26.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWCard.h"

@implementation SWCard

+ (NSArray *)allCards {
    
    NSMutableArray *allCards = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MinionList.plist" ofType:nil];
    NSArray *cardArray = [NSArray arrayWithContentsOfFile:path];
    for (NSString *name in cardArray) {
        SWCard *card = [[NSClassFromString(name) alloc] init];
        [allCards addObject:card];
    }
    return allCards.copy;
}

- (id)copyWithZone:(NSZone *)zone {
    
    SWCard *card = [[SWCard alloc] init];
    card.cardName = [self.cardName copyWithZone:zone];;
    card.manaCost = self.manaCost;
    card.cardImageName = [self.cardImageName copyWithZone:zone];
    card.cardType = [self.cardType copyWithZone:zone];
    card.minionType = [self.minionType copyWithZone:zone];
    card.attack = self.attack;
    card.defense = self.defense;
    
    return card;
}

@end
