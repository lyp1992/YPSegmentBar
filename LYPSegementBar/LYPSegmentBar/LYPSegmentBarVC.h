//
//  LYPSegmentBarVC.h
//  LYPSegementBar
//
//  Created by laiyp on 2018/10/25.
//  Copyright © 2018 laiyongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYPSegmentBar.h"
NS_ASSUME_NONNULL_BEGIN

@interface LYPSegmentBarVC : UIViewController

@property (nonatomic, weak) LYPSegmentBar *segmentBar;

-(void)setUpItems:(NSArray<NSString *>*)items childVCs:(NSArray <UIViewController *>*)childVCs;

@end

NS_ASSUME_NONNULL_END
