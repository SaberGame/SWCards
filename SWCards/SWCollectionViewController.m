//
//  SWCollectionViewController.m
//  SWCards
//
//  Created by songlong on 16/5/23.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWCollectionViewController.h"
#import <Masonry.h>

@interface SWCollectionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *decksArray;

@end

@implementation SWCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(0);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width / 5);
    }];
}

#pragma mark --- UITableViewDelegate / DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *resuseID = @"collectionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: resuseID];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
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

- (void)createDeck {
    
}

@end
