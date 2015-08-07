//
//  CircleselfView.m
//  MCChat
//
//  Created by yan on 15/8/4.
//  Copyright (c) 2015年 mycard. All rights reserved.
//

#import "MCCircleSlider.h"

#define ToRad(deg) 		( (M_PI * (deg)) / 180.0 )
#define ToDeg(rad)		( (180.0 * (rad)) / M_PI )
#define SQR(x)			( (x) * (x) )
#define PI_Degree 180.0

@interface MCCircleSlider ()
@property(nonatomic,readonly)CGPoint center;
@end

@implementation MCCircleSlider

@synthesize lineWidth=_lineWidth;
-(instancetype)initWithFrame:(CGRect)frame{
//    if (CGRectGetHeight(frame)!=CGRectGetWidth(frame)) {
//        frame.size.width=(MAX(frame.size.width, frame.size.height));
//        frame.size.height=frame.size.width;
//    }
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
-(CGPoint)center{
    CGPoint centerPoint;
    centerPoint.x=self.bounds.origin.x+self.bounds.size.width*0.5;
    centerPoint.y=self.bounds.origin.y+self.bounds.size.height*0.5;
    return centerPoint;
}
-(void)setEndAngle:(CGFloat)endAngle{
    _endAngle=endAngle;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    [self setNeedsDisplay];
}
-(CGFloat)lineWidth{
    if (!_lineWidth>0) {
        _lineWidth=self.bounds.size.width*0.25;
    }
    return _lineWidth;
}
-(void)setLineWidth:(CGFloat)lineWidth{
    if (lineWidth>self.bounds.size.width*0.5) {
        lineWidth=self.bounds.size.width*0.5;
    }
    _lineWidth=lineWidth;

}
-(double)max{
    if (!_max>0) {
        _max=1;
    }
    return _max;
}
-(double)currentValue{
   float changedDeg=ToDeg(self.endAngle-self.startAngle);
    if (changedDeg==0) {
        return self.min;
    }
    if (changedDeg<0) {
        changedDeg+=PI_Degree*2;
    }
   
   return (changedDeg/(PI_Degree*2))*(self.max-self.min);
}
-(void)setCurrentValue:(double)currentValue{
    float changedDeg=(currentValue/(self.max-self.min))*(PI_Degree*2);
    self.endAngle=ToRad(changedDeg);
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGFloat radius=self.bounds.size.width*0.5;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2, radius-self.lineWidth/2, 0,self.endAngle, 0);
    [[UIColor blackColor]  setStroke];
    CGContextSetLineWidth(ctx, self.lineWidth);
    CGContextDrawPath(ctx, kCGPathStroke);

}
-(void)angleWithPoint:(CGPoint)pointOne{
    float dx=(pointOne.x-self.center.x);
    float dy=(pointOne.y-self.center.y);
    float f=atan2(dy,dx);
    self.endAngle=f;
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSArray *touche = [event.allTouches allObjects];
    CGPoint pointOne = [[touche objectAtIndex:0] locationInView:self];
    [self angleWithPoint:pointOne];
}

@end
