//
//  TYGradientRing.m
//  TYGradientRingDemo
//
//  Created by Tiny on 2018/3/29.
//  Copyright © 2018年 hxq. All rights reserved.
//

#import "TYGradientRing.h"

@interface TYGradientRing ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, assign) CGFloat startAngle;  //开始弧度
@property (nonatomic, assign) CGFloat endAngle;    //结束弧度

@end

@implementation TYGradientRing

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    self.backgroundColor = [UIColor grayColor];
    
    //初始化话参数
    self.startDegree = 0;
    self.endDegree = 360;
    self.isClockwise = YES;
    self.margin = 10;
    
    //创建calayer
    self.shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer.frame = self.bounds;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    self.shapeLayer.lineWidth = 10.f;
    
    //关于角度坐标体系    顺时针方向
    /*           -M_PI_2(M_PI+M_PI_2)
                    ∧
                    |
                    |
                    |
                    |
       M_PI---------|----------＞  0
                    |
                    |
                    |
                    |
                  M_PI_2
     */
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5) radius:self.bounds.size.width/2 - self.margin*2 startAngle:self.startAngle endAngle:self.endAngle clockwise:self.isClockwise];
//    self.shapeLayer.path = bezierPath.CGPath;
    
    //创建渐变层
    self.gradientLayer = [[CAGradientLayer alloc] init];
    self.gradientLayer.frame = self.bounds;
    
    /*
     (0，0) -------- (1，0)
           |        |
           |   0.5  |
           |        |
     (0，1) -------- (1，1)
     */
//    sel.gradientLayer.colors = @[(__bridge id)[UIColor orangeColor].CGColor,(__bridge id)[UIColor orangeColor].CGColor];
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(1, 1);
    self.gradientLayer.mask = self.shapeLayer;
    [self.layer addSublayer:self.gradientLayer];
}

#pragma mark - Setter
-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = progress;
}

//开始角度
-(void)setStartDegree:(CGFloat)startDegree{
    _startDegree = startDegree;
    self.startAngle = startDegree * M_PI/180;
}

//结束角度
-(void)setEndDegree:(CGFloat)endDegree{
    _endDegree = endDegree;
    self.endAngle = endDegree * M_PI/180;
}

-(void)setStartPoint:(CGPoint)startPoint{
    _startPoint = startPoint;
    self.gradientLayer.startPoint = startPoint;
}

-(void)setEndPoint:(CGPoint)endPoint{
    _endPoint = endPoint;
    self.gradientLayer.endPoint = endPoint;
}

-(void)setColors:(NSArray <UIColor *> *)colors{
    _colors = colors;
    NSMutableArray *colorsRef = [NSMutableArray array];
    for (UIColor *color in colors) {
        [colorsRef addObject:(__bridge id)color.CGColor];
    }
    self.gradientLayer.colors = colorsRef;
}


#pragma mark -
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //重新设置位置
    self.shapeLayer.frame = self.bounds;
    self.gradientLayer.frame = self.bounds;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5) radius:self.bounds.size.width/2 - self.margin*2 startAngle:self.startAngle endAngle:self.endAngle clockwise:self.isClockwise];
    self.shapeLayer.path = bezierPath.CGPath;

}
@end
