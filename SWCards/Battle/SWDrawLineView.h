//
//  SWDrawLineView.h
//  SWCards
//
//  Created by songlong on 16/6/1.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWDrawLineView : UIView

- (instancetype)initWithFrame:(CGRect)frame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

- (void)drawLine;
@end
