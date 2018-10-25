//
//  UIView+LYPSegmentBar.m
//  LYPSegementBar
//
//  Created by laiyp on 2018/10/25.
//  Copyright © 2018 laiyongpeng. All rights reserved.
//

#import "UIView+LYPSegmentBar.h"

@implementation UIView (LYPSegmentBar)

-(CGFloat)x{
    return self.frame.origin.x;
}
-(void)setX:(CGFloat)x{
    CGRect temp = self.frame;
    temp.origin.x = x;
    self.frame = temp;
}

-(void)setY:(CGFloat)y{
    CGRect temp = self.frame;
    temp.origin.y = y;
    self.frame = temp;
}
-(CGFloat)y{
    return self.frame.origin.y;
}

-(void)setCenterX:(CGFloat)centerX{
    CGPoint tempP = self.center;
    tempP.x = centerX;
    self.center = tempP;
}
-(CGFloat)centerX{
    return self.center.x;
}

-(void)setCenterY:(CGFloat)centerY{
    CGPoint tempP = self.center;
    tempP.y = centerY;
    self.center = tempP;
}
-(CGFloat)centerY{
    return self.center.y;
}

-(void)setWidth:(CGFloat)width{
    CGRect temp = self.frame;
    temp.size.width = width;
    self.frame = temp;
}
-(CGFloat)width{
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height {
    CGRect temp = self.frame;
    temp.size.height = height;
    self.frame = temp;
}
-(CGFloat)height{
    return self.frame.size.height;
}

@end
