//
//  SWCard.h
//  SWCards
//
//  Created by songlong on 16/5/26.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWCard : NSObject<NSCopying>

@property (nonatomic, copy) NSString *cardName;
@property (nonatomic, assign) NSInteger manaCost;
@property (nonatomic, copy) NSString *cardType;
@property (nonatomic, copy) NSString *cardImageName;


@property (nonatomic, assign) NSInteger attack;
@property (nonatomic, assign) NSInteger defense;
@property (nonatomic, copy) NSString *minionType;

+ (NSArray *)allCards;

@end
