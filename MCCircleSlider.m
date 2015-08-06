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

@interface MCCircleSlider ()
@property(nonatomic,readonly)CGPoint center;
@end

@implementation MCCircleSlider
-(instancetype)initWithFrame:(CGRect)frame{
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
-(double)max{
    if (!_max>0) {
        _max=1;
    }
    return _max;
}
-(double)currentValue{
   float currentValue=ToDeg(self.endAngle-self.startAngle);
    if (currentValue==0) {
        return self.min;
    }
    if (currentValue<0) {
        currentValue+=180*2;
    }
   
   return (currentValue/360)/(self.max-self.min);
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touchesMoved:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSArray *touche = [event.allTouches allObjects];
    CGPoint pointOne = [[touche objectAtIndex:0] locationInView:self];
    [self angleWithPoint:pointOne];
}

@end
