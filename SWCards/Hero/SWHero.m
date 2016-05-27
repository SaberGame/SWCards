//
//  SWHero.m
//  SWCards
//
//  Created by songlong on 16/5/23.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWHero.h"

@implementation SWHero

+ (NSArray *)allHeros {
    
    NSMutableArray *herosArray = [NSMutableArray array];
    NSArray *array = @[@"SWMage", @"SWWarrior"];
    
    for (NSString *name in array) {
        SWHero *hero = [[NSClassFromString(name) alloc] init];
        [herosArray addObject:hero];
    }
    
    return herosArray;
}

- (instancetype)init {
    if (self = [super init]) {
        self.heroLife = 30;
    }
    return self;
}

@end
