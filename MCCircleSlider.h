//
//  CircleDrawView.h
//  MCChat
//
//  Created by yan on 15/8/4.
//  Copyright (c) 2015年 mycard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCCircleSlider : UIControl

@property(nonatomic,assign)CGFloat lineWidth;
@property(nonatomic,assign)CGFloat startAngle;
@property(nonatomic,assign)CGFloat endAngle;
@property(nonatomic,assign)double min;
@property(nonatomic,assign)double max;
@property(nonatomic,assign)double currentValue;

//当作为其他UIView的layer时，需在控制器中实现touch方法，并传递到此方法
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
@end
