//
//  LYPSegmentBar.m
//  LYPSegementBar
//
//  Created by laiyp on 2018/10/25.
//  Copyright © 2018 laiyongpeng. All rights reserved.
//

#import "LYPSegmentBar.h"
#import "UIView+LYPSegmentBar.h"

#define kMinMargin 30
@interface LYPSegmentBar ()

//上一次被选中的btn
@property (nonatomic, strong) UIButton *lastBtn;

//item数组
@property (nonatomic, strong) NSMutableArray<UIButton *>*itemBtns;

//指示器
@property (nonatomic, strong) UIView *indicatorView;

@property (nonatomic, strong) UIScrollView *contentView;

@property (nonatomic, strong) LYPSegmentConfig *config;

@end

@implementation LYPSegmentBar

+(instancetype)segmentBarWithFrame:(CGRect)frame{

    LYPSegmentBar *segmentBar = [[LYPSegmentBar alloc]initWithFrame:frame];
    return segmentBar;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = self.config.segmentBarBackColor;
    }
    return self;
}

-(void)setItems:(NSArray<NSString *> *)items{
    _items = items;
//    移除之前d添加过的item
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    
    for (NSString *itemStr in items) {
        UIButton *button = [[UIButton alloc]init];
        button.tag = self.itemBtns.count;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:itemStr forState:UIControlStateNormal];
        [button setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
        [button setTitleColor:self.config.itemSelectColor forState:UIControlStateSelected];
        button.titleLabel.font = self.config.itemFont;
        [self.contentView addSubview:button];
        [self.itemBtns addObject:button];
    }
    
//手动布局
    [self layoutIfNeeded];
    [self layoutSubviews];
    
}

-(void)updateWithConfig:(void (^)(LYPSegmentConfig * _Nonnull))configBlock{
    
    if (configBlock) {
        configBlock(self.config);
    }
//   按照当前的config进行刷新
    self.backgroundColor = self.config.segmentBarBackColor;
    for (UIButton *btn in self.itemBtns) {
        [btn setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.itemFont;
    }
    // 指示器
    self.indicatorView.backgroundColor = self.config.indicatorColor;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)setSelectIndex:(NSInteger)selectIndex{
    // 数据过滤
    if (self.itemBtns.count == 0 || selectIndex < 0 || selectIndex > self.itemBtns.count - 1) {
        return;
    }
      _selectIndex = selectIndex;
    UIButton *btn = self.itemBtns[selectIndex];
    [self btnClick:btn];
}

-(void)btnClick:(UIButton *)sender{
    
    if ([_delegate respondsToSelector:@selector(segmentBar:didSelectIndex:fromIndex:)]) {
        [self.delegate segmentBar:self didSelectIndex:sender.tag fromIndex:self.lastBtn.tag];
    }
    
    _selectIndex = sender.tag;
    
    self.lastBtn.selected = NO;
    sender.selected = YES;
    self.lastBtn = sender;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorView.width = sender.width + self.config.indicatorExtraWidth * 2;
        self.indicatorView.centerX = sender.centerX;
    }];
    
//    滚动到btn显示的位置
    CGFloat scrollX = sender.centerX - self.contentView.width * 0.5;
    if (scrollX < 0) {
        scrollX = 0;
    }
    if (scrollX > self.contentView.contentSize.width - self.contentView.width) {
        scrollX = self.contentView.contentSize.width - self.contentView.width;
    }
    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    
//    计算margin
    CGFloat totalBtnWidth = 0;
    for (UIButton *button in self.itemBtns) {
        [button sizeToFit];
        totalBtnWidth += button.width;
    }
    CGFloat caculateMargin = (self.width - totalBtnWidth)/(self.itemBtns.count+1);
    if (caculateMargin < kMinMargin) {
        caculateMargin = kMinMargin;
    }
    CGFloat lastX = caculateMargin;
//    计算btn的位置
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        btn.y = 0;
        btn.x = lastX;
        lastX += btn.width + caculateMargin;
    }
    self.contentView.contentSize = CGSizeMake(lastX, 0);
    
    if (self.itemBtns.count == 0) {
        return;
    }
    UIButton *itemBtn = self.itemBtns[self.selectIndex];
    self.indicatorView.width = itemBtn.width + self.config.indicatorExtraWidth *2;
    self.indicatorView.height = self.config.indicatorHeight;
    self.indicatorView.centerX = itemBtn.centerX;
    self.indicatorView.y = self.height - self.indicatorView.height;
    
}

#pragma mark private
- (NSMutableArray<UIButton *> *)itemBtns{
    if (!_itemBtns) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}

-(LYPSegmentConfig *)config{
    if (!_config) {
        _config = [LYPSegmentConfig defaultConfig];
    }
    return _config;
}

-(UIScrollView *)contentView{
    if (!_contentView) {
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.contentView = scrollView;
    }
    return _contentView;
}

-(UIView *)indicatorView{
    if (!_indicatorView) {
        CGFloat indicatoreH = self.config.indicatorHeight;
        UIView *view = [[UIView alloc]init];
        view.frame = CGRectMake(0, self.height - indicatoreH, 0, indicatoreH);
        view.backgroundColor = self.config.indicatorColor;
        [self.contentView addSubview:view];
        self.indicatorView = view;
    }
    return _indicatorView;
}

@end
