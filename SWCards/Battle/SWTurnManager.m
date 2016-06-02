//
//  SWTurnManager.m
//  SWCards
//
//  Created by songlong on 16/6/1.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWTurnManager.h"
#import <UIKit/UIKit.h>
#import <Masonry.h>

#define kTurnSeconds 20

@interface SWTurnManager()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger changeTurnCount;

@property (nonatomic, strong) UILabel *countDownLabel;

@end

@implementation SWTurnManager


- (void)startRandomly {
    int randomNumber = arc4random() % 100;
    _isMyTurn = randomNumber % 2 == 0;
    _currentTurn = 1;
    [self showTurnInfoWithTurn:_isMyTurn];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeIncrease) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer fire];
}

- (void)timeIncrease {
    _count++;
    
    if (_count == kTurnSeconds - 10) {
        [self countDown];
    }
    
    if (_countDownLabel) {
        _countDownLabel.text = [NSString stringWithFormat:@"%zd", kTurnSeconds - _count];
    }
    
    
    if (_count == kTurnSeconds) {
        [self endTurn];
    }
}

- (void)endTurn {
    
    if (_countDownLabel) {
        [_countDownLabel removeFromSuperview];
    }
    
    _changeTurnCount++;
    if (_changeTurnCount == 2) {
        _changeTurnCount = 0;
        _currentTurn++;
    }
    
    _isMyTurn = !_isMyTurn;
    [self showTurnInfoWithTurn:_isMyTurn];
    _count = 0;
}

- (void)showTurnInfoWithTurn:(BOOL)isMyTurn {
    
    if ([self.delegate respondsToSelector:@selector(didChangeTurn:)]) {
        [self.delegate didChangeTurn:self];
    }
    
    UILabel *turnLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 4, [UIScreen mainScreen].bounds.size.height / 4, [UIScreen mainScreen].bounds.size.width  / 2, [UIScreen mainScreen].bounds.size.height / 2)];
    turnLabel.backgroundColor = [UIColor blueColor];
    turnLabel.textColor = [UIColor whiteColor];
    turnLabel.text = isMyTurn ? @"My Turn" : @"Opponent's Turn";
    turnLabel.textAlignment = NSTextAlignmentCenter;
    turnLabel.font = [UIFont systemFontOfSize:30];
    turnLabel.userInteractionEnabled = NO;
    [[[[UIApplication sharedApplication] delegate] window] addSubview:turnLabel];
    
    turnLabel.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        turnLabel.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            turnLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [turnLabel removeFromSuperview];
        }];
    }];
}

- (void)countDown {
    _countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 4, [UIScreen mainScreen].bounds.size.height / 4, [UIScreen mainScreen].bounds.size.width  / 2, [UIScreen mainScreen].bounds.size.height / 2)];
    _countDownLabel.backgroundColor = [UIColor clearColor];
    _countDownLabel.textColor = [UIColor redColor];
    _countDownLabel.textAlignment = NSTextAlignmentCenter;
    _countDownLabel.font = [UIFont systemFontOfSize:40];
    _countDownLabel.userInteractionEnabled = NO;
    [[[[UIApplication sharedApplication] delegate] window] addSubview:_countDownLabel];
    
}

@end
