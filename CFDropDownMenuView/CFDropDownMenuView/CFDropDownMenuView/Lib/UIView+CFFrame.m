//
//  UIView+CFFrame.m
//  CFDropDownMenuView
//
//  Created by Peak on 16/5/28.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import "UIView+CFFrame.h"

@implementation UIView (CFFrame)

//---------- X ----------//
- (void)setCf_x:(CGFloat)cf_x {
    CGRect frame = self.frame;
    frame.origin.x = cf_x;
    self.frame = frame;
}

- (CGFloat)cf_x {
    return self.frame.origin.x;
}

//---------- Y ----------//
- (void)setCf_y:(CGFloat)cf_y {
    CGRect frame = self.frame;
    frame.origin.y = cf_y;
    self.frame = frame;
}

- (CGFloat)cf_y {
    return self.frame.origin.y;
}

//---------- CenterX ----------//
- (void)setCf_centerX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)cf_centerX {
    return self.center.x;
}

//---------- CenterY ----------//
- (void)setCf_centerY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)cf_centerY {
    return self.center.y;
}

//---------- Width ----------//
- (void)setCf_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)cf_width {
    return self.frame.size.width;
}

//---------- Height ----------//
- (void)setCf_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)cf_height {
    return self.frame.size.height;
}

//---------- Origin ----------//
- (void)setCf_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)cf_origin {
    return self.frame.origin;
}

//---------- Size ----------//
- (void)setCf_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)cf_size {
    return self.frame.size;
}

- (CGFloat)cf_maxX {
    return self.frame.size.width + self.frame.origin.x;
}

- (CGFloat)cf_maxY {
    return self.frame.size.height + self.frame.origin.y;
}


+ (instancetype)viewWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height
{
    return [[self alloc] initWithFrame:CGRectMake(x, y, width, height)];
}

+ (instancetype)viewWithFrame:(CGRect)frame
{
    return [[UIView alloc] initWithFrame:frame];
}

+ (instancetype)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color
{
    UIView *view = [self viewWithFrame:frame];
    view.backgroundColor = color;
    return view;
}

@end
