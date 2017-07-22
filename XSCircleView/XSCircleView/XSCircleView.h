//
//  XSCircleView.h
//  XSCircleView
//
//  Created by Stefano Zingarini on 22/07/2017.
//  Copyright © 2017 XIAPROJECTS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSCircleView : UIView
{
    float _startAngle;
    float _endAngle;
    float _lineWidth;
    float _animatingToAngle;
}
+(float)degreeToRadiant:(float)degree;
+(void)importThisClassToBinary;
-(void)reDrawShape;
-(void)setStartAngle:(float)radiant;
-(void)setEndAngle:(float)radiant;
-(void)setLineWidth:(float)pixels;
-(void)animateToAngle:(float)radiant completionHandler:(void (^)(XSCircleView *object))completion;
@property (strong, nonatomic) UIColor *fillColor;
@property (strong, nonatomic) UIColor *strokeColor;

@end
