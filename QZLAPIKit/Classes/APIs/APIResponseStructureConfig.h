//
//  APIResponseStructureConfig.h
//  NCube
//
//  Created by kepuna on 2017/11/10.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 配置网络请求返回的数据结构字段的名称
 */
@interface APIResponseStructureConfig : NSObject


/**
 状态码字段名称
 */
@property (nonatomic, copy) NSString *resCode;

/**
 成功标志状态码字段的名称
 */
@property (nonatomic, copy) NSString *successCode;

/**
 提示信息字段
 */
@property (nonatomic, copy) NSString *message;

/**
 返回数据字段的名称
 */
@property (nonatomic, copy) NSString *data;

+ (instancetype)sharedConfig;

@end
