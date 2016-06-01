//
//  SWZhiZhuTanKe.m
//  SWCards
//
//  Created by songlong on 16/5/30.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWZhiZhuTanKe.h"

@implementation SWZhiZhuTanKe

- (instancetype)init {
    if (self = [super init]) {
        self.cardName = @"蜘蛛坦克";
        self.cardImageName = @"蜘蛛坦克";
        self.attack = 3;
        self.defense = 4;
        self.manaCost = 3;
    }
    return self;
}

@end
