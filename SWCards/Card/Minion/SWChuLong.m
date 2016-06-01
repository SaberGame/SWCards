//
//  SWChuLong.m
//  SWCards
//
//  Created by songlong on 16/5/30.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWChuLong.h"

@implementation SWChuLong

- (instancetype)init {
    if (self = [super init]) {
        self.cardName = @"雏龙";
        self.cardImageName = @"雏龙";
        self.attack = 1;
        self.defense = 1;
        self.manaCost = 1;
    }
    return self;
}

@end
