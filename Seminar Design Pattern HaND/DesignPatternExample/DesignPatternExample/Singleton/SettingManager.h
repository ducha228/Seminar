//
//  SettingManager.h
//  DesignPatternExample
//
//  Created by DucHa on 6/27/16.
//  Copyright © 2016 DucHa. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    PrinterTypeEpson,
    PrinterTypeStar,
    PrinterTypeConsole
} PrinterType;

@interface SettingManager : NSObject
@property (nonatomic, assign) BOOL offlineEnable;
@property (nonatomic, assign) PrinterType printerType;
+ (instancetype)sharedInstance;
@end
