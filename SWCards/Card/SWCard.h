//
//  SWCard.h
//  SWCards
//
//  Created by songlong on 16/5/26.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWCard : NSObject

@property (nonatomic, copy) NSString *cardName;
@property (nonatomic, assign) NSInteger manaCost;
@property (nonatomic, copy) NSString *cardType;
@property (nonatomic, copy) NSString *cardImageName;

+ (NSArray *)allCards;

@end
