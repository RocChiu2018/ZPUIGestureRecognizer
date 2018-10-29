//
//  ViewController.m
//  UITapGestureRecognizer
//
//  Created by apple on 2016/11/14.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 利用手势识别器(UIGestureRecognizer)才能识别用户在view上面做的一些常见的手势；
 UIGestureRecognizer是一个抽象类，定义了所有手势的基本行为，使用它的子类才能处理具体的手势，它的子类如下：
 1、UITapGestureRecognizer（敲击）；
 2、UIPinchGestureRecognizer（捏合，用于图片的缩放）；
 3、UIPanGestureRecognizer（拖拽）；
 4、UISwipeGestureRecognizer（轻扫）；
 5、UIRotationGestureRecognizer（旋转）；
 6、UILongPressGestureRecognizer（长按）；
 */
#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.imageView.userInteractionEnabled = YES;
    
    //单击
//    [self click];
    
    //双击
//    [self doubleClick];
    
    //长按
//    [self longPress];
    
    //轻扫
//    [self swipe];
    
    //旋转
    [self rotation];
    
    //捏合
    [self pinch];
    
    //拖拽
//    [self pan];
}

#pragma mark ————— 单击 —————
- (void)click
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
//    tap.numberOfTouchesRequired = 2;  //两根手指同时触碰屏幕才能识别出这个手势（如果不写这句代码的话则默认一个手指触碰屏幕就可以识别出这个手势）
    
//    self.imageView.multipleTouchEnabled = YES;  //如果两根手指触摸控件的时候要识别出来这个手势的话，还要设置这个控件的多点触摸功能
    
    [self.imageView addGestureRecognizer:tap];
}

#pragma mark ————— 双击 —————
- (void)doubleClick
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    tap.numberOfTapsRequired = 2;  //连续敲击两次才能识别出这个手势（如果不写这句代码的话则默认敲击一次就能识别出这个手势）
    [self.imageView addGestureRecognizer:tap];
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    NSLog(@"%s", __func__);
}

#pragma mark ————— 长按 —————
- (void)longPress
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPress.delegate = self;
    [self.imageView addGestureRecognizer:longPress];
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
    /**
     对于长按手势来说，当用户按下去的时候系统会调用一次这个方法，当用户抬起手指的时候系统还会再次调用一次这个方法，前后会调用两次这个方法；
     针对上述的情况，系统会前后两次调用这个方法，但是用户只希望执行一次这里面的内容，所以在手势刚开始(UIGestureRecognizerStateBegan)或者手势刚结束(UIGestureRecognizerStateEnded)的时候才执行这里面的内容了，这样才能做到只执行一次想要执行的内容。
     */
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"%s", __func__);
    }
}

#pragma mark ————— 轻扫 —————
- (void)swipe
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipe.delegate = self;
    
    /**
     设置轻扫手势的方向：
     如果不写下面这句代码的话，轻扫手势默认是从左向后滑动的，如果想重新设置轻扫方向的话可以通过下面这句代码来改变原来轻扫手势的方向；
     如果想要在一个控件上支持多个方向的轻扫的话则必须创建多个轻扫的手势，一个轻扫的手势只支持一个方向的轻扫。
     */
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    
    [self.imageView addGestureRecognizer:swipe];
}

- (void)swipe:(UISwipeGestureRecognizer *)swipe
{
    NSLog(@"%s", __func__);
}

#pragma mark ————— 旋转 —————
/**
 在设置旋转手势的delegate的时候不要撰写代理方法中的gestureRecognizer: shouldReceiveTouch: 方法否则旋转手势将不起作用。
 */
- (void)rotation
{
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    rotation.delegate = self;
    [self.imageView addGestureRecognizer:rotation];
}

- (void)rotation:(UIRotationGestureRecognizer *)rotation
{
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotation.rotation);
    
    //获取手势旋转的角度
    NSLog(@"%f", rotation.rotation);
    
    //复位
    rotation.rotation = 0;
}

#pragma mark ————— 捏合 —————
/**
 在设置捏合手势的delegate的时候不要撰写代理方法中的gestureRecognizer: shouldReceiveTouch: 方法否则捏合手势将不起作用。
 */
- (void)pinch
{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    pinch.delegate = self;
    [self.imageView addGestureRecognizer:pinch];
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale);
    
    //获取捏合的比例
    NSLog(@"%f", pinch.scale);
    
    //复位
    pinch.scale = 1;
}

#pragma mark ————— 拖拽 —————
- (void)pan
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.imageView addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    //相对于最开始的位置，获取手势移动了多少
    CGPoint movePoint = [pan translationInView:self.imageView];
    NSLog(@"%@", NSStringFromCGPoint(movePoint));
    
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, movePoint.x, movePoint.y);
    
    //复位
    [pan setTranslation:CGPointZero inView:self.imageView];
}

#pragma mark - UIGestureRecognizerDelegate
/**
 是否允许触发手势，如果返回的是NO则不能触发手势。
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

/**
 是否允许同时支持多个手势（旋转、捏合等）；
 默认是不支持多个手势的，在这里返回YES则代表支持多个手势；
 在本Demo中要使旋转和捏合手势同时起作用的话就要在此方法中返回YES，并且不能撰写代理方法中的gestureRecognizer: shouldReceiveTouch: 方法。
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

/**
 是否允许接收手指的触摸点；
 点击视图的时候可以通过这个方法获取到那个触摸点；
 当用户点击View的时候，系统会首先调用这个方法，判断用户点击的这个点是否有效，如果有效的话系统会继续调用tap:方法。
 */
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    //获取当前的触摸点
//    CGPoint position = [touch locationInView:touch.view];
//
//    //如果点击图片的左半区则有效，点击右半区则无效
//    if (position.x <= self.imageView.frame.size.width * 0.5)
//    {
//        return YES;
//    }
//
//    return NO;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
