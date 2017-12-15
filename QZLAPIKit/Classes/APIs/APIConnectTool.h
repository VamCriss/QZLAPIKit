//
//  APIConnectTool.h
//  NCube
//
//  Created by kepuna on 2017/10/27.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIConnectTool : NSObject

/**
 将传递进来的参数拼接成url

 @param baseUrl baseUrl
 @param params 请求参数
 @return 拼接好的Url
 */
+ (NSString *)connectBaseUrl:(NSString *)baseUrl params:(NSMutableDictionary *)params;

@end
