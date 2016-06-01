//
//  SWHandCardCell.m
//  SWCards
//
//  Created by songlong on 16/5/31.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWHandCardCell.h"
#import "SWCard.h"

@interface SWHandCardCell()

@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation SWHandCardCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:_iconView];
    }
    return self;
}

- (void)setCard:(SWCard *)card {
    _card = card;
    _iconView.image = [UIImage imageNamed:card.cardImageName];
}

@end
