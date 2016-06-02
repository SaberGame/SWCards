//
//  SWBattleViewController.m
//  SWCards
//
//  Created by songlong on 16/5/27.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWBattleViewController.h"
#import <Masonry.h>
#import <MJExtension.h>
#import <MBProgressHUD.h>
#import "SWCurrentPlayer.h"
#import "SWEasyAI.h"
#import "SWDeck.h"
#import "SWHero.h"
#import "SWCard.h"
#import "SWHandCardCell.h"
#import "SWManaView.h"
#import "SWTurnManager.h"
#import "SWDrawLineView.h"

@interface SWBattleViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, SWTurnManagerDelegate>

@property (nonatomic, strong) UICollectionView *playerCollectionView;
@property (nonatomic, strong) UICollectionView *opponentCollectionView;

@property (nonatomic, strong) NSMutableArray *playerHands;
@property (nonatomic, strong) NSMutableArray *opponentHands;

@property (nonatomic, strong) UICollectionView *playerBattleGround;
@property (nonatomic, strong) UICollectionView *opponentBattleGround;

@property (nonatomic, strong) NSMutableArray *playerBattleArray;
@property (nonatomic, strong) NSMutableArray *opponentBattleArray;

@property (nonatomic, strong) SWManaView *playerManaView;
@property (nonatomic, strong) SWManaView *opponentManaView;

@property (nonatomic, strong) UILabel *playerCardsLeftLabel;
@property (nonatomic, strong) UILabel *opponentCardsLeftLabel;

@property (nonatomic, strong) SWTurnManager *turnManager;

@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;

@property (nonatomic, assign) BOOL playerAttack;
@property (nonatomic, assign) BOOL opponentAttack;

@property (nonatomic, strong) SWCard *attackCard;
@property (nonatomic, strong) SWCard *defenseCard;

@property (nonatomic, assign) NSInteger attackIndex;
@property (nonatomic, assign) NSInteger defenseIndex;

@end

@implementation SWBattleViewController

- (instancetype)init {
    if (self = [super init]) {
        _playerDeck = [[SWDeck alloc] init];
        _opponentDeck = [[SWDeck alloc] init];
        _playerHands = [NSMutableArray array];
        _opponentHands = [NSMutableArray array];
        _playerBattleArray = [NSMutableArray array];
        _opponentBattleArray = [NSMutableArray array];
        
        _turnManager = [[SWTurnManager alloc] init];
        _turnManager.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self getOpeningHand];
}

#pragma mark --- Private Method

- (void)setupUI {
    self.view.backgroundColor = [UIColor grayColor];
    [self setupPlayerArea];
    [self setupOpponentArea];
    [self setupEndTurnButton];
}

- (void)endTurn {
    [_turnManager endTurn];
}

- (void)getOpeningHand {
    
    _opponentCollectionView.userInteractionEnabled = NO;
    __weak typeof(self) weakself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakself bothDrawCards];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself bothDrawCards];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself bothDrawCards];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself.turnManager startRandomly];
                    weakself.opponentCollectionView.userInteractionEnabled = YES;
                });
            });
        });
    });
}

- (void)bothDrawCards {
    [self playerDrawCard];
    [self opponentDrawCard];
}

- (void)opponentDrawCard {
    [_opponentHands addObject:[_opponentDeck drawCard]];
    [_opponentCollectionView reloadData];
    _opponentCardsLeftLabel.text = [NSString stringWithFormat:@"剩余: %zd张", _opponentDeck.cardsArray.count];
}

- (void)playerDrawCard {
    [_playerHands addObject:[_playerDeck drawCard]];
    [_playerCollectionView reloadData];
    _playerCardsLeftLabel.text = [NSString stringWithFormat:@"剩余: %zd张", _playerDeck.cardsArray.count];
}

- (void)setupEndTurnButton {
    UIButton *endTurnButton = [[UIButton alloc] initWithFrame:CGRectZero];
    endTurnButton.backgroundColor = [UIColor redColor];
    [endTurnButton addTarget:self action:@selector(endTurn) forControlEvents:UIControlEventTouchUpInside];
    [endTurnButton setTitle:@"End Turn" forState:UIControlStateNormal];
    [self.view addSubview:endTurnButton];
    [endTurnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.right.mas_equalTo(-50);
    }];
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
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(75, 100);
    layout.minimumLineSpacing = 10;
    _playerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _playerCollectionView.backgroundColor = [UIColor redColor];
    _playerCollectionView.delegate = self;
    _playerCollectionView.dataSource = self;
    _playerCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_playerCollectionView];
    [_playerCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.right.equalTo(playerView.mas_left);
        make.height.mas_equalTo(100);
    }];
    [_playerCollectionView registerClass:[SWHandCardCell class] forCellWithReuseIdentifier:@"playerCell"];
    
    UICollectionViewFlowLayout *layout2 = [[UICollectionViewFlowLayout alloc] init];
    layout2.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout2.itemSize = CGSizeMake(100, [UIScreen mainScreen].bounds.size.height / 2 - 100);
    layout2.minimumLineSpacing = 10;
    _playerBattleGround = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout2];
    _playerBattleGround.backgroundColor = [UIColor whiteColor];
    _playerBattleGround.delegate = self;
    _playerBattleGround.dataSource = self;
    _playerBattleGround.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_playerBattleGround];
    [_playerBattleGround mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_centerY);
        make.left.right.mas_equalTo(0);
        make.bottom.equalTo(_playerCollectionView.mas_top);
    }];
    [_playerBattleGround registerClass:[SWHandCardCell class] forCellWithReuseIdentifier:@"playerBattleGroundCell"];
    
    _playerManaView = [[SWManaView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 + 25, [UIScreen mainScreen].bounds.size.height - 25, [UIScreen mainScreen].bounds.size.width / 2 - 25, 25) andManaCount:0];
    [self.view addSubview:_playerManaView];
    
    
    _playerCardsLeftLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _playerCardsLeftLabel.text = [NSString stringWithFormat:@"剩余: %zd张", _playerDeck.cardsArray.count];
    [self.view addSubview:_playerCardsLeftLabel];
    [_playerCardsLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.equalTo(self.view.mas_centerY);
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
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(75, 100);
    layout.minimumLineSpacing = 10;
    _opponentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _opponentCollectionView.backgroundColor = [UIColor redColor];
    _opponentCollectionView.delegate = self;
    _opponentCollectionView.dataSource = self;
    _opponentCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_opponentCollectionView];
    [_opponentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.right.equalTo(opponentView.mas_left);
        make.height.mas_equalTo(100);
    }];
    [_opponentCollectionView registerClass:[SWHandCardCell class] forCellWithReuseIdentifier:@"opponentCell"];
    
    UICollectionViewFlowLayout *layout2 = [[UICollectionViewFlowLayout alloc] init];
    layout2.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout2.itemSize = CGSizeMake(100, [UIScreen mainScreen].bounds.size.height / 2 - 100);
    layout2.minimumLineSpacing = 10;
    _opponentBattleGround = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout2];
    _opponentBattleGround.backgroundColor = [UIColor whiteColor];
    _opponentBattleGround.delegate = self;
    _opponentBattleGround.dataSource = self;
    _opponentBattleGround.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_opponentBattleGround];
    [_opponentBattleGround mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_centerY);
        make.left.right.mas_equalTo(0);
        make.top.equalTo(_opponentCollectionView.mas_bottom);
    }];
    [_opponentBattleGround registerClass:[SWHandCardCell class] forCellWithReuseIdentifier:@"opponentBattleGroundCell"];
    
    _opponentManaView = [[SWManaView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 + 25, 0, [UIScreen mainScreen].bounds.size.width / 2 - 25, 25) andManaCount:0];
    [self.view addSubview:_opponentManaView];

    
    _opponentCardsLeftLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _opponentCardsLeftLabel.text = [NSString stringWithFormat:@"剩余: %zd张", _opponentDeck.cardsArray.count];
    [self.view addSubview:_opponentCardsLeftLabel];
    [_opponentCardsLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.bottom.equalTo(self.view.mas_centerY);
    }];
}

- (void)reloadBattleGround {
    [_playerBattleGround reloadData];
    [_opponentBattleGround reloadData];
}

- (void)fight {
    
    if (!_attackCard || !_defenseCard ) {
        return;
    }
    
    if (_playerAttack) {
       FightResult result = [_attackCard fightWithCard:_defenseCard];
        switch (result) {
            case Win:
            {
                [_opponentBattleArray removeObjectAtIndex:_defenseIndex];
                [self reloadBattleGround];
            }
                break;
                
            case Lose:
            {
                [_playerBattleArray removeObjectAtIndex:_attackIndex];
                [self reloadBattleGround];
            }
                break;
                
            case Draw:
            {
                [self reloadBattleGround];
            }
                break;
                
            case BothDie:
            {
                [_opponentBattleArray removeObjectAtIndex:_defenseIndex];
                [_playerBattleArray removeObjectAtIndex:_attackIndex];
                [self reloadBattleGround];
            }
                break;
        }
    }
    
    if (_opponentAttack) {
        FightResult result = [_attackCard fightWithCard:_defenseCard];
        switch (result) {
            case Win:
            {
                [_playerBattleArray removeObjectAtIndex:_defenseIndex];
                [self reloadBattleGround];
            }
                break;
                
            case Lose:
            {
                [_opponentBattleArray removeObjectAtIndex:_attackIndex];
                [self reloadBattleGround];
            }
                break;
                
            case Draw:
            {
                [self reloadBattleGround];
            }
                break;
                
            case BothDie:
            {
                [_playerBattleArray removeObjectAtIndex:_defenseIndex];
                [_opponentBattleArray removeObjectAtIndex:_attackIndex];
                [self reloadBattleGround];
            }
                break;
        }
    }
}

- (void)showNoManaMessage {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = @"魔法不足";
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2.0];
}

- (void)resetFightStatus {
    _attackCard = nil;
    _defenseCard = nil;
    _opponentAttack = NO;
    _playerAttack = NO;
    for (SWHandCardCell *cell in [_playerBattleGround visibleCells]) {
        cell.isSelected = NO;
    }
    for (SWHandCardCell *cell in [_opponentBattleGround visibleCells]) {
        cell.isSelected = NO;
    }
}

#pragma mark --- UICollectionViewDelegate / DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == _playerCollectionView) {
        return _playerHands.count;
    } else if (collectionView == _opponentCollectionView) {
        return _opponentHands.count;
    } else if (collectionView == _playerBattleGround) {
        return _playerBattleArray.count;
    } else {
        return _opponentBattleArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == _playerCollectionView) {
        SWHandCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"playerCell" forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor orangeColor];
        SWCard *card = _playerHands[indexPath.item];
        cell.card = card;
        return cell;
    } else if (collectionView == _opponentCollectionView) {
        SWHandCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"opponentCell" forIndexPath:indexPath];
        SWCard *card = _opponentHands[indexPath.item];
        cell.contentView.backgroundColor = [UIColor orangeColor];
        cell.card = card;
        return cell; 
    } else if (collectionView == _playerBattleGround) {
        SWHandCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"playerBattleGroundCell" forIndexPath:indexPath];
        SWCard *card = _playerBattleArray[indexPath.item];
        cell.contentView.backgroundColor = [UIColor orangeColor];
        cell.card = card;
        return cell;
    } else {
        SWHandCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"opponentBattleGroundCell" forIndexPath:indexPath];
        SWCard *card = _opponentBattleArray[indexPath.item];
        cell.contentView.backgroundColor = [UIColor orangeColor];
        cell.card = card;
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == _playerCollectionView && _turnManager.isMyTurn) {
        
        SWCard *card = _playerHands[indexPath.item];
        SWCard *tempCard = [card copy];
        if (tempCard.manaCost <= _playerManaView.manaLeft) {
            [_playerManaView costMana:tempCard.manaCost];
            [_playerHands removeObjectAtIndex:indexPath.item];
            [_playerBattleArray addObject:tempCard];
            [_playerCollectionView reloadData];
            [_playerBattleGround reloadData];
        } else {
            [self showNoManaMessage];
        }
        
    } else if (collectionView == _opponentCollectionView && !_turnManager.isMyTurn) {
        SWCard *card = _opponentHands[indexPath.item];
        SWCard *tempCard = [card copy];
        if (tempCard.manaCost <= _opponentManaView.manaLeft) {
            [_opponentManaView costMana:tempCard.manaCost];
            [_opponentHands removeObjectAtIndex:indexPath.item];
            [_opponentBattleArray addObject:tempCard];
            [_opponentCollectionView reloadData];
            [_opponentBattleGround reloadData];
        } else {
            [self showNoManaMessage];
        }
    }
    else if (collectionView == _playerBattleGround && (_turnManager.isMyTurn || _opponentAttack)) {
        
        if (_opponentAttack) {
            CGFloat height = [UIScreen mainScreen].bounds.size.height / 2 - 100;
            _endPoint = CGPointMake((indexPath.item + 1) * 110 - 60, [UIScreen mainScreen].bounds.size.height / 2 + height / 2);
            SWDrawLineView *drawLineView = [[SWDrawLineView alloc] initWithFrame:[UIScreen mainScreen].bounds startPoint:_startPoint endPoint:_endPoint];
            [self.view addSubview:drawLineView];
            [drawLineView drawLine];
            _defenseCard = _playerBattleArray[indexPath.item];
            _defenseIndex = indexPath.item;
            [self fight];
            [self resetFightStatus];
        } else {
            SWHandCardCell *cell = (SWHandCardCell *)[_playerBattleGround cellForItemAtIndexPath:indexPath];
            cell.isSelected = !cell.isSelected;
            CGFloat height = [UIScreen mainScreen].bounds.size.height / 2 - 100;
            _startPoint = CGPointMake((indexPath.item + 1) * 110 - 60, [UIScreen mainScreen].bounds.size.height / 2 + height / 2);
            _playerAttack = cell.isSelected;
            _attackCard = _playerAttack ? _playerBattleArray[indexPath.item] : nil;
            _attackIndex = indexPath.item;
        }
    } else if (collectionView == _opponentBattleGround && (!_turnManager.isMyTurn || _playerAttack)){
        if (_playerAttack) {
            CGFloat height = [UIScreen mainScreen].bounds.size.height / 2 - 100;
            _endPoint = CGPointMake((indexPath.item + 1) * 110 - 60, 100 + height / 2);
            SWDrawLineView *drawLineView = [[SWDrawLineView alloc] initWithFrame:[UIScreen mainScreen].bounds startPoint:_startPoint endPoint:_endPoint];
            [self.view addSubview:drawLineView];
            [drawLineView drawLine];
            _defenseCard = _opponentBattleArray[indexPath.item];
            _defenseIndex = indexPath.item;
            [self fight];
            [self resetFightStatus];
        } else {
            SWHandCardCell *cell = (SWHandCardCell *)[_opponentBattleGround cellForItemAtIndexPath:indexPath];
            cell.isSelected = !cell.isSelected;
            CGFloat height = [UIScreen mainScreen].bounds.size.height / 2 - 100;
            _startPoint = CGPointMake((indexPath.item + 1) * 110 - 60, 100 + height / 2);
            _opponentAttack = cell.isSelected;
            _attackCard = _opponentAttack ? _opponentBattleArray[indexPath.item] : nil;
            _attackIndex = indexPath.item;
        }
    }
}



#pragma mark --- SWTurnManagerDelegate

- (void)didChangeTurn:(SWTurnManager *)manager {
    
    [self resetFightStatus];
    
    if (manager.isMyTurn) {
        [_playerManaView increaseManaTo:manager.currentTurn];
        [self playerDrawCard];
    } else {
        [_opponentManaView increaseManaTo:manager.currentTurn];
        [self opponentDrawCard];
    }
}

@end
