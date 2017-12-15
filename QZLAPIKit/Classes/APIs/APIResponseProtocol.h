//
//  APIResponseProtocol.h
//  FlowerField
//
//  Created by kepuna on 2017/9/7.
//  Copyright © 2017年 Triangle. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIResponseProtocol <NSObject>

@optional;
/// 请求响应成功后的处理
- (void)apiResponseSuccess:(id)response request:(id<APIRequestProtocol>)request;
/// 请求响应失败后的处理
- (void)apiResponseFaild:(NSError *)faild request:(id<APIRequestProtocol>)request;

- (void)apiResponseError:(NSError *)error request:(id<APIRequestProtocol>)request errorMsg:(NSString *)errorMsg;

@end
