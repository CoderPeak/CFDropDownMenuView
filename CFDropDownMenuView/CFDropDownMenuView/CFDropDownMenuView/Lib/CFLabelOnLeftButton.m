//
//  CFLabelOnLeftButton.m
//  CFDropDownMenuView
//
//  Created by Peak on 16/5/28.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import "CFLabelOnLeftButton.h"
#import "CFMacro.h"
#import "UIView+CFFrame.h"


@implementation CFLabelOnLeftButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 默认设置
        [self setTitleColor:CF_Color_TextGrayColor forState:UIControlStateNormal];
        self.titleLabel.font = CF_Font_15;
        
        
    }
    return self;
}

+ (instancetype)createButtonWithImageName:(NSString *)imgName title:(NSString *)title titleColor:(UIColor *)titleColor frame:(CGRect)btnFrame target:(id)target action:(SEL)action
{
    CFLabelOnLeftButton *btn = [self buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    [btn sizeToFit];
    btn.frame = btnFrame;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    CGFloat imageWidth = self.imageView.cf_width+1;
    CGFloat labelWidth = self.titleLabel.cf_width+1;
    
    // 图片 位置（右）
    self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    
    
    // 文字 位置（左边）
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    
    
}


@end
