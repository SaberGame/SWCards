//
//  SWDeckSelectViewController.m
//  SWCards
//
//  Created by songlong on 16/5/31.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWDeckSelectViewController.h"
#import <Masonry.h>
#import <MJExtension.h>
#import "SWDeck.h"
#import "SWCard.h"
#import "SWBattleViewController.h"

@interface SWDeckSelectViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *deckArray;

@end

@implementation SWDeckSelectViewController

- (instancetype)init {
    if (self = [super init]) {
        NSArray *jsonArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"kDeckArray"];
        _deckArray = [SWDeck mj_objectArrayWithKeyValuesArray:jsonArray];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tempView];
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width * 0.75);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = [UIColor redColor];
    titleLabel.text = @"Please select a deck";
    [tempView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin = 10;
    NSInteger count = 3;
    CGFloat w = ([UIScreen mainScreen].bounds.size.width * 0.75 - (count + 1) * margin) / count;
    CGFloat h = ([UIScreen mainScreen].bounds.size.height - 25 - (count + 1) * margin) / count;
    layout.itemSize = CGSizeMake(w, h);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor blueColor];
    [tempView addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.top.equalTo(titleLabel.mas_bottom);
    }];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"deckSelectCell"];
}

#pragma  mark --- UICollectionViewDelegate / DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _deckArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"deckSelectCell" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor greenColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SWBattleViewController *vc = [[SWBattleViewController alloc] init];
    
    SWDeck *deck = _deckArray[indexPath.item];
    deck.cardsArray = [SWCard mj_objectArrayWithKeyValuesArray:deck.cardsArray];
    vc.playerDeck = deck;
    
    SWDeck *opponentDeck = _deckArray.firstObject;
    opponentDeck.cardsArray = [SWCard mj_objectArrayWithKeyValuesArray:opponentDeck.cardsArray];
    vc.opponentDeck = opponentDeck;
    
    [self presentViewController:vc animated:YES completion:nil];
}


@end
