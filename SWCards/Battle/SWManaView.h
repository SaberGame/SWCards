//
//  SWManaView.h
//  SWCards
//
//  Created by songlong on 16/6/1.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWManaView : UIView

@property (nonatomic, assign) NSInteger manaLeft;
@property (nonatomic, assign) NSInteger totalManaCount;

- (void)costMana:(NSInteger)count;

- (void)increaseManaTo:(NSInteger)count;

- (instancetype)initWithFrame:(CGRect)frame andManaCount:(NSInteger)count;

@end
