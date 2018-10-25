//
//  LYPSegmentBar.h
//  LYPSegementBar
//
//  Created by laiyp on 2018/10/25.
//  Copyright © 2018 laiyongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYPSegmentConfig.h"

NS_ASSUME_NONNULL_BEGIN

@class LYPSegmentBar;
@protocol LYPSegmentBarDelegate <NSObject>


/**

 @param segmentBar segmentBar
 @param toIndex 选中的索引
 @param fromIndex 上一个索引
 */
-(void)segmentBar:(LYPSegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex;

@end

@interface LYPSegmentBar : UIView

//快速创建一个选项卡
+(instancetype)segmentBarWithFrame:(CGRect)frame;

//数据源
@property (nonatomic, strong) NSArray<NSString *>*items;

//当前选中的index
@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, weak) id<LYPSegmentBarDelegate>delegate;

-(void)updateWithConfig:(void(^)(LYPSegmentConfig *config))configBlock;

@end

NS_ASSUME_NONNULL_END
