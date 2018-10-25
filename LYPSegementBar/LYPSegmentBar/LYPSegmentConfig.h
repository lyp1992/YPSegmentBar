//
//  LYPSegmentConfig.h
//  LYPSegementBar
//
//  Created by laiyp on 2018/10/25.
//  Copyright © 2018 laiyongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYPSegmentConfig : NSObject

+(instancetype)defaultConfig;

@property (nonatomic, strong) UIColor *segmentBarBackColor;

@property (nonatomic, strong) UIColor *itemNormalColor;

@property (nonatomic, strong) UIColor *itemSelectColor;
@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, assign) CGFloat indicatorHeight;
@property (nonatomic, assign) CGFloat indicatorExtraWidth;

@property (nonatomic, strong) UIFont *itemFont;



@end

NS_ASSUME_NONNULL_END
