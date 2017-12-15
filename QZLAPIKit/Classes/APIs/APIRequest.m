//
//  BaseAPIRequest.m
//  FlowerField
//
//  Created by kepuna on 2017/9/5.
//  Copyright © 2017年 Triangle. All rights reserved.
//

#import "APIRequest.h"
#import "APIConnectTool.h"
#import "DBCacheManager.h"
#import "NSError+NXAdd.h"
#import "NetworkHelper.h"
#import "APIResponseStructureConfig.h"
#import "UMessage.h"
#import "NXLoginViewController.h"

//NSString * const APIErrorTipKey = @"APIErrorTipKey";

@interface APIRequest ()

@property (nonatomic, strong) APIResponseStructureConfig *config;

@end

@implementation APIRequest


- (instancetype)init {
    self = [super init];
    if ([self conformsToProtocol:@protocol(APIRequestProtocol)]) {
        self.request = (id<APIRequestProtocol>)self;
        self.method = POST;
        self.indexPage = 1;
        self.dataSource = @[].mutableCopy;
        self.requestParams = @{}.mutableCopy;
        self.config = [APIResponseStructureConfig sharedConfig];
        if (!self.config.resCode || !self.config.data || !self.config.successCode || !self.config.message) {
           NSAssert(NO, @"请配置resCode|successCode|data|message相关字段信息");
        }
    } else {
        // 子类不遵守这个protocol的就会crash，防止派生类乱来。
        NSAssert(NO, @"子类必须要实现APIManager这个protocol");
    }
    return self;
}

- (void)loadNewRuquest {
    self.indexPage = 1;
    [self.dataSource removeAllObjects];
    NSString *url = [self.request apiRequestURL];
    NSDictionary *params = [self.request apiRequestParams];
    NSString *cacheKey = [APIConnectTool connectBaseUrl:url params:params.mutableCopy];
    
    [[NetworkHelper sharedInstance] requestMethod:self.method url:url parameters:params finishBlock:^(id data, NSError *error) {
    
        if (error && self.isCache) { // 网络请求错误
            NSDictionary *cacheData = [[DBCacheManager sharedManager] itemWithCacheKey:cacheKey];
            if (!cacheData) {
                [self errorCallBack:error errorCode:nil errorMsg:nil];
                return;
            }
            [self successCallBack:cacheData];
            return;
        }

        if ([data[self.config.resCode] isEqualToString:self.config.successCode]) {
            [self successCallBack:data[self.config.data]];
            if (self.isCache) {
                [[DBCacheManager sharedManager] insertItem:data[self.config.data] cacheKey:cacheKey];
            }
        } else {
            if ([data[self.config.resCode] hasPrefix:@"11"]) {
                [NXUserInfoModel logout];
                 [UIApplication sharedApplication].keyWindow.rootViewController = [[NXLoginViewController alloc]init];
            }
            [self errorCallBack:error errorCode:data[self.config.resCode] errorMsg:data[self.config.message]];
        }
    }];
}

- (void)successCallBack:(id)respose {
    if ([self.delegate respondsToSelector:@selector(apiResponseSuccess:request:)]) {
        [self.delegate apiResponseSuccess:respose request:self.request];
    }
}

- (void)errorCallBack:(NSError *)error errorCode:(NSString *)code errorMsg:(NSString *)msg {
    
    NSString *errorMsg = msg;
    if (error.code == -1009) {
        errorMsg = @"请检查您的网络";
    } else if (error.code == -1004) {
        errorMsg = @"无法连接服务器";
    } else if (error.code == -1001) {
        errorMsg = @"网络请求超时";
    } else if (error.code == -1011) {
        errorMsg = @"服务器内部错误";
    } else if (error.code == 3840) {
        errorMsg = @"数据错误";
    }
    
    NSError *errorObj = [NSError errorWithCode:[code integerValue]];
    if ([self.delegate respondsToSelector:@selector(apiResponseError:request:errorMsg:)]) {
        [self.delegate apiResponseError:errorObj request:self.request errorMsg:errorMsg];
    }
}

- (void)loadMoreRequest {
    
    self.indexPage++;
    NSString *url = [self.request apiRequestURL];
    NSDictionary *params = [self.request apiRequestParams];
    
    [[NetworkHelper sharedInstance] requestMethod:self.method url:url parameters:params finishBlock:^(id data, NSError *error) {
        
        if (error) { //网络请求错误
            self.indexPage--;
            [self errorCallBack:error errorCode:nil errorMsg:nil];
            return ;
        }
        
        if ([data[self.config.resCode] isEqualToString:self.config.successCode]) {
            [self successCallBack:data[self.config.data]];
        } else {
            [self errorCallBack:error errorCode:data[self.config.resCode] errorMsg:data[self.config.message]];
        }
    }];
}

- (void)dealloc {
    [[NetworkHelper sharedInstance] cancelAllRequest];
    NSLog(@"#### %@ 销毁了###",[self class]);
}

@end
