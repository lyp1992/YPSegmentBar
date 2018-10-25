//
//  ViewController.m
//  LYPSegementBar
//
//  Created by laiyp on 2018/10/25.
//  Copyright © 2018 laiyongpeng. All rights reserved.
//

#import "ViewController.h"
#import "LYPSegmentBar/LYPSegmentBar.h"
#import "LYPFirstViewController.h"
#import "LYPSecondViewController.h"
#import "LYPThreeViewController.h"
#import "LYPSegmentBar/LYPSegmentBarVC.h"

@interface ViewController ()

@property (nonatomic, strong) LYPSegmentBarVC *segmentBarVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setData];
}

-(LYPSegmentBarVC *)segmentBarVC{
    if (!_segmentBarVC) {
        self.segmentBarVC = [[LYPSegmentBarVC alloc]init];
        [self addChildViewController:self.segmentBarVC];
    }
    return _segmentBarVC;
}
-(void)setUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 1. 设置导航栏背景颜色, 以及titleView内容视图
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_bg_64"] forBarMetrics:UIBarMetricsDefault];
    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, 300, 40);
    self.navigationItem.titleView = self.segmentBarVC.segmentBar;
    
    // 2. 设置控制器内容视图
    self.segmentBarVC.view.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60);
    [self.view addSubview:self.segmentBarVC.view];
}

-(void)setData{
    LYPFirstViewController *firstVC = [[LYPFirstViewController alloc]init];
    LYPSecondViewController *secondVC = [[LYPSecondViewController alloc]init];
    LYPThreeViewController *threeVC = [[LYPThreeViewController alloc]init];
    
    [self.segmentBarVC setUpItems:@[@"中国",@"美国",@"日本"] childVCs:@[firstVC,secondVC,threeVC]];
    [self.segmentBarVC.segmentBar updateWithConfig:^(LYPSegmentConfig * _Nonnull config) {
        config.segmentBarBackColor = [UIColor lightGrayColor];
        config.itemSelectColor = [UIColor orangeColor];
        config.itemNormalColor = [UIColor whiteColor];
        config.indicatorColor = [UIColor orangeColor];
        config.itemFont = [UIFont systemFontOfSize:18];
    }];
}


-(void)testSegmentBar{
    LYPSegmentBar *segmentBar = [LYPSegmentBar segmentBarWithFrame:CGRectMake(10, 100, 300, 44)];
    segmentBar.items = @[@"全球",@"中国",@"美国",@"日本"];
    //    segmentBar.backgroundColor = [UIColor grayColor];
    [segmentBar updateWithConfig:^(LYPSegmentConfig * _Nonnull config) {
        config.segmentBarBackColor = [UIColor lightGrayColor];
        config.itemSelectColor = [UIColor orangeColor];
        config.itemNormalColor = [UIColor whiteColor];
        config.indicatorColor = [UIColor orangeColor];
        config.itemFont = [UIFont systemFontOfSize:18];
    }];
    [self.view addSubview:segmentBar];
}

@end
