//
//  SWSelectHeroView.h
//  SWCards
//
//  Created by songlong on 16/5/23.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWHero;

@interface SWSelectHeroView : UIView

- (instancetype)initWithFrame:(CGRect)frame andBlock:(void(^)(SWHero *hero))block;

@end
