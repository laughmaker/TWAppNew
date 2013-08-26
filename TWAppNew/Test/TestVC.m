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
@property (strong, nonatomic) TableDataSource *dataSource;
@property (strong, nonatomic) TableDelegate   *delegate;

@end

@implementation TestVC

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self setTableViewDataSource];
    [self setTableViewDelegate];
    [self setLoadMoreDataBlock];
    [self setUpdateDataBlock];
    
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
    CellConfigureBlock cellConfigure = ^(TWCell *cell, NSDictionary *cellDatas)
    {
        [cell configureCellWithCellDatas:cellDatas];
    };
    self.dataSource = [[TableDataSource alloc] initWithCellIdentifier:kTestCellIdentifier cellconfigureBlock:cellConfigure];
        
    [self.tableView setDataSource:self.dataSource];
}

- (void)setTableViewDelegate
{
    self.delegate = [[TableDelegate alloc] init];

    CellHeightBlock cellHeight = ^(NSIndexPath *indexPath)
    {
        NSDictionary *dict = self.delegate.tableItems[indexPath.row];
        return [TestCell cellHeightForCellDatas:dict];
    };
    [self.delegate setCellHeight:cellHeight];
    
    SelectCellBlock selecCell = ^(NSIndexPath *indexPath, id item)
    {
        NSLog(@"row:%d", indexPath.row);
    };
    [self.delegate setSelectCell:selecCell];
    
    [self.tableView setDelegate:self.delegate];
    [self.tableView setPullDelegate:self.delegate];
}

- (void)setLoadMoreDataBlock
{
    TWLoadMoreDataBlock loadMoreData = ^(void)
    {
        [self.testModel setRefreshData:NO];
        [self requestData];
    };
    [self.delegate setLoadMoreData:loadMoreData];
}

- (void)setUpdateDataBlock
{
    TWUpdateDataBlock updateData = ^(void)
    {
        [self.testModel resetRequestParams];
        [self requestData];
    };
    [self.delegate setUpdateData:updateData];
}


#pragma mark - Model Data Update

- (void)requestData
{
    NSDictionary *parmas = @{@"lat": @"32.00943",
                             @"lon" : @"118.7821",
                             @"token" : @"d47da4a56904e8d0070c86dc18e1fde2",
                             @"suid" : @"51d2b18e2acc93a82bd350191f68f34f",
                             @"pageindex" : @"0",
                             @"type" : @"-1"};
    [self.testModel requestDataWithParams:parmas
                                  forPath:kTestList
                                 finished:^(NSDictionary *data)
    {
        self.dataSource.tableItems = self.testModel.tableItems;
        self.delegate.tableItems   = self.testModel.tableItems;
        [self.tableView reloadData];
        [self.tableView stopPullTableViewRefresh];
    }
                                   failed:^(NSString *error)
    {
        mAlertView(@"网络错误", error);
    }];
}



@end
