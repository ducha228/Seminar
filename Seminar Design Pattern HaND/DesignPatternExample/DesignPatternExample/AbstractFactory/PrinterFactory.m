//
//  PrinterFactory.m
//  DesignPatternExample
//
//  Created by DucHa on 6/27/16.
//  Copyright © 2016 DucHa. All rights reserved.
//

#import "PrinterFactory.h"
#import "EpsonPrinter.h"
#import "StarPrinter.h"
#import "ConsolePrinter.h"

@implementation PrinterFactory
+ (id<MasterPrinter>)createPrinter:(PrinterType)printerType {
    switch (printerType) {
        case PrinterTypeEpson:
            return [[EpsonPrinter alloc] init];
        case PrinterTypeStar:
            return [[StarPrinter alloc] init];
        default:
            return [[ConsolePrinter alloc] init];
    }
}
@end
