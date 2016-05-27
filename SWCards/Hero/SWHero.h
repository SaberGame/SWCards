//
//  SWHero.h
//  SWCards
//
//  Created by songlong on 16/5/23.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SWHero : NSObject

@property (nonatomic, copy) NSString *heroName;
@property (nonatomic, assign) NSInteger heroLife;
@property (nonatomic, copy) NSString *heroImageName;

+ (NSArray *)allHeros;

@end
