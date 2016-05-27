//
//  SWSelectHeroView.m
//  SWCards
//
//  Created by songlong on 16/5/23.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWSelectHeroView.h"
#import "SWHero.h"

@interface SWSelectHeroView()

@property (nonatomic, copy) void (^clickBlock)(SWHero *hero);

@end

@implementation SWSelectHeroView

- (instancetype)initWithFrame:(CGRect)frame andBlock:(void(^)(SWHero *hero))block {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        NSArray *heroArray = [SWHero allHeros];
        CGFloat margin = 5;
        CGFloat w = (frame.size.width - 4 * margin) / 3;
        for (int i = 0; i < 9; i++) {

            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(margin + i % 3 * (margin + w), margin + i / 3 * (margin + w), w, w)];
            if (i < heroArray.count) {
                SWHero *hero = heroArray[i];
                [button setTitle:hero.heroName forState:UIControlStateNormal];
                button.tag = i + 1;
                [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside
                 ];
            }
            button.backgroundColor = [UIColor blueColor];
            [self addSubview:button];
        }
        
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 50, 0, 50, 50)];
        closeButton.backgroundColor = [UIColor redColor];
        [closeButton addTarget:self action:@selector(clickClose) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
        
        
        self.clickBlock = ^(SWHero *hero) {
            block(hero);
        };
    }
    return self;
}

- (void)clickClose {
    [self removeFromSuperview];
}

- (void)clickButton:(UIButton *)sender {
    
    NSArray *heroArray = [SWHero allHeros];
    SWHero *hero = heroArray[sender.tag - 1];
    self.clickBlock(hero);
    [self removeFromSuperview];
}

@end
