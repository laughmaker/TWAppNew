//
//  TestViewController.m
//  TWApp
//
//  Created by line0 on 13-7-8.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "TestVC.h"
#import "TestCell.h"

#define kTestCellIdentifier @"TestCellIdentifier"

@interface TestVC ()
@property (strong, nonatomic) TableModel      *testModel;
@property (strong, nonatomic) TableDataSource *tableDataSource;
@property (strong, nonatomic) TableDelegate   *tableDelegate;

@end

@implementation TestVC

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self setTableViewDataSource];
    [self setTableViewDelegate];
    
    self.testModel = [[TableModel alloc] init];
    [self requestData];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
}


#pragma mark - Table DataSource && Delegate

- (void)setTableViewDataSource
{
    //配置Cell数据
    CellConfigureBlock cellConfigure = ^(TWCell *cell, NSDictionary *cellDatas)
    {
        [cell configureCellWithCellDatas:cellDatas];
    };
    self.tableDataSource = [[TableDataSource alloc] initWithCellIdentifier:kTestCellIdentifier cellconfigureBlock:cellConfigure];
    
    self.tableView.dataSource = self.tableDataSource;
}

- (void)setTableViewDelegate
{
    self.tableDelegate = [[TableDelegate alloc] init];
    self.tableView.delegate = self.tableDelegate;
    self.tableView.pullDelegate = self.tableDelegate;

    //配置高度
    CellHeightBlock cellHeight = ^(NSIndexPath *indexPath)
    {
        NSDictionary *items = self.tableDelegate.tableItems[indexPath.row];
        return [TestCell cellHeightForCellDatas:items];
    };
    [self.tableDelegate setCellHeight:cellHeight];
    
    //选中某行时代理
    SelectCellBlock selecCell = ^(NSIndexPath *indexPath, id item)
    {
        NSLog(@"row:%d", indexPath.row);
    };
    [self.tableDelegate setSelectCell:selecCell];
    
    //上拉加载更多
    TWLoadMoreDataBlock loadMoreData = ^(void)
    {
        [self requestData];
    };
    [self.tableDelegate setLoadMoreData:loadMoreData];

    //下拉刷新
    TWUpdateDataBlock updateData = ^(void)
    {
        //下拉刷新，先清除数据源。
        [self.testModel resetRequestParams];
        self.tableDataSource.tableItems = nil;
        self.tableDelegate.tableItems = nil;
        [self.tableView reloadData];
        
        [self requestData];
    };
    [self.tableDelegate setUpdateData:updateData];
}


#pragma mark - Model Data Update

- (void)requestData
{
    NSDictionary *parmas = @{@"lat": @"32.00943",
                             @"lon" : @"118.7821",
                             @"token" : @"00dc4e06842c3831716f31e34aa27e0f",
                             @"suid" : @"51d2b18e2acc93a82bd350191f68f34f",
                             @"pageindex" : @"0",
                             @"type" : @"-1"};
    [self.testModel requestDataWithParams:parmas
                                  forPath:kTestList
                                 finished:^(NSDictionary *data)
    {
        self.tableDataSource.tableItems = self.testModel.tableItems;
        self.tableDelegate.tableItems   = self.testModel.tableItems;
        [self.tableView reloadData];
        [self.tableView stopPullTableViewRefresh];
    }
                                   failed:^(NSString *error)
    {
        mAlertView(@"网络错误", error);
    }];
}



@end
