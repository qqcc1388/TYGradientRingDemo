![](https://images2018.cnblogs.com/blog/950551/201803/950551-20180329162918302-66584803.png)

CAGradientLayer图层可以通过设置mask来给视图添加渐变效果  CAGradientLayer主要需要设置一下几个参数
colors:传入需要渐变的颜色 例如 self.gradientLayer.colors = @[(__bridge id)[UIColor orangeColor].CGColor,(__bridge id)[UIColor orangeColor].CGColor]; 需要注意的Color格式
startPoint:渐变开始的位置     self.gradientLayer.startPoint = CGPointMake(0, 0);
endPoint:渐变结束的位置      self.gradientLayer.endPoint = CGPointMake(1, 1);
我画一个坐标你立刻就明白了，中间是0.5
```
     (0，0) -------- (1，0)
           |        |
           |   0.5  |
           |        |
     (0，1) -------- (1，1)
```

CAShapeLayer 可以传入UIBezierPath曲线，这样我们可以通过UIBezierPath绘制一个圆环，通过CAGradientLayer来实现渐变效果
fillColor：填充颜色
strokeColor：绘制颜色
lineWidth：线宽
path：绘图路径（CGPath）

关于用UIBezierPath画圆 圆环
UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5) radius:self.bounds.size.width/2 - 20 startAngle:0 endAngle:M_PI clockwise:YES];
这里需要注意传入的是弧度而不是角度  弧度转角度可以自行查阅资料
弧度在坐标系中的位置我这里大致画一下，方便观察开始角度和结束角度
```
          -M_PI_2(M_PI+M_PI_2)
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
```

//给圆环添加渐变效果
```
    self.shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer.frame = self.bounds;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    self.shapeLayer.lineWidth = 10.f;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5) radius:self.bounds.size.width/2 - 20 startAngle:0 endAngle:M_PI clockwise:YES];
    self.shapeLayer.path = bezierPath.CGPath;

    //创建渐变层
    self.gradientLayer = [[CAGradientLayer alloc] init];
    self.gradientLayer.frame = self.bounds;
    self.gradientLayer.colors = @[(__bridge id)[UIColor orangeColor].CGColor,(__bridge id)[UIColor orangeColor].CGColor];
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(1, 1);

    self.gradientLayer.mask = self.shapeLayer;
    [self.layer addSublayer:self.gradientLayer];

```
更多内容参见demo：

转载请标注来源：