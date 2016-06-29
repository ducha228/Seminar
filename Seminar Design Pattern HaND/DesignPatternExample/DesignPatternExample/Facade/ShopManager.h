//
//  ShopManager.h
//  DesignPatternExample
//
//  Created by DucHa on 6/27/16.
//  Copyright © 2016 DucHa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopManager : NSObject
+ (instancetype)sharedInstance;
- (void)createShopWithDictionary:(NSDictionary *)dictionary;
@end
