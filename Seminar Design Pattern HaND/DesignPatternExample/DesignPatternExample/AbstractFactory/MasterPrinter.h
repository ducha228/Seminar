//
//  MasterPrinter.h
//  DesignPatternExample
//
//  Created by DucHa on 6/29/16.
//  Copyright © 2016 DucHa. All rights reserved.
//

#ifndef MasterPrinter_h
#define MasterPrinter_h
@protocol PrinterDelegate <NSObject>
- (void)didPrintSuccessWithResponse:(NSString *)response;
@end
@protocol MasterPrinter <NSObject>
@property (nonatomic, weak) id<PrinterDelegate> delegate;
- (void)print;
@end

#endif /* MasterPrinter_h */
