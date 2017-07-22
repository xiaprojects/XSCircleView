//
//  XSCircleView.m
//  XSCircleView
//
//  Created by Stefano Zingarini on 22/07/2017.
//  Copyright © 2017 XIAPROJECTS. All rights reserved.
//

#import "XSCircleView.h"

@interface XSCircleView ()
@property (strong, nonatomic) CAShapeLayer *baseCircle;
@property (strong, nonatomic) NSTimer *animator;
@end

@implementation XSCircleView
+(void)importThisClassToBinary{}
+(float)degreeToRadiant:(float)degree
{
    return degree*(2*M_PI)/360.0;
}
-(void)layoutSubviews
{
    [self reDrawShape];
    [super layoutSubviews];
}

-(void)setStartAngle:(float)radiant
{
    _startAngle=radiant;
}
-(void)setEndAngle:(float)radiant
{
    _endAngle=radiant;
}
-(void)setLineWidth:(float)pixels
{
    _lineWidth=pixels;
}

-(void)reDrawShape
{
    
    [self.baseCircle removeFromSuperlayer];
    self.baseCircle = [CAShapeLayer new];
    float minWH=self.bounds.size.width;
    if(minWH>self.bounds.size.height)minWH=self.bounds.size.height;
    float radius=minWH/2.0;
    if(_lineWidth>0)
    {
        radius-=_lineWidth;
    }
    self.baseCircle.path = [UIBezierPath bezierPathWithArcCenter:
                            CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)
                                                          radius:radius
                                                      startAngle:_startAngle
                                                        endAngle:_endAngle
                                                       clockwise:YES].CGPath;
    
    self.baseCircle.fillColor = self.fillColor.CGColor;
    self.baseCircle.strokeColor = self.strokeColor.CGColor;
    self.baseCircle.lineWidth = _lineWidth;
    
    [self.layer addSublayer:self.baseCircle];
}
-(void)animateToAngle:(float)radiant completionHandler:(void (^)(XSCircleView *object))completion
{
    _animatingToAngle=radiant;
    [[self animator] invalidate];
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:0.05 repeats:YES block:^(NSTimer *t)
    {
        float diff=_endAngle-_animatingToAngle;
        float s=sqrtf(diff*diff);
        if(s<.01 || s>M_PI*2.0)
        {
            _endAngle=_animatingToAngle;
            [self performSelectorOnMainThread:@selector(reDrawShape) withObject:nil waitUntilDone:NO];
            [[self animator] invalidate];
            [self setAnimator:nil];
            if(completion)completion(self);
        }
        else
        {
            if(diff>0.04)
            {
                diff=0.04;
            }
            else
            {
                if(diff<-0.04)
                {
                    diff=-0.04;
                }
                else
                {
                }

            }
            _endAngle-=diff;
            [self performSelectorOnMainThread:@selector(reDrawShape) withObject:nil waitUntilDone:NO];
        }
    }];
    [self setAnimator:timer];
}
@end
