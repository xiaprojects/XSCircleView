//
//  ViewController.m
//  XSCircleViewSampleApp
//
//  Created by Stefano Zingarini on 22/07/2017.
//  Copyright © 2017 XIAPROJECTS. All rights reserved.
//

#import "ViewController.h"
#import "../../XSCircleView/XSCircleView/XSCircleView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet XSCircleView *circleBackgroundView;
@property (weak, nonatomic) IBOutlet XSCircleView *circleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [XSCircleView importThisClassToBinary]; // Required to enable deep linking with-out the -ObjC linker flag

    [self animateTo:[NSNumber numberWithInt:0]];
    [self setupGrayBackground];
    // Do any additional setup after loading the view, typically from a nib.
    [self.circleView animateToAngle:[XSCircleView degreeToRadiant:90-90] completionHandler:^(XSCircleView *v){
        
        
        [self.circleView animateToAngle:[XSCircleView degreeToRadiant:(45-90)%361] completionHandler:^(XSCircleView *v){
            //[self.circleView animateToAngle:[XSCircleView degreeToRadiant:(270-90)%361] completionHandler:^(XSCircleView *v){}];

        }];

        
    }];
}
/*
-(void)startAnimating:(NSNumber *)nextDegree
{
    [self animateTo:nextDegree];
    [self performSelector:@selector(startAnimating:) withObject:[NSNumber numberWithLong:nextDegree.longValue+1] afterDelay:0.1];
}
 */

-(void)animateTo:(NSNumber *)degree
{
    [[self circleView] setStrokeColor:[UIColor cyanColor]];
    [[self circleView] setFillColor:[UIColor clearColor]];
    [[self circleView] setLineWidth:4.0];
    [[self circleView] setStartAngle:[XSCircleView degreeToRadiant:-90]];
    [[self circleView] setEndAngle:[XSCircleView degreeToRadiant:(degree.integerValue-90)%360]];
    [[self circleView] reDrawShape];

}
-(void)setupGrayBackground
{
    [[self circleBackgroundView] setStrokeColor:[UIColor grayColor]];
    [[self circleBackgroundView] setFillColor:[UIColor clearColor]];
    [[self circleBackgroundView] setLineWidth:4.0];
    [[self circleBackgroundView] setStartAngle:[XSCircleView degreeToRadiant:0]];
    [[self circleBackgroundView] setEndAngle:[XSCircleView degreeToRadiant:360]];
    [[self circleBackgroundView] reDrawShape];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
