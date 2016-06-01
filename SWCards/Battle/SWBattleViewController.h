//
//  SWBattleViewController.h
//  SWCards
//
//  Created by songlong on 16/5/27.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWDeck;

@interface SWBattleViewController : UIViewController

@property (nonatomic, strong) SWDeck *playerDeck;
@property (nonatomic, strong) SWDeck *opponentDeck;

@end
