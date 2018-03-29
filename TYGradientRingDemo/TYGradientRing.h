//
//  TYGradientRing.h
//  TYGradientRingDemo
//
//  Created by Tiny on 2018/3/29.
//  Copyright © 2018年 hxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYGradientRing : UIView

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign) CGFloat margin;       //圆环距离视图边缘的距离

@property (nonatomic, assign) CGFloat startDegree;  //开始角度 (0 - 360)

@property (nonatomic, assign) CGFloat endDegree;    //结束角度 (0 - 360)

@property (nonatomic, assign) CGFloat isClockwise; //默认YES 顺时针

@property (nonatomic, assign) CGFloat progress;    //(0 - 1)

@property (nonatomic, strong) NSArray< UIColor *> *colors;    //渐变色

@property (nonatomic, assign) CGPoint startPoint;  //渐变开始位置(0,0)

@property (nonatomic, assign) CGPoint endPoint;    //渐变结束位置(1,1)

@end
