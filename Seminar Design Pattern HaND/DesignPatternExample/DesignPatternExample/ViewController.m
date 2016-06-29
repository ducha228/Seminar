//
//  ViewController.m
//  DesignPatternExample
//
//  Created by DucHa on 6/27/16.
//  Copyright © 2016 DucHa. All rights reserved.
//

#import "ViewController.h"
#import "SettingManager.h"
#import "PrinterFactory.h"
#import "ShopManager.h"
#import "NSString+JSON.h"

@interface ViewController () <PrinterDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [SettingManager sharedInstance].printerType = PrinterTypeStar;
    [SettingManager sharedInstance].offlineEnable = YES;
    [self print];
    [self createShop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)print {
    id<MasterPrinter> printer = [PrinterFactory createPrinter:[SettingManager sharedInstance].printerType];
    printer.delegate = self;
    [printer print];
}

- (void)createShop {
    [[ShopManager sharedInstance] createShopWithDictionary:@{@"shop":@"shop"}];
}
#pragma mark - PrinterDelegate
- (void)didPrintSuccessWithResponse:(NSString *)response {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Printer response" message:response preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
