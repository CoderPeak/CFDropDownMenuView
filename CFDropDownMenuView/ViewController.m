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

@interface ViewController () <CFDropDownMenuViewDelegate, UITableViewDelegate, UITableViewDataSource>
/* 展示结果tableView */
@property (nonatomic, strong) UITableView *showTableView;
/* CFDropDownMenuView */
@property (nonatomic, strong) CFDropDownMenuView *dropDownMenuView;

/* 展示结果的 假数据源 */
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
/* 所有的 假数据源 */
@property (nonatomic, strong) NSMutableArray *allDataSourceArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 配置展示结果talbeview
    [self.view addSubview:self.showTableView];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, CFScreenWidth, 88)];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.backgroundColor = CFRandomColor;
    titleL.numberOfLines = 0;
    titleL.text = @"CFDropDownMenuView 展示demo\n交流QQ 545486205";
    [self.view addSubview:titleL];
    
    // 配置CFDropDownMenuView
    [self.view addSubview:self.dropDownMenuView];
    
    
}

#pragma mark - lazy
/* 配置CFDropDownMenuView */
- (CFDropDownMenuView *)dropDownMenuView
{
    // DEMO
    _dropDownMenuView = [[CFDropDownMenuView alloc] initWithFrame:CGRectMake(0, 104, CFScreenWidth, 45)];
    
    /**
     *  stateConfigDict 属性 格式 详见CFDropDownMenuView.h文件
     */
//    _dropDownMenuView.stateConfigDict = @{
//                                        @"selected" : @[[UIColor redColor], @"红箭头"],
//                                        };
//    _dropDownMenuView.stateConfigDict = @{
//                                        @"normal" : @[[UIColor orangeColor], @"测试黄"],
//                                        };
//    _dropDownMenuView.stateConfigDict = @{
//                                         @"selected" : @[CF_Color_DefaultColor, @"天蓝箭头"],
//                                         @"normal" : @[[UIColor orangeColor], @"橙箭头"]
//                                         };
    // 注:  需先 赋值数据源dataSourceArr二维数组  再赋值defaulTitleArray一维数组
    _dropDownMenuView.dataSourceArr = @[
//                                        @[@"全部", @"iOS开发", @"安卓开发", @"JAVA开发", @"PHP开发",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m"],
                                        @[@"全部", @"iOS开发", @"安卓开发", @"JAVA开发", @"PHP开发"],
                                        @[@"5-10k", @"10-15k", @"15-20k", @"20k以上"],
                                        @[@"1年以内", @"1-3年", @"3-5年", @"5年以上"]
                                        ].mutableCopy;
    
    _dropDownMenuView.defaulTitleArray = [NSArray arrayWithObjects:@"工作岗位",@"薪资", @"工作经验", nil];
    
    _dropDownMenuView.delegate = self;
    
    // 下拉列表 起始y
    _dropDownMenuView.startY = CGRectGetMaxY(_dropDownMenuView.frame);
    
    /**
     *  回调方式一: block
     */
    __weak typeof(self) weakSelf = self;
    _dropDownMenuView.chooseConditionBlock = ^(NSString *currentTitle, NSArray *currentTitleArray){
        /**
         实际开发情况 --- 仅需要拿到currentTitle / currentTitleArray 作为参数 向服务器请求数据即可
         */
        NSMutableString *totalTitleStr = [[NSMutableString alloc] init];
        NSMutableString *totalStr = [[NSMutableString alloc] init];
        for (NSInteger i = 0; i < currentTitleArray.count; i++) {
            if (!([currentTitleArray[i] isEqualToString:@"工作岗位"]
                  || [currentTitleArray[i] isEqualToString:@"薪资"] || [currentTitleArray[i] isEqualToString:@"工作经验"])) {
                [totalStr appendString:currentTitleArray[i]];
            }
            
            if (0 == i) {
                [totalTitleStr appendString:@"("];
            }
            [totalTitleStr appendString:currentTitleArray[i]];
            if (i == currentTitleArray.count-1) {
                [totalTitleStr appendString:@")"];
                break ;
            }
            [totalTitleStr appendString:@"---"];
            
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"职位筛选信息" message:[NSString stringWithFormat:@"您当前选中的是\n(%@)\n 当前所有展示的是\n%@", currentTitle, totalTitleStr] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 匹配数据源
            NSString *totalString = totalStr;
            // 如果筛选条件包含全部, 则截取掉
            if ([totalStr containsString:@"全部"]) {
                totalString = [totalStr stringByReplacingOccurrencesOfString:@"全部" withString:@""];
            }
            NSLog(@"totalString  %@", totalString);
            if (totalString.length != 0) {  // 条件 只是  全部
                NSArray *allDataSourceArr = weakSelf.allDataSourceArr;
                NSMutableArray *tempArr = [[NSMutableArray alloc] init];
                for (NSInteger i = 0; i < allDataSourceArr.count; i++) {
                    NSString *str = allDataSourceArr[i];
                    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
                    
                    if ([str containsString:totalString]) {
                        [tempArr addObject:allDataSourceArr[i]];
                    }
                }
                // 赋值筛选后的数据源
                weakSelf.dataSourceArr = tempArr;
                NSLog(@"筛选后数据源  %@", weakSelf.dataSourceArr);
                
                // 重新刷新表格  --  显示刷新后的数据
                [weakSelf.showTableView reloadData];
            }
            
            
            UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"共有 %zd 条结果", weakSelf.dataSourceArr.count] preferredStyle:UIAlertControllerStyleAlert];
            [weakSelf presentViewController:alertController2 animated:NO completion:^{
                UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertController2 addAction:alertAction2];
            }];
            
        }];
        [alertController addAction:alertAction];
        [weakSelf presentViewController:alertController animated:NO completion:^{
        }];
    };
    
    
    return _dropDownMenuView;
    
}

/* 展示结果showTableView */
- (UITableView *)showTableView
{
    if (!_showTableView) {
        _showTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, CFScreenWidth, CFScreenHeight) style:UITableViewStyleGrouped];
        _showTableView.contentInset = UIEdgeInsetsMake(0, 0, 130, 0);
        _showTableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.dropDownMenuView.cf_height, 0, _showTableView.cf_y, 0);
        _showTableView.delegate = self;
        _showTableView.dataSource = self;
        _showTableView.backgroundColor = CF_Color_DefalutBackGroundColor;
        
        // 配置假数据源
        NSMutableArray *dataSourceArr = @[].mutableCopy;
        for (NSInteger i = 0; i < 3; i++) {
            NSString *iOS = @"iOS开发   5-10k 1年以内";
            NSString *android = @"安卓开发   5-10k  1年以内";
            NSString *JAVA = @"JAVA开发  5-10k 1年以内";
            NSString *PHP = @"PHP开发   5-10k 1年以内";
            [dataSourceArr addObject:iOS];
            [dataSourceArr addObject:android];
            [dataSourceArr addObject:JAVA];
            [dataSourceArr addObject:PHP];
        }
        for (NSInteger i = 0; i < 3; i++) {
            NSString *iOS = @"iOS开发   5-10k  1-3年";
            NSString *android = @"安卓开发  5-10k   1-3年";
            NSString *JAVA = @"JAVA开发  5-10k 1-3年";
            NSString *PHP = @"PHP开发   5-10k 1-3年";
            [dataSourceArr addObject:iOS];
            [dataSourceArr addObject:android];
            [dataSourceArr addObject:JAVA];
            [dataSourceArr addObject:PHP];
        }
        for (NSInteger i = 0; i < 2; i++) {
            NSString *JAVA = @"JAVA开发  10-15k 1年以内";
            NSString *PHP = @"PHP开发   10-15k 1年以内";
            [dataSourceArr addObject:JAVA];
            [dataSourceArr addObject:PHP];
        }
        for (NSInteger i = 0; i < 2; i++) {
            NSString *iOS = @"iOS开发   10-15k 1-3年";
            NSString *android = @"安卓开发   10-15k 1-3年";
            NSString *JAVA = @"JAVA开发  10-15k 1-3年";
            NSString *PHP = @"PHP开发   10-15k 1-3年";
            [dataSourceArr addObject:iOS];
            [dataSourceArr addObject:android];
            [dataSourceArr addObject:JAVA];
            [dataSourceArr addObject:PHP];
        }
        for (NSInteger i = 0; i < 2; i++) {
            NSString *iOS = @"iOS开发   10-15k 3-5年";
            NSString *android = @"安卓开发   10-15k 3-5年";
            NSString *JAVA = @"JAVA开发  10-15k 3-5年";
            NSString *PHP = @"PHP开发   10-15k 3-5年";
            [dataSourceArr addObject:iOS];
            [dataSourceArr addObject:android];
            [dataSourceArr addObject:JAVA];
            [dataSourceArr addObject:PHP];
        }
        for (NSInteger i = 0; i < 2; i++) {
            NSString *JAVA = @"JAVA开发  10-15k 5年以上";
            NSString *PHP = @"PHP开发   10-15k 5年以上";
            [dataSourceArr addObject:JAVA];
            [dataSourceArr addObject:PHP];
        }
        for (NSInteger i = 0; i < 3; i++) {
            NSString *iOS = @"iOS开发   15-20k 1-3年";
            NSString *android = @"安卓开发   15-20k 1-3年";
            NSString *JAVA = @"JAVA开发  15-20k 1-3年";
            NSString *PHP = @"PHP开发   15-20k 1-3年";
            [dataSourceArr addObject:iOS];
            [dataSourceArr addObject:android];
            [dataSourceArr addObject:JAVA];
            [dataSourceArr addObject:PHP];
        }
        for (NSInteger i = 0; i < 2; i++) {
            NSString *iOS = @"iOS开发   15-20k 3-5年";
            NSString *android = @"安卓开发   15-20k 3-5年";
            NSString *JAVA = @"JAVA开发  15-20k 5年以上";
            NSString *PHP = @"PHP开发   15-20k 5年以上";
            [dataSourceArr addObject:iOS];
            [dataSourceArr addObject:android];
            [dataSourceArr addObject:JAVA];
            [dataSourceArr addObject:PHP];
        }
        for (NSInteger i = 0; i < 2; i++) {
            NSString *iOS = @"iOS开发   20k以上 3-5年";
            NSString *android = @"安卓开发  20k以上   3-5年";
            NSString *JAVA = @"JAVA开发  20k以上  5年以上";
            NSString *PHP = @"PHP开发   20k以上 5年以上";
            [dataSourceArr addObject:iOS];
            [dataSourceArr addObject:android];
            [dataSourceArr addObject:JAVA];
            [dataSourceArr addObject:PHP];
        }
        for (NSInteger i = 0; i < 3; i++) {
            NSString *iOS = @"iOS开发   20k以上  5年以上";
            NSString *android = @"安卓开发   20k以上  5年以上";
            [dataSourceArr addObject:iOS];
            [dataSourceArr addObject:android];
            
        }
        _dataSourceArr = dataSourceArr;
        _allDataSourceArr = dataSourceArr;
    }
    return _showTableView;
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    NSString *str = self.dataSourceArr[indexPath.row];
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 6)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, 8)];
    
    cell.textLabel.attributedText = attributedString;
    
    
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
