//
//  SWShiQuanShiRenMo.m
//  SWCards
//
//  Created by songlong on 16/5/30.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWShiQuanShiRenMo.h"

@implementation SWShiQuanShiRenMo

- (instancetype)init {
    if (self = [super init]) {
        self.cardName = @"石拳食人魔";
        self.cardImageName = @"石拳食人魔";
        self.attack = 6;
        self.defense = 6;
        self.manaCost = 7;
    }
    return self;
}

@end
