//
//  SWTurnManager.h
//  SWCards
//
//  Created by songlong on 16/6/1.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SWTurnManager;

@protocol SWTurnManagerDelegate <NSObject>

@optional

- (void)didChangeTurn:(SWTurnManager *)manager;

@end

@interface SWTurnManager : NSObject

@property (nonatomic, weak) id<SWTurnManagerDelegate>delegate;

@property (nonatomic, assign) BOOL isMyTurn;

@property (nonatomic, assign) NSInteger currentTurn;

- (void)startRandomly;
- (void)endTurn;

@end
