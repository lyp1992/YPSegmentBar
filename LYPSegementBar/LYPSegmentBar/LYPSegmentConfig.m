//
//  LYPSegmentConfig.m
//  LYPSegementBar
//
//  Created by laiyp on 2018/10/25.
//  Copyright © 2018 laiyongpeng. All rights reserved.
//

#import "LYPSegmentConfig.h"

@implementation LYPSegmentConfig

+(instancetype)defaultConfig{
    LYPSegmentConfig *config = [[LYPSegmentConfig alloc] init];
    config.segmentBarBackColor = [UIColor clearColor];
    config.itemFont = [UIFont systemFontOfSize:15];
    config.itemNormalColor = [UIColor lightGrayColor];
    config.itemSelectColor = [UIColor redColor];
    
    config.indicatorColor = [UIColor redColor];
    config.indicatorHeight = 2;
    config.indicatorExtraWidth = 10;
    return config;
}



@end
