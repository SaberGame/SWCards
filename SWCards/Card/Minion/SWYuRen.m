//
//  SWYuRen.m
//  SWCards
//
//  Created by songlong on 16/5/30.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWYuRen.h"

@implementation SWYuRen

- (instancetype)init {
    if (self = [super init]) {
        self.cardName = @"鱼人";
        self.cardImageName = @"鱼人";
        self.attack = 1;
        self.defense = 1;
        self.manaCost = 1;
    }
    return self;
}

@end
