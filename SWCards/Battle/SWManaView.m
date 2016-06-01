//
//  SWManaView.m
//  SWCards
//
//  Created by songlong on 16/6/1.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWManaView.h"
#import <Masonry.h>

@interface SWManaView()

@property (nonatomic, strong) UILabel *manaLeftLabel;
@property (nonatomic, strong) UILabel *totalManaLabel;

@end

@implementation SWManaView



- (instancetype)initWithFrame:(CGRect)frame andManaCount:(NSInteger)count {
    if (self = [super initWithFrame:frame]) {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, frame.size.height)];
        leftView.backgroundColor = [UIColor yellowColor];
        [self addSubview:leftView];
        
        _totalManaCount = count;
        _manaLeft = count;
        
        _manaLeftLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _manaLeftLabel.textAlignment = NSTextAlignmentLeft;
        _manaLeftLabel.text = [NSString stringWithFormat:@"%zd", _manaLeft];
        [leftView addSubview:_manaLeftLabel];
        [_manaLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.centerX.equalTo(leftView.mas_centerX).multipliedBy(0.5);
        }];
        
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        tempLabel.text = @"/";
        [leftView addSubview:tempLabel];
        [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
        
        _totalManaLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _totalManaLabel.textAlignment = NSTextAlignmentRight;
        _totalManaLabel.text = [NSString stringWithFormat:@"%zd", _totalManaCount];
        [leftView addSubview:_totalManaLabel];
        [_totalManaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.centerX.equalTo(leftView.mas_centerX).multipliedBy(1.5);
        }];
        
        CGFloat w = (frame.size.width - 50) / 10;
        for (int i = 0; i < 10; i++) {
            UIView *manaView = [[UIView alloc] initWithFrame:CGRectMake(50 +i * w, 0, w, frame.size.height)];
            manaView.layer.borderWidth = 2;
            manaView.tag = i + 1;
            manaView.backgroundColor = [UIColor blueColor];
            manaView.layer.borderColor = [UIColor blackColor].CGColor;
            manaView.layer.cornerRadius = 10;
            manaView.clipsToBounds = YES;
            manaView.hidden = i > count - 1;
            [self addSubview:manaView];
        }
    }
    return self;
}

- (void)costMana:(NSInteger)count {
    
    if (count <= _manaLeft) {
        if (_manaLeft == _totalManaCount) {
            _manaLeft = _totalManaCount - count;
            for (int i = 0; i < count; i++) {
                [self viewWithTag:i + 1].backgroundColor = [UIColor blackColor];
            }
        } else {
            for (int i = 0; i < count; i++) {
                [self viewWithTag:_totalManaCount - _manaLeft + i + 1].backgroundColor = [UIColor blackColor];
            }
            _manaLeft -= count;
        }
        
        _manaLeftLabel.text = [NSString stringWithFormat:@"%zd", _manaLeft];
    }
}

- (void)increaseManaTo:(NSInteger)count {
    _manaLeft = count;
    _totalManaCount = count;
    _manaLeftLabel.text = [NSString stringWithFormat:@"%zd", _manaLeft];
    _totalManaLabel.text = [NSString stringWithFormat:@"%zd", _totalManaCount];
    
    for (int i = 0; i < 10; i++) {
        
        if (i > count - 1) {
            [self viewWithTag:i + 1].hidden = YES;
        } else {
            [self viewWithTag:i + 1].hidden = NO;
            [self viewWithTag:i + 1].backgroundColor = [UIColor blueColor];
        }
    }
}

@end
