//
//  ViewController.m
//  TestVisual_format_language
//
//  Created by wc on 5/15/15.
//  Copyright (c) 2015 wc. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *rows;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rows = [NSMutableArray array];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _tableView.estimatedRowHeight = 44;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_tableView]-0-|" options:0 metrics:0 views:@{@"_tableView":_tableView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_tableView]-|" options:0 metrics:0 views:@{@"_tableView":_tableView}]];
    
    [self createData];
}

- (void)createData
{
    for (int i = 0; i <20; i++) {
        CustomModel *model = [CustomModel new];
        model.title = @"标题标题标题标题标题";
        model.detail = @"详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情详情";
        if (i%2) {
            model.detail = @"不同的详情不同的详情不同的详情不同的详情不同的详情不同的详情不同的详情不同的详情不同的详情不同的详情不同的详情不同的详情不同的详情不同的详情不同的详情不同的详情不同的详情不同的详情不同的详情";
        }
        [self.rows addObject:model];
    }
    [self.tableView reloadData];
}


#pragma mark - tableview delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = self.rows[indexPath.row];
    return cell;
}
@end