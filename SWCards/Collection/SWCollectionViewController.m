//
//  SWCollectionViewController.m
//  SWCards
//
//  Created by songlong on 16/5/23.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWCollectionViewController.h"
#import <Masonry.h>
#import <MJExtension.h>
#import "SWSelectHeroView.h"
#import "SWHero.h"
#import "SWCard.h"
#import "SWDeckCard.h"
#import "SWDeck.h"


static NSString *const poolCellId = @"poolCellId";

@interface SWCollectionViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *deckListTableView;
@property (nonatomic, strong) UITableView *cardListTableView;
@property (nonatomic, strong) UICollectionView *poolCollectionView;

@property (nonatomic, strong) NSArray *decksArray;
@property (nonatomic, strong) NSMutableArray *cardsArray;
@property (nonatomic, strong) NSArray *pool;
@property (nonatomic, strong) NSMutableArray *deckCardsArray;

@end

@implementation SWCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _deckListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _deckListTableView.delegate = self;
    _deckListTableView.dataSource = self;
    [self.view addSubview:_deckListTableView];
    [_deckListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(0);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width / 5);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin = 5;
    NSInteger count = 4;
    CGFloat w = ([UIScreen mainScreen].bounds.size.width / 5 * 4 - (count + 1) * margin) / count;
    CGFloat h = ([UIScreen mainScreen].bounds.size.height - (2 + 1) * margin) / 2;
    layout.itemSize = CGSizeMake(w, h);
    layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _poolCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 5 * 4, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
    _poolCollectionView.backgroundColor = [UIColor greenColor];
    _poolCollectionView.delegate = self;
    _poolCollectionView.dataSource = self;
    
    [self.view addSubview:_poolCollectionView];
    [_poolCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:poolCellId];
}

#pragma mark --- UITableViewDelegate / DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _deckListTableView) {
        NSArray *jsonArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"kDeckArray"];
        NSMutableArray *deckArray = [[SWDeck mj_objectArrayWithKeyValuesArray:jsonArray] mutableCopy];
        return deckArray.count;
    } else {
        return _deckCardsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _deckListTableView) {
        static NSString *resuseID = @"collectionCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: resuseID];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"deck%zd", indexPath.row + 1];
        
        return cell;
    } else {
        static NSString *resuseID = @"collectionCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: resuseID];
        }
        
        SWDeckCard *deckCard = _deckCardsArray[indexPath.row];
        
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@  x %zd", deckCard.card.cardName, deckCard.count];
        
        
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (tableView == _cardListTableView) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 5, 50)];
        UIButton *commitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 10, 50)];
        [commitButton setTitle:@"确定" forState:UIControlStateNormal];
        [commitButton setBackgroundColor:[UIColor greenColor]];
        [commitButton addTarget:self action:@selector(commitDeck) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:commitButton];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 10, 0, [UIScreen mainScreen].bounds.size.width / 10, 50)];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setBackgroundColor:[UIColor greenColor]];
        [cancelButton addTarget:self action:@selector(cancelDeck) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:cancelButton];
        return footerView;
    }
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 5, 50)];
    UIButton *createDeckButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [createDeckButton setTitle:@"Create Deck" forState:UIControlStateNormal];
    [createDeckButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [createDeckButton addTarget:self action:@selector(createDeck) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:createDeckButton];
    [createDeckButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (tableView == _deckListTableView) {
        return nil;
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    headerView.backgroundColor = [UIColor orangeColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _deckListTableView) {
        return 0;
    }
    return 50;
}

#pragma mark -- Private Method

- (void)commitDeck {
    SWDeck *newDeck = [[SWDeck alloc] init];
    newDeck.cardsArray = _cardsArray;
    newDeck.deckName = @"new deck";
    
    NSMutableArray *deckArray = [NSMutableArray array];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"kDeckArray"]) {
        
    } else {
        NSArray *jsonArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"kDeckArray"];
        deckArray = [[SWDeck mj_objectArrayWithKeyValuesArray:jsonArray] mutableCopy];
    }
    [deckArray addObject:newDeck];
    
    NSArray *jsonArray = [SWDeck mj_keyValuesArrayWithObjectArray:deckArray];
    
    [[NSUserDefaults standardUserDefaults] setObject:jsonArray forKey:@"kDeckArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [_cardListTableView removeFromSuperview];
    [_deckListTableView reloadData];
}

- (void)createDeck {
    __weak typeof(self) weakself = self;
    _cardsArray = [NSMutableArray array];
    _deckCardsArray = [NSMutableArray array];
    SWSelectHeroView *selectHeroView = [[SWSelectHeroView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - [UIScreen mainScreen].bounds.size.height / 2, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.height) andBlock:^(SWHero *hero) {
        [weakself createDecKWithHero:hero];
    }];
    [self.view addSubview:selectHeroView];
}

- (void)createDecKWithHero:(SWHero *)hero {
    _cardListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _cardListTableView.delegate = self;
    _cardListTableView.dataSource = self;
    [self.view addSubview:_cardListTableView];
    [_cardListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(0);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width / 5);
    }];
}

#pragma mark --- UICollectionViewDelegate / DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pool.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath  {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:poolCellId forIndexPath:indexPath];
    
    SWCard *card = _pool[indexPath.item];
    
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:card.cardImageName]];
    [cell.contentView addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    cell.contentView.backgroundColor = [UIColor blueColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SWCard *card = _pool[indexPath.item];

    if (_cardsArray.count <= [SWDeck deckCapacity]) {
        for (SWDeckCard *deckCard in _deckCardsArray) {
            if ([deckCard.card.cardName isEqualToString:card.cardName]) {
                if (deckCard.count == 1) {
                    deckCard.count = 2;
                    [_cardsArray addObject:card];
                    [_cardListTableView reloadData];
                    NSLog(@"%zd", _cardsArray.count);
                    return;
                } else if (deckCard.count == 2) {
                    return;
                }
             }
        }
        
        SWDeckCard *deckCard = [[SWDeckCard alloc] init];
        deckCard.count = 1;
        deckCard.card = card;
        [_deckCardsArray addObject:deckCard];
        [_cardsArray addObject:card];
        [_cardListTableView reloadData];
        NSLog(@"%zd", _cardsArray.count);
    }
}

#pragma mark --- Lazy Loading

- (NSArray *)pool {
    if (!_pool) {
        _pool = [SWCard allCards];
    }
    return _pool;
}

@end
