//
//  SWDrawLineView.m
//  SWCards
//
//  Created by songlong on 16/6/1.
//  Copyright © 2016年 SaberGame. All rights reserved.
//

#import "SWDrawLineView.h"
#import <math.h>

#define kArrowLength 30

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
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:_endPoint];
    [path2 addLineToPoint:[self leftPoinWithStartPoint:_startPoint andEndPoint:_endPoint]];
    [[UIColor greenColor]set];
    [path2 setLineWidth:5];
    [path2 stroke];
    
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:_endPoint];
    [path3 addLineToPoint:[self rightPoinWithStartPoint:_startPoint andEndPoint:_endPoint]];
    [[UIColor greenColor]set];
    [path3 setLineWidth:5];
    [path3 stroke];
}

- (CGPoint)leftPoinWithStartPoint:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint {
    
    CGFloat x = endPoint.x - startPoint.x;
    CGFloat y = endPoint.y - startPoint.y;
    double angle = atan(y / x) - atan(1.0);
    return CGPointMake(endPoint.x - cos(angle) * kArrowLength, endPoint.y - sin(angle) * kArrowLength);
}

- (CGPoint)rightPoinWithStartPoint:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint {
    
    CGFloat x = endPoint.x - startPoint.x;
    CGFloat y = endPoint.y - startPoint.y;
    double angle = atan(y / x) - atan(1.0);
    return CGPointMake(endPoint.x + sin(angle) * kArrowLength, endPoint.y - cos(angle) * kArrowLength);
}



@end
