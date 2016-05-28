//
//  ViewController.m
//  CFDropDownMenuView
//
//  Created by Peak on 16/5/28.
//  Copyright © 2016年 陈峰. All rights reserved.
//  DEMO

#import "ViewController.h"
#import "CFDropDownMenuView.h"
#import "CFMacro.h"
#import "UIView+CFFrame.h"

@interface ViewController () <CFDropDownMenuViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // DEMO
    CFDropDownMenuView *dropDownMenuView= [[CFDropDownMenuView alloc] initWithFrame:CGRectMake(0, 0, CFScreenWidth, 45)];
    
    /**
     *  stateConfigDict 属性 格式 详见CFDropDownMenuView.h文件
     */
//    dropDownMenuView.stateConfigDict = @{
//                                     @"selected" : @[CF_Color_DefaultColor, @"天蓝箭头"],  // 选中状态
//                                     };
//    dropDownMenuView.stateConfigDict = @{
//                                         @"normal" : @[[UIColor orangeColor], @"橙箭头"],  // 选中状态
//                                         };
//    dropDownMenuView.stateConfigDict = @{
//                                         @"selected" : @[CF_Color_DefaultColor, @"天蓝箭头"],  
//                                         @"normal" : @[[UIColor orangeColor], @"橙箭头"]
//                                         };
    // 注:  需先 赋值数据源dataSourceArr二维数组  再赋值defaulTitleArray一维数组
    dropDownMenuView.dataSourceArr = @[
                                   @[@"全部", @"iOS开发", @"安卓开发", @"JAVA开发", @"PHP开发"],
                                   @[@"5-10k", @"10-15k", @"15-20k", @"20k以上"],
                                   @[@"1年以内", @"1-3年", @"3-5年", @"5年以上"]
                                   ].mutableCopy;
    
    dropDownMenuView.defaulTitleArray = [NSArray arrayWithObjects:@"工作岗位",@"薪资", @"工作经验", nil];
    
    dropDownMenuView.delegate = self;
    
    [self.view addSubview:dropDownMenuView];
    // 下拉列表 起始y
    dropDownMenuView.cf_y = 64;
    dropDownMenuView.startY = CGRectGetMaxY(dropDownMenuView.frame);
    
    
    self.view.backgroundColor = CF_Color_DefalutBackGroundColor;
    [self.view addSubview:dropDownMenuView];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, CFScreenWidth, 44)];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.backgroundColor = CFRandomColor;
    titleL.text = @"CFDropDownMenuView 展示demo";
    [self.view addSubview:titleL];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
