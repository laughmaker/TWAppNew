//
//  NetworkAPI.h
//  Line0New
//
//  Created by line0 on 13-4-8.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

//网络状态返回码,按需定义
typedef enum
{
    TWSucceed            = 100,              //请求成功
    TWFailed             = 101,              //请求失败
    TWNeedLogin          = 103,              //需要重新登录
    
}TWStatusCode;

//操作系统平台
typedef enum
{
    TWWeb            = 0,
    TWAndroid        = 1,
    TWiOS            = 3,
    TWWindowsPhone   = 4
} TWOSPlatform;

//线上主站点地址
#define kHostSite               @"www.mayibangbang.com/index.php/api/"

//图片前缀地址
#define kImagePrex              @"http://mybb.leepood.com/"

//主页新鲜事
#define kTestList               @"getFeeds"


