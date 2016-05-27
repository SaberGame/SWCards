//
//  SWXunMengLong.m
//  SWCards
//
//  Created by songlong on 16/5/26.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWXunMengLong.h"

@implementation SWXunMengLong

- (instancetype)init {
    if (self = [super init]) {
        self.cardName = @"迅猛龙";
        self.cardImageName = @"迅猛龙";
        self.attack = 3;
        self.defense = 2;
        self.manaCost = 2;
    }
    return self;
}

@end
