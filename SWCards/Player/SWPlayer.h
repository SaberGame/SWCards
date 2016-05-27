//
//  SWPlayer.h
//  SWCards
//
//  Created by songlong on 16/5/27.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SWDeck;

@interface SWPlayer : NSObject

@property (nonatomic, strong) NSArray *allDecks;
@property (nonatomic, strong) SWDeck *currentDeck;
@property (nonatomic, copy) NSString *playerName;
@property (nonatomic, copy) NSString *playerImageName;

@end
