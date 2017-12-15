//
//  NSError+NXAdd.h
//  NCube
//
//  Created by kepuna on 2017/7/28.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (NXAdd)

+ (instancetype)errorWithCode:(NSInteger)code;
+ (instancetype)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)userInfo;

@end
