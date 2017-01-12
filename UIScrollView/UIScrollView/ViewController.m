//
//  ViewController.m
//  UIScrollView
//
//  Created by snow on 17/1/10.
//  Copyright © 2017年 snow. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *bottom;
- (IBAction)right:(id)sender;
- (IBAction)top:(id)sender;
- (IBAction)left:(id)sender;
- (IBAction)bottom:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //imageView大小等于image
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"minion"]];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.delegate = self;
//    [self createViews];
    
    UIView *lastView = [self.scrollView.subviews lastObject];
    CGFloat contentH = lastView.frame.origin.y + lastView.frame.size.height;
//    self.scrollView.contentSize = CGSizeMake(0, contentH);
    
    //设置滚动范围
    self.scrollView.contentSize = self.imageView.image.size;
    
    //设置额外滚动范围
    self.scrollView.contentInset = UIEdgeInsetsMake(80, 40, 30, 10);
    
    //设置缩放比例
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.minimumZoomScale = 0.2;
}

- (void)createViews {
    for (int i = 0; i < 50; i++) {
        int row = i / 3; //行号
        int colum = i % 3; //列号
        CGFloat x = (100 + 30)*colum;
        CGFloat y = (120 +10)*row;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(x, y, 100, 120)];
        view.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:view];
    }

}

- (IBAction)left:(id)sender {
   // self.scrollView.contentOffset:偏移量
    //内容的左上角和scrollView左上角的x/y差值
//    self.scrollView.contentOffset = CGPointMake(100, 100);//左上
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(stop)];
    [UIView setAnimationWillStartSelector:@selector(start)];
    self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentOffset.y);
    [UIView commitAnimations];
}

- (void)start {
    NSLog(@"animation start");
}

- (void)stop {
    NSLog(@"animation stop");
}

- (IBAction)right:(id)sender {
    [UIView animateWithDuration:1 animations:^{
    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentSize.width - self.scrollView.frame.size.width, self.scrollView.contentOffset.y);
    }];

}

- (IBAction)top:(id)sender {
    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, 0);
    //不允许直接修改OC对象的结构体成员属性
//    self.scrollView.contentOffset.y = 10;
}



- (IBAction)bottom:(id)sender {
    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentSize.height - self.scrollView.frame.size.height);
}

#pragma mark - UIScrollViewDelegate

//即将开始拖曳的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
   NSLog(@"1111111111111");
}

//滚动时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"2222222222222");
}


//结束拖曳时调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
     NSLog(@"333333333333");
}

//减速完毕时调用，必须有减速才调用，由于惯性停止滚动时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"444444444444");
}

//这个方法的返回值决定了要缩放的内容
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
