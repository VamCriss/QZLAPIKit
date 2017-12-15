//
//  NSError+NXAdd.m
//  NCube
//
//  Created by kepuna on 2017/7/28.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import "NSError+NXAdd.h"

@implementation NSError (NXAdd)

+ (instancetype)errorWithCode:(NSInteger)code {
   return [NSError errorWithDomain:NSCocoaErrorDomain code:code userInfo:nil];
}

+ (instancetype)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)userInfo {
     return [NSError errorWithDomain:NSCocoaErrorDomain code:code userInfo:userInfo];
}

@end
