//
//  SWDeck.h
//  SWCards
//
//  Created by songlong on 16/5/23.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SWHero;

@interface SWDeck : NSObject

@property (nonatomic, strong) NSArray *cardsArray;

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *deckName;

@property (nonatomic, strong) SWHero *deckHero;

@end