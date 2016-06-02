//
//  CFDropDownMenuView.h
//  CFDropDownMenuView
//
//  Created by Peak on 16/5/28.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFLabelOnLeftButton.h"

@class CFDropDownMenuView;

@protocol CFDropDownMenuViewDelegate <NSObject>

@optional
- (void)dropDownMenuView:(CFDropDownMenuView *)dropDownMenuView clickOnCurrentButtonWithTitle:(NSString *)currentTitle andCurrentTitleArray:(NSArray *)currentTitleArray;

@end

@interface CFDropDownMenuView : UIView <UITableViewDelegate, UITableViewDataSource>
/**
 *  提供两种方式处理筛选条件后的业务逻辑(回调方式) - 代理/block 二选一
 */
/* 代理 */
@property (nonatomic, weak) id<CFDropDownMenuViewDelegate> delegate;
/* block 点击选择条件按钮 调用 */
typedef void (^ChooseConditionBlock)(NSString *, NSArray *);
@property (nonatomic, copy) ChooseConditionBlock chooseConditionBlock;

/**
 *  数据源--二维数组
 *  每一个大分类里, 都可以有很多个小分类(条件)
 */
@property (nonatomic, strong) NSMutableArray *dataSourceArr;



/* 默认显示的 */
@property (nonatomic, strong) NSArray *defaulTitleArray;


/* 分类按钮 数组 */
@property (nonatomic, strong) NSMutableArray *titleBtnArr;

/* 分类内容 动画起始位置 */
@property (nonatomic, assign) CGFloat startY;

/* 选中状态和未选中状态
 * 默认  选中状态:蓝色文字,蓝色箭头
 *      未选中状态:黑色文字,黑色箭头
 * 使用注意: 参数格式  
 @{
    @"selected" : @[[UIColor BlueColor], @"蓝箭头"],  // 选中状态  
    @"normal" : @[[UIColor BlackColor], @"黑箭头"]  // 未选中状态
 };
 可以不传 / 也可以只传其中一对键值对 / 也可以都传 (key必须为@"selected"  @"normal")
 */
@property (nonatomic, strong) NSDictionary *stateConfigDict;

/**
 * 公有方法, 供外界使用
 */
- (void)show;

@end

