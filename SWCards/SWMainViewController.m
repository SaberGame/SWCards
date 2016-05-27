//
//  SWMainViewController.m
//  SWCards
//
//  Created by songlong on 16/5/17.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWMainViewController.h"
#import <Masonry.h>
#import "SWCollectionViewController.h"
#import "SWBattleViewController.h"

@interface SWMainViewController ()

@end

@implementation SWMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    UIButton *collectionButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [collectionButton setTitle:@"My Collection" forState:UIControlStateNormal];
    [collectionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [collectionButton addTarget:self action:@selector(clickCollectionButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectionButton];
    [collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(-10);
    }];
    
    UIButton *boosterPackButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [boosterPackButton setTitle:@"Booster Pack" forState:UIControlStateNormal];
    [boosterPackButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:boosterPackButton];
    [boosterPackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.equalTo(collectionButton.mas_top).offset(-10);
    }];
    
    UIButton *shopButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [shopButton setTitle:@"Shop" forState:UIControlStateNormal];
    [shopButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:shopButton];
    [shopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.left.mas_equalTo(10);
    }];
    
    UIButton *questButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [questButton setTitle:@"Quest" forState:UIControlStateNormal];
    [questButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:questButton];
    [questButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.equalTo(shopButton.mas_top).offset(-10);
    }];
    
    UIButton *battleButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [battleButton setTitle:@"Battle" forState:UIControlStateNormal];
    [battleButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [battleButton addTarget:self action:@selector(clickBattle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:battleButton];
    [battleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
}

- (void)clickCollectionButton {
    SWCollectionViewController *vc = [[SWCollectionViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)clickBattle {
    SWBattleViewController *vc = [[SWBattleViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
