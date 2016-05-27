//
//  SWSongShu.m
//  SWCards
//
//  Created by songlong on 16/5/26.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWSongShu.h"

@implementation SWSongShu

- (instancetype)init {
    if (self = [super init]) {
        self.cardName = @"松鼠";
        self.cardImageName = @"松鼠";
        self.attack = 1;
        self.defense = 1;
        self.manaCost = 1;
    }
    return self;
}

@end
