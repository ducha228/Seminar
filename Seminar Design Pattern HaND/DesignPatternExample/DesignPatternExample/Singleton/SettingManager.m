//
//  SettingManager.m
//  DesignPatternExample
//
//  Created by DucHa on 6/27/16.
//  Copyright © 2016 DucHa. All rights reserved.
//

#import "SettingManager.h"

@implementation SettingManager
+ (instancetype)sharedInstance {
    static SettingManager *instance = nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        instance = [[SettingManager alloc] init];
    });
    return instance;
}
@end
