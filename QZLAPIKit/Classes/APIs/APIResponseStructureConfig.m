//
//  APIResponseStructureConfig.m
//  NCube
//
//  Created by kepuna on 2017/11/10.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import "APIResponseStructureConfig.h"
#import "DBCacheManager.h"

@implementation APIResponseStructureConfig

+ (instancetype)sharedConfig {
    
    static APIResponseStructureConfig *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[APIResponseStructureConfig alloc] init];
        [[DBCacheManager sharedManager] createTable];
    });
    return _instance;
}


@end
