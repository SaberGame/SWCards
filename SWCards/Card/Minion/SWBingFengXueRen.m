//
//  SWBingFengXueRen.m
//  SWCards
//
//  Created by songlong on 16/5/30.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWBingFengXueRen.h"

@implementation SWBingFengXueRen

- (instancetype)init {
    if (self = [super init]) {
        self.cardName = @"冰风雪人";
        self.cardImageName = @"冰风雪人";
        self.attack = 4;
        self.defense = 5;
        self.manaCost = 4;
    }
    return self;
}

@end
