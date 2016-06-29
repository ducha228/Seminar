//
//  ShopManager.m
//  DesignPatternExample
//
//  Created by DucHa on 6/27/16.
//  Copyright © 2016 DucHa. All rights reserved.
//

#import "ShopManager.h"
#import "NetworkManager.h"
#import "DataManager.h"
#import "SettingManager.h"

@interface ShopManager()
@property (nonatomic, strong) NetworkManager *networkManager;
@property (nonatomic, strong) DataManager *dataManager;
@end
@implementation ShopManager
+ (instancetype)sharedInstance {
    static ShopManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ShopManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    self.dataManager = [[DataManager alloc] init];
    self.networkManager = [[NetworkManager alloc] init];
    return self;
}

- (void)createShopWithDictionary:(NSDictionary *)dictionary {
    [self.dataManager saveWithDictionary:dictionary];
    if (![SettingManager sharedInstance].offlineEnable) {
        [self.networkManager postWithParameter:dictionary];
    }
}
@end
