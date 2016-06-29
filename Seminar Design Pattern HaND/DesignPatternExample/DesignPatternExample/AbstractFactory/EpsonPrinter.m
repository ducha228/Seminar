//
//  EpsonPrinter.m
//  DesignPatternExample
//
//  Created by DucHa on 6/27/16.
//  Copyright © 2016 DucHa. All rights reserved.
//

#import "EpsonPrinter.h"

@implementation EpsonPrinter
@synthesize delegate;

- (void)print {
    NSLog(@"Start printing to Epson printer");
    [self printWithCompletion:^(NSString *message) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didPrintSuccessWithResponse:)]) {
            [self.delegate didPrintSuccessWithResponse:message];
        }
    }];
    
}

- (void)printWithCompletion:(void (^)(NSString *message))completion {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        completion(@"Print to Epson printer successfully");
    });
}
@end
