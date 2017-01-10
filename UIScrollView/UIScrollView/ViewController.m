//
//  ViewController.m
//  UIScrollView
//
//  Created by snow on 17/1/10.
//  Copyright © 2017年 snow. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *bottom;
- (IBAction)right:(id)sender;
- (IBAction)top:(id)sender;
- (IBAction)left:(id)sender;
- (IBAction)bottom:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImageView *imageView = [[UIImageView alloc]init];
//    imageView.image = [UIImage imageNamed:@"minion"];
//    imageView.frame = CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height);
    //imageView大小等于image
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"minion"]];
    [self.scrollView addSubview:imageView];
    //设置滚动范围
    self.scrollView.contentSize = imageView.image.size;
    
    //设置额外滚动范围
    self.scrollView.contentInset = UIEdgeInsetsMake(80, 40, 30, 10);
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
@end
