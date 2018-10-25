//
//  LYPSegmentBarVC.m
//  LYPSegementBar
//
//  Created by laiyp on 2018/10/25.
//  Copyright © 2018 laiyongpeng. All rights reserved.
//

#import "LYPSegmentBarVC.h"
#import "UIView+LYPSegmentBar.h"
@interface LYPSegmentBarVC ()<UIScrollViewDelegate,LYPSegmentBarDelegate>

@property (nonatomic, strong) UIScrollView *contentView;

@end

@implementation LYPSegmentBarVC

-(LYPSegmentBar *)segmentBar{
    if (!_segmentBar) {
        LYPSegmentBar *segmentBar = [LYPSegmentBar segmentBarWithFrame:CGRectZero];
        segmentBar.delegate = self;
        [self.view addSubview:segmentBar];
        _segmentBar = segmentBar;
    }
    return _segmentBar;
}
- (UIScrollView *)contentView {
    if (!_contentView) {
        
        UIScrollView *contentView = [[UIScrollView alloc] init];
        contentView.delegate = self;
        contentView.pagingEnabled = YES;
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

-(void)setUpItems:(NSArray<NSString *> *)items childVCs:(NSArray<UIViewController *> *)childVCs{
       NSAssert(items.count != 0 || items.count == childVCs.count, @"个数不一致, 请自己检查");
    self.segmentBar.items = items;
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    
//    添加子控制器
    for (UIViewController *vc in childVCs) {
        [self addChildViewController:vc];
    }
    self.contentView.contentSize = CGSizeMake(childVCs.count * self.view.width, 0);
    self.segmentBar.selectIndex = 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    if (self.segmentBar.superview == self.view) {
        self.segmentBar.frame = CGRectMake(0, 60, self.view.width, 35);
        CGFloat contentY = self.segmentBar.y + self.segmentBar.height;
        CGRect contentVF = CGRectMake(0, contentY, self.view.width, self.view.height - contentY);
        self.contentView.frame = contentVF;
        self.contentView.contentSize = CGSizeMake(self.childViewControllers.count *self.view.width, 0);
        return;
    }
    
    CGRect contentFrame = CGRectMake(0, 0,self.view.width,self.view.height);
    self.contentView.frame = contentFrame;
    self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    
    // 其他的控制器视图, 大小
    // 遍历所有的视图, 重新添加, 重新进行布局
    // 注意: 1个视图
    //
    
    self.segmentBar.selectIndex = self.segmentBar.selectIndex;
}

-(void)showChildVCViewsAtIndex:(NSInteger)index{
    if (self.childViewControllers.count == 0 || index < 0 || index > self.childViewControllers.count - 1) {
        return;
    }
    
//    取到选中的控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index * self.view.width, 0, self.contentView.width, self.contentView.height);
    [self.contentView addSubview:vc.view];
//    设置滚动到指定控制器
     [self.contentView setContentOffset:CGPointMake(index * self.contentView.width, 0) animated:YES];
}

#pragma mark --LYPSegmentBarDelegate
- (void)segmentBar:(nonnull LYPSegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex {
    
    [self showChildVCViewsAtIndex:toIndex];
}

#pragma --mark UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    计算最后的索引
    NSInteger index = self.contentView.contentOffset.x/self.contentView.width;
    self.segmentBar.selectIndex = index;
}

@end
