//
//  ViewController.m
//  edit-uitableview
//
//  Created by zzg on 2019/3/24.
//  Copyright © 2019 zzg. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * mytableview;

@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) NSMutableArray *deleteArr;//删除数据的数组
@property(nonatomic, strong) NSMutableArray *markArr;//标记数据的数组


@end

@implementation ViewController


- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithArray:@[@"科比·布莱恩特科比·布莱恩特科比·布莱恩特科比·布莱恩特科比·布莱恩特",@"德里克·罗斯",@"勒布朗·詹姆斯",@"凯文·杜兰特",@"德怀恩·韦德",@"克里斯·保罗",@"德怀特·霍华德",@"德克·诺维斯基",@"德隆·威廉姆斯",@"斯蒂夫·纳什",@"保罗·加索尔",@"布兰顿·罗伊",@"奈特·阿奇博尔德",@"鲍勃·库西",@"埃尔文·约翰逊"]];
        
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.deleteArr = [NSMutableArray array];
    self.markArr = [NSMutableArray array];
    
    self.mytableview = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.mytableview.delegate = self;
    self.mytableview.dataSource = self;
    [self.view addSubview:self.mytableview];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 50);
    [btn setTitle:@"选择" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton * btnall = [UIButton buttonWithType:UIButtonTypeCustom];
    btnall.frame = CGRectMake(100, 170, 100, 50);
    [btnall setTitle:@"全选" forState:UIControlStateNormal];
    [btnall setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnall.backgroundColor = [UIColor redColor];
    [btnall addTarget:self action:@selector(btnallClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnall];
    
}
- (void)btnClick {
    self.mytableview.allowsMultipleSelectionDuringEditing = YES;
    self.mytableview.editing = !self.mytableview.editing;
}
- (void)btnallClick {
    for (int i = 0; i < self.dataArray.count; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [self.mytableview selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    [self.deleteArr addObjectsFromArray:self.dataArray];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ids"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ids"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * item = [self.dataArray objectAtIndex:indexPath.row];
    [self.deleteArr addObject:item];
    NSLog(@"----???%@---->>>count:%ld",item,self.deleteArr.count);
}
//取消选中时 将存放在self.deleteArr中的数据移除
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.deleteArr removeObject:[self.dataArray objectAtIndex:indexPath.row]];
    NSLog(@"==>>>%@-----ccount:%ld",self.deleteArr,self.deleteArr.count);
}



@end
