//
//  CFDropDownMenuView.m
//  CFDropDownMenuView
//
//  Created by Peak on 16/5/28.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import "CFDropDownMenuView.h"
#import "CFMacro.h"
#import "UIView+CFFrame.h"

#define kTitleBarHeight 45
#define kViewTagConstant 1  // 所有tag都加上这个 防止出现为0的tag

@interface CFDropDownMenuView ()

/* 分类 classifyView */
@property (nonatomic, strong) UIView *titleBar;

/* 整个屏幕的 背景 半透明View */
@property (nonatomic, strong) UIView *bgView;

/**
 *  cell为筛选的条件
 */
@property (nonatomic, strong) UITableView *dropDownMenuTableView;

/**
 *  数据源--一维数组 (每一列的条件标题)
 */
@property (nonatomic, strong) NSArray *dataSource;

/* 最后点击的按钮 */
@property (nonatomic, strong) UIButton *lastClickedBtn;

@end


@implementation CFDropDownMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleBar];
    }
    return self;
}



#pragma mark - lazy
/* 分类 classifyView */
- (UIView *)titleBar
{
    if (!_titleBar) {
        _titleBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CFScreenWidth, kTitleBarHeight)];
        _titleBar.backgroundColor = [UIColor whiteColor];
    }
    return _titleBar;
}

#pragma mark - setter
- (void)setDataSourceArr:(NSMutableArray *)dataSourceArr
{
    _dataSourceArr = dataSourceArr;
    
    self.titleBtnArr = [[NSMutableArray alloc] init];
    
    CGFloat btnW = CFScreenWidth/dataSourceArr.count;
    CGFloat btnH = kTitleBarHeight;
    
    for (NSInteger i=0; i<dataSourceArr.count; i++) {
        
        CFLabelOnLeftButton *titleBtn = nil;
        
        
        titleBtn = [CFLabelOnLeftButton createButtonWithImageName:CFDrowMenuViewSrcName(@"灰箭头.png")?:CFDrowMenuViewFrameworkSrcName(@"灰箭头.png") title:@"" titleColor:CF_Color_TextDarkGrayColor frame:CGRectMake(i*btnW, 0, btnW, btnH) target:self action:@selector(titleBtnClicked:)];
        
        titleBtn.tag = i+kViewTagConstant;  // 所有tag都加上这个, 防止出现为0的tag
        
        [self.titleBar addSubview:titleBtn];
        
        [self.titleBtnArr addObject:titleBtn];  // 分类 按钮数组
    }
    
    // 中间分割竖线
    for (NSInteger i=0; i<dataSourceArr.count-1; i++) {
        UIView *line = [UIView viewWithFrame:CGRectMake(btnW*(i+1), 9, 1, btnH-18) backgroundColor:CF_Color_SepertLineColor];
        [self.titleBar addSubview:line];
    }
}


// 设置文字 默认
- (void)setDefaulTitleArray:(NSArray *)defaulTitleArray
{
    _defaulTitleArray = defaulTitleArray;
    for (NSInteger i = 0; i < self.titleBtnArr.count; i++) {
        [self.titleBtnArr[i] setTitle:defaulTitleArray[i] forState:UIControlStateNormal];
        
        if (self.stateConfigDict[@"normal"]) {
            
            UIImage *image = [UIImage imageNamed:self.stateConfigDict[@"normal"][1]];
            if (image) {  // 使用自己的图片
                [self changTintColorWithTintColor:self.stateConfigDict[@"normal"][0] tintColorImgName:self.stateConfigDict[@"normal"][1] ForButton:self.titleBtnArr[i]];
            } else {  // 使用CFDropDownMenuView.bundle自带的
                
                NSString *str = [NSString stringWithFormat:@"%@.png", self.stateConfigDict[@"normal"][1]];
                NSString *imgName = CFDrowMenuViewSrcName(str)?:CFDrowMenuViewFrameworkSrcName(str);
                [self changTintColorWithTintColor:self.stateConfigDict[@"normal"][0] tintColorImgName:imgName ForButton:self.titleBtnArr[i]];
            }
            
        } else {
            // 默认 未设置样式的时候 未选中状态为 灰色箭头/灰色文字
            [self changTintColorWithTintColor:CF_Color_TextDarkGrayColor tintColorImgName:CFDrowMenuViewSrcName(@"灰箭头.png")?:CFDrowMenuViewFrameworkSrcName(@"灰箭头.png") ForButton:self.titleBtnArr[i]];
            
        }
        
    }
}

#pragma mark - 按钮点击
- (void)titleBtnClicked:(UIButton *)btn
{
    _lastClickedBtn = btn;
    
    [self removeSubviews];
    self.dataSource = self.dataSourceArr[btn.tag-kViewTagConstant];
    
    // 加上 选择内容
    [self show];
    // 按钮动画
    [self animationWhenClickTitleBtn:btn];
    
}


#pragma mark - public
// 点击按钮动画
- (void)animationWhenClickTitleBtn:(UIButton *)btn
{
    /**
     *  0.0.2版本 bug  当没有把当前分类的菜单退出时 就点其他分类  会导致 箭头方向错了
     */
//    [UIView animateWithDuration:0.25 animations:^{
//        btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
//        btn.enabled = NO;
//    }];
    
    _lastClickedBtn = btn;
    
    /**
     *  0.0.3  箭头方向错了bug解决
     */
    for (UIButton *subBtn in self.titleBtnArr) {
        if (subBtn==btn) {
            [UIView animateWithDuration:0.25 animations:^{
                subBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
                subBtn.enabled = NO;
            }];
            
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                subBtn.imageView.transform = CGAffineTransformMakeRotation(0);
                subBtn.enabled = YES;
            }];
        }
    }
}

#pragma mark - lazy
/* 蒙层view */
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.startY, CFScreenWidth, CFScreenHeight)];
        _bgView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        
        
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [_bgView addGestureRecognizer:tapGest];
    }
    return _bgView;
}

/* 分类内容 */
- (UITableView *)dropDownMenuTableView
{
    if (!_dropDownMenuTableView) {
        _dropDownMenuTableView = [[UITableView alloc] init];
        _dropDownMenuTableView.frame = CGRectMake(0, self.startY, CFScreenWidth, 0);
        _dropDownMenuTableView.backgroundColor = [UIColor whiteColor];
        _dropDownMenuTableView.delegate = self;
        _dropDownMenuTableView.dataSource = self;
        _dropDownMenuTableView.scrollEnabled = YES;
    }
    return _dropDownMenuTableView;
}

#pragma mark - public
- (void)show {
    
    [self.superview addSubview:self.bgView];
    [self.superview addSubview:self.dropDownMenuTableView];
    [UIView animateWithDuration:0.25 animations:^{
        self.dropDownMenuTableView.frame = CGRectMake(0, self.startY, CFScreenWidth, MIN(44 * 5, 44 * self.dataSource.count));
        
    } completion:^(BOOL finished) {
        [self.dropDownMenuTableView reloadData];
    }];
}

#pragma mark - private
- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.dropDownMenuTableView.frame = CGRectMake(0, self.startY, CFScreenWidth, 0);
        _lastClickedBtn.imageView.transform = CGAffineTransformMakeRotation(0.01);
    } completion:^(BOOL finished) {
        [self removeSubviews];
        [self btnEnable];
    }];
    
}

- (void)removeSubviews
{
    [UIView animateWithDuration:0.25 animations:^{
        _lastClickedBtn.imageView.transform = CGAffineTransformMakeRotation(0.01);
    }];
    // 此处 千万不能写作 !self.bgView?:[self.bgView removeFromSuperview];  会崩
    !_bgView?:[_bgView removeFromSuperview];
    _bgView=nil;
    
    !_dropDownMenuTableView?:[_dropDownMenuTableView removeFromSuperview];
    _dropDownMenuTableView=nil;
    
    self.dataSource = nil;
    
    [self btnEnable];
    
}



- (void)btnEnable
{
    // 所有 分类按钮  都变为 可点击
    for (NSInteger i=0; i<self.dataSourceArr.count; i++) {
        UIButton *btn = self.titleBtnArr[i];
        btn.enabled = YES;
    }
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.font = CF_Font_15;
    }
    
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    // KVC
    NSArray *textArr = [self.titleBtnArr valueForKeyPath:@"titleLabel.text"];
    
    
    if (self.stateConfigDict[@"selected"]) {
        if ([textArr containsObject:cell.textLabel.text]){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.tintColor = self.stateConfigDict[@"selected"][0];
            cell.textLabel.textColor = self.stateConfigDict[@"selected"][0];
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.textColor = CF_Color_TextDarkGrayColor;
        }
    }else {
        if ([textArr containsObject:cell.textLabel.text]){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.textLabel.textColor = CF_Color_DefaultColor;
            cell.tintColor = CF_Color_DefaultColor;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.textColor = CF_Color_TextDarkGrayColor;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 改变标题展示 及 颜色
    NSMutableArray *currentTitleArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.dataSourceArr.count; i++) {
        UIButton *btn = self.titleBtnArr[i];
        if (!btn.enabled) {
            [btn setTitle:self.dataSource[indexPath.row] forState:UIControlStateNormal];
            // 改变颜色
            if (self.stateConfigDict[@"selected"]) {
                UIImage *image = [UIImage imageNamed:self.stateConfigDict[@"selected"][1]];
                if (image) {  // 使用自己app中的图片
                    [self changTintColorWithTintColor:self.stateConfigDict[@"selected"][0] tintColorImgName:self.stateConfigDict[@"selected"][1] ForButton:self.titleBtnArr[i]];
                } else {  // 使用CFDropDownMenuView.bundle自带的
                    NSString *str = [NSString stringWithFormat:@"%@.png", self.stateConfigDict[@"selected"][1]];
                    NSString *imgName = CFDrowMenuViewSrcName(str)?:CFDrowMenuViewFrameworkSrcName(str);
                    [self changTintColorWithTintColor:self.stateConfigDict[@"selected"][0] tintColorImgName:imgName ForButton:self.titleBtnArr[i]];
                }
                
            } else {  // 未设置样式---选中的时候默认 使用CFDropDownMenuView.bundle自带的
                [self changTintColorWithTintColor:CF_Color_DefaultColor tintColorImgName:CFDrowMenuViewSrcName(@"天蓝箭头.png")?:CFDrowMenuViewFrameworkSrcName(@"天蓝箭头.png") ForButton:btn];
            }
            
        }
        [currentTitleArr addObject:btn.titleLabel.text];
    }
    
    /**
     *  筛选条件后的回调方式 代理/block 二选一
     */
    // 调用代理 传参数(当前选中的分类) --- 走接口 请求数据
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropDownMenuView:clickOnCurrentButtonWithTitle:andCurrentTitleArray:)]) {
        [self.delegate dropDownMenuView:self clickOnCurrentButtonWithTitle:self.dataSource[indexPath.row] andCurrentTitleArray:currentTitleArr];
    }
    
    // 走block  3目运算,有block则执行;否则不执行
    !self.chooseConditionBlock?:self.chooseConditionBlock(self.dataSource[indexPath.row],currentTitleArr);
    
    // 移除
    [self removeSubviews];
    
}

#pragma mark - 改变(展示颜色)文字颜色及箭头颜色
- (void)changTintColorWithTintColor:(UIColor *)tintColor tintColorImgName:(NSString *)tintColorArrowImgName ForButton:(UIButton *)btn
{
    [btn setTitleColor:tintColor forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:tintColorArrowImgName] forState:UIControlStateNormal];
}


- (void)dealloc
{
    [self removeSubviews];
}


@end
