# CFDropDownMenuView (交流QQ 545486205)
### 简单好用的, 可自定义选中和非选中状态样式的 下拉列表菜单选择筛选条件的控件

##### 支持pod导入
##### pod 'CFDropDownMenuView'

### demo展示 - 由于网络原因, 可能gif效果图会展示的比较卡, 可以下载运行查看demo---简单使用代码在gif图片下面
### 特别注意 
- 用cocoapods导入使用的时候, 项目没任何问题
- 但是仅在下载demo的时候 .bundle资源包实际上已经下载到您本地 但是不知为何, 用xcode打开项目的时候 xcode不能识别.bundle资源包.  右击项目文件 show in finder  即可以查看到.bundle资源包   然后手动拖入xcode即可  此时箭头就会随下拉列表的展示/缩回 进行旋转动画
![](/showdemo.gif) 
### 使用
- 创建

```
//  创建
    CFDropDownMenuView *dropDownMenuView = [[CFDropDownMenuView alloc] initWithFrame:CGRectMake(0, 104, [UIScreen mainScreen].bounds.size.width, 45)];            
       
     /**
     *  stateConfigDict 属性 格式 详见CFDropDownMenuView.h文件
     *  可不传  使用默认样式  /   也可自定义样式
     */
//    dropDownMenuView.stateConfigDict = @{
//                                        @"selected" : @[[UIColor redColor], @"红箭头"],
//                                        };
//    dropDownMenuView.stateConfigDict = @{
//                                        @"normal" : @[[UIColor orangeColor], @"测试黄"],
//                                        };
//    dropDownMenuView.stateConfigDict = @{
//                                         @"selected" : @[CF_Color_DefaultColor, @"天蓝箭头"],
//                                         @"normal" : @[[UIColor orangeColor], @"橙箭头"]
//                                         };                                        };
    // 注:  需先 赋值数据源dataSourceArr二维数组  再赋值defaulTitleArray一维数组
    dropDownMenuView.dataSourceArr = @[
                                        @[@"全部", @"iOS开发", @"安卓开发", @"JAVA开发", @"PHP开发"],
                                        @[@"5-10k", @"10-15k", @"15-20k", @"20k以上"],
                                        @[@"1年以内", @"1-3年", @"3-5年", @"5年以上"]
                                        ].mutableCopy;
    
    dropDownMenuView.defaulTitleArray = [NSArray arrayWithObjects:@"工作岗位",@"薪资", @"工作经验", nil];
    // 设置代理
    dropDownMenuView.delegate = self;
    
    // 下拉列表 起始y
    dropDownMenuView.startY = CGRectGetMaxY(dropDownMenuView.frame);
    
    /**
     *  回调方式一: block
     */
    __weak typeof(self) weakSelf = self;
    dropDownMenuView.chooseConditionBlock = ^(NSString *currentTitle, NSArray *currentTitleArray){
    	NSLog(@"当前选中的是%@    展示的所有条件是%@", currentTitle, currentTitleArray);
    };
    // 添加到父视图中
    [self.view addSubview:dropDownMenuView];
```

```
 /**
  *  回调方式二: 代理
  */
- (void)dropDownMenuView:(CFDropDownMenuView *)dropDownMenuView clickOnCurrentButtonWithTitle:(NSString *)currentTitle andCurrentTitleArray:(NSArray *)currentTitleArray{
	NSLog(@"当前选中的是%@    展示的所有条件是%@", currentTitle, currentTitleArray);
}

```
