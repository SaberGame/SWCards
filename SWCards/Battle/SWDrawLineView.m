//
//  SWDrawLineView.m
//  SWCards
//
//  Created by songlong on 16/6/1.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWDrawLineView.h"

@interface SWDrawLineView()

@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;

@end

@implementation SWDrawLineView

- (instancetype)initWithFrame:(CGRect)frame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
        _startPoint = startPoint;
        _endPoint = endPoint;
    }
    return self;
}

- (void)drawLine {
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_startPoint];
    [path addLineToPoint:_endPoint];
    [[UIColor greenColor]set];
    [path setLineWidth:5];
    [path stroke];
    
}



@end
