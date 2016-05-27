//
//  SWDeck.m
//  SWCards
//
//  Created by songlong on 16/5/23.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWDeck.h"
#import "SWHero.h"

@implementation SWDeck

- (instancetype)init {
    if (self = [super init]) {
        self.deckHero = [[SWHero alloc] init];
    }
    return self;
}

@end
