//
//  SWGameManager.h
//  SWCards
//
//  Created by songlong on 16/6/2.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWGameManager : NSObject

//最高法力水晶数量
+ (NSInteger)maximumMana;

//每回合的时间（单位秒）
+ (NSInteger)turnSeconds;

//回合倒计时开始时间
+ (NSInteger)countDownTime;

@end
