//
//  SWYeZhu.m
//  SWCards
//
//  Created by songlong on 16/5/26.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWYeZhu.h"

@implementation SWYeZhu

- (instancetype)init {
    if (self = [super init]) {
        self.cardName = @"野猪";
        self.cardImageName = @"野猪";
        self.attack = 1;
        self.defense = 1;
        self.manaCost = 1;
    }
    return self;
}

@end
