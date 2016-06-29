//
//  PrinterFactory.h
//  DesignPatternExample
//
//  Created by DucHa on 6/27/16.
//  Copyright © 2016 DucHa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MasterPrinter.h"
#import "SettingManager.h"

@interface PrinterFactory : NSObject
+ (id<MasterPrinter>)createPrinter:(PrinterType)printerType;
@end
