//
//  APIConnectTool.m
//  NCube
//
//  Created by kepuna on 2017/10/27.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import "APIConnectTool.h"

@implementation APIConnectTool

+ (NSString *)connectBaseUrl:(NSString *)baseUrl params:(NSMutableDictionary *)params {
    
    NSString *str = @"&";
    for(id key in params) {
        str = [str stringByAppendingString:key];
        str = [str stringByAppendingString:@"＝"];
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@",[params objectForKey:key]]];
        str = [str stringByAppendingString:@"&"];
    }
    
    if (str.length > 1) {// 处理多余的&以及返回含参url
        str = [str substringToIndex:str.length - 1];// 去掉末尾的&
        return [baseUrl stringByAppendingString:str];// 返回含参url
    }
    return Nil;
}


@end
