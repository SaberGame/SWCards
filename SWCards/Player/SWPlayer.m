//
//  SWPlayer.m
//  SWCards
//
//  Created by songlong on 16/5/27.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWPlayer.h"
#import "SWDeck.h"

@implementation SWPlayer

- (instancetype)init {
    if (self = [super init]) {
        self.currentDeck = [[SWDeck alloc] init];
    }
    return self;
}

@end
