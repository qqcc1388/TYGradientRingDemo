//
//  ViewController.m
//  TYGradientRingDemo
//
//  Created by Tiny on 2018/3/29.
//  Copyright © 2018年 hxq. All rights reserved.
//

#import "ViewController.h"
#import "TYGradientRing.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet TYGradientRing *ringView;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //初始化参数
    self.ringView.lineWidth = 10;
    self.ringView.startDegree = 0;
    self.ringView.endDegree = 360;
    self.ringView.isClockwise = YES;
    
    //设置渐变效果
    self.ringView.colors = @[[UIColor orangeColor],[UIColor cyanColor]];
    self.ringView.startPoint = CGPointMake(0, 0);
    self.ringView.endPoint = CGPointMake(1, 1);
    //设置
    self.ringView.progress = 1;
//    [self setupTimer];
}

-(void)setupTimer{
    //    __block int count = 0;
    
    // 获得队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 创建一个定时器(dispatch_source_t本质还是个OC对象)
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置定时器的各种属性（几时开始任务，每隔多长时间执行一次）
    // GCD的时间参数，一般是纳秒（1秒 == 10的9次方纳秒）
    // 何时开始执行第一个任务
    // dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC) 比当前时间晚1秒
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    
    // 设置回调
    dispatch_source_set_event_handler(self.timer, ^{
        self.ringView.progress = arc4random_uniform(101)/100.0;
    });
    
    // 启动定时器
    dispatch_resume(self.timer);
}



@end
