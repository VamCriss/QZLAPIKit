//
//  APIRequest.h
//  FlowerField
//
//  Created by kepuna on 2017/9/5.
//  Copyright © 2017年 Triangle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIRequestProtocol.h"
#import "APIResponseProtocol.h"


//FOUNDATION_EXTERN NSString * const APIErrorTipKey;

@interface APIRequest : NSObject

/// reqeust对象
@property (nonatomic, weak) id<APIRequestProtocol> request;
/// response的代理对象
@property (nonatomic, weak) id<APIResponseProtocol> delegate;
/// 请求的方式POST／GET (默认是POST)
@property (nonatomic, strong) NSString *method;
/// 是否做缓存（默认是NO）
@property (nonatomic, assign) BOOL isCache;

/**
 当前请求的页码
 */
@property (nonatomic, assign) NSInteger indexPage;

/**
 data数组
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 辅助参数
 */
@property (nonatomic, strong) NSMutableDictionary *requestParams;

/**
 下拉加载最新数据
 */
- (void)loadNewRuquest;

/**
 上拉更多数据
 */
- (void)loadMoreRequest;

//- (__kindof APIRequest *)initWithParams:(NSDictionary *)params;

@end
