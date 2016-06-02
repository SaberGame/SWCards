//
//  SWHandCardCell.m
//  SWCards
//
//  Created by songlong on 16/5/31.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWHandCardCell.h"
#import "SWCard.h"
#import <Masonry.h>

@interface SWHandCardCell()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *defenseLabel;

@end

@implementation SWHandCardCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _isSelected = NO;
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:_iconView];
        
        _defenseLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _defenseLabel.backgroundColor = [UIColor purpleColor];
        _defenseLabel.textAlignment = NSTextAlignmentCenter;
        [_iconView addSubview:_defenseLabel];
        [_defenseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_equalTo(0);
            make.width.equalTo(_iconView.mas_width).multipliedBy(0.3);
            make.height.equalTo(_iconView.mas_height).multipliedBy(0.3);
        }];
    }
    return self;
}

- (void)setCard:(SWCard *)card {
    _card = card;
    _iconView.image = [UIImage imageNamed:card.cardImageName];
    _defenseLabel.text = [NSString stringWithFormat:@"%zd", card.defense];
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (isSelected) {
        self.contentView.layer.borderWidth = 5;
        self.contentView.layer.borderColor = [UIColor redColor].CGColor;
    } else {
        self.contentView.layer.borderWidth = 0;
        self.contentView.layer.borderColor = nil;
    }
}

@end
