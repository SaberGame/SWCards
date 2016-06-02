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
#import "SWDeckSelectViewController.h"


@interface SWMainViewController ()

@end

@implementation SWMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    UIImage *image = [UIImage imageNamed:@"background.jpg"];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:image];
    iconView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:iconView];
    
    UIButton *collectionButton = [[UIButton alloc] initWithFrame:CGRectZero];
    collectionButton.backgroundColor = [UIColor clearColor];
    [collectionButton addTarget:self action:@selector(clickCollectionButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectionButton];
    [collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(0);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.16);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.35);
    }];
    
    UIButton *boosterPackButton = [[UIButton alloc] initWithFrame:CGRectZero];
    boosterPackButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:boosterPackButton];
    [boosterPackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.bottom.equalTo(collectionButton.mas_top).offset(-10);
        make.height.equalTo(collectionButton.mas_height);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.3);
    }];
    
    UIButton *shopButton = [[UIButton alloc] initWithFrame:CGRectZero];
    shopButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:shopButton];
    [shopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.16);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.35);
    }];
    
    UIButton *questButton = [[UIButton alloc] initWithFrame:CGRectZero];
    questButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:questButton];
    [questButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(collectionButton.mas_height);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.3);
        make.left.mas_equalTo(0);
        make.bottom.equalTo(shopButton.mas_top).offset(-10);
    }];
    
    UIButton *battleButton = [[UIButton alloc] initWithFrame:CGRectZero];
    battleButton.backgroundColor = [UIColor clearColor];
    [battleButton addTarget:self action:@selector(clickBattle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:battleButton];
    [battleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width).multipliedBy(0.3);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.14);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo([UIScreen mainScreen].bounds.size.height * 0.26);
    }];
}

- (void)clickCollectionButton {
    SWCollectionViewController *vc = [[SWCollectionViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)clickBattle {
    SWDeckSelectViewController *vc = [[SWDeckSelectViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
