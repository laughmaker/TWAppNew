//
//  TableViewModel.m
//  TWApp
//
//  Created by line0 on 13-7-8.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "TableModel.h"

@interface TableModel ()
@property (strong, nonatomic) NSMutableArray *tableItems;
@property (assign, nonatomic) NSInteger      totalPage;
@property (assign, nonatomic) NSInteger      toPage;

//@property (copy, nonatomic) TWFinishedBlock  finishedBlock;
//@property (copy, nonatomic) TWFailedBlock    failedBlock;

//更新Model数据,子类可重写这个方法。
- (void)updateModelData:(NSDictionary *)datas;

@end

@implementation TableModel

- (id)init
{
    if ([super init])
    {
        [self resetRequestParams];
        self.tableItems = [NSMutableArray array];
    }
    return self;
}

- (void)resetRequestParams
{
    self.refreshData = YES;
    self.toPage      = 0;
    self.totalPage   = -1;
    [self.tableItems removeAllObjects];
}

- (void)requestDataWithParams:(NSDictionary *)params forPath:(NSString *)path finished:(TWFinishedBlock)finished failed:(TWFailedBlock)failed
{
    [super requestDataWithParams:params
                        forPath:path
                       finished:^(NSDictionary *data)
    {
        [self updateModelData:data];
        finished(data);
    }
                         failed:^(NSString *error)
    {
        failed(error);
    }];
}

- (void)updateModelData:(NSDictionary *)data
{
    self.totalPage = [data[@"total"] integerValue];
    self.toPage    = [data[@"index"] integerValue] + 1;
    [self.tableItems addObjectsFromArray:data[@"body"]];
}


@end
