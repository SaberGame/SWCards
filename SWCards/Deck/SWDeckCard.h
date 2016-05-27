//
//  SWDeckCard.h
//  SWCards
//
//  Created by songlong on 16/5/27.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SWCard;

@interface SWDeckCard : NSObject

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) SWCard *card;

@end
