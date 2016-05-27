//
//  SWBattleViewController.m
//  SWCards
//
//  Created by songlong on 16/5/27.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWBattleViewController.h"
#import <Masonry.h>
#import "SWCurrentPlayer.h"
#import "SWEasyAI.h"
#import "SWDeck.h"
#import "SWHero.h"

@interface SWBattleViewController ()

@end

@implementation SWBattleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor grayColor];
    
    [self setupPlayerArea];
    [self setupOpponentArea];
}

- (void)setupPlayerArea {
    SWCurrentPlayer *player = [[SWCurrentPlayer alloc] init];
    UIImageView *playerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:player.playerImageName]];
    [self.view addSubview:playerView];
    [playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.height.width.mas_equalTo(50);
    }];
    
    UILabel *playerLifeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    playerLifeLabel.textColor = [UIColor redColor];
    playerLifeLabel.text = [NSString stringWithFormat:@"%zd", player.currentDeck.deckHero.heroLife];
    [self.view addSubview:playerLifeLabel];
    [playerLifeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(playerView.mas_top);
        make.centerX.mas_equalTo(0);
    }];
}

- (void)setupOpponentArea {
    SWEasyAI *opponent = [[SWEasyAI alloc] init];
    UIImageView *opponentView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:opponent.playerImageName]];
    [self.view addSubview:opponentView];
    [opponentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.height.width.mas_equalTo(50);
    }];
    
    UILabel *opponentLifeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    opponentLifeLabel.textColor = [UIColor redColor];
    opponentLifeLabel.text = [NSString stringWithFormat:@"%zd", opponent.currentDeck.deckHero.heroLife];
    [self.view addSubview:opponentLifeLabel];
    [opponentLifeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(opponentView.mas_bottom);
        make.centerX.mas_equalTo(0);
    }];
}


@end
