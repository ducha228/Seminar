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
#import "Employee.h"

static void *employee1Context = &employee1Context;
static void *employee2Context = &employee2Context;

@interface ViewController () <PrinterDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField1;
@property (weak, nonatomic) IBOutlet UITextField *positionTextField1;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField2;
@property (weak, nonatomic) IBOutlet UITextField *positionTextField2;
@property (weak, nonatomic) IBOutlet UISwitch *onlineSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *printerTypeSegment;
@property (nonatomic, strong) Employee *employee1;
@property (nonatomic, strong) Employee *employee2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [SettingManager sharedInstance].printerType = self.printerTypeSegment.selectedSegmentIndex;
    [SettingManager sharedInstance].offlineEnable = !self.onlineSwitch.on;
    [self testKVO];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(buttonDidTap:) forControlEvents:UIControlEventTouchUpInside];
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
    [[ShopManager sharedInstance] createShopWithDictionary:@{@"shop" : @"shop"}];
}

- (void)testKVO {
    self.employee1 = [[Employee alloc] init];
    [self.employee1 setValue:@"Name1" forKey:@"name"];
    [self.employee1 setValue:@"Staff" forKey:@"position"];
    
    self.employee2 = [[Employee alloc] init];
    self.employee2.name = @"Name2";
    self.employee2.position = @"Manager";
    
    [self.employee1 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:employee1Context];
    [self.employee1 addObserver:self forKeyPath:@"position" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:employee1Context];
    
    [self.employee2 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:employee2Context];
    [self.employee2 addObserver:self forKeyPath:@"position" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:employee2Context];
}
#pragma mark - PrinterDelegate
- (void)didPrintSuccessWithResponse:(NSString *)response {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Printer response" message:response preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (context == employee1Context) {
        if ([keyPath isEqualToString:@"name"]) {
            NSLog(@"Name of employee1 changed: ");
            NSLog(@"%@", change);
        }
        if ([keyPath isEqualToString:@"position"]) {
            NSLog(@"Position of employee1 changed: ");
            NSLog(@"%@", change);
        }
    }
    
    if (context == employee2Context) {
        if ([keyPath isEqualToString:@"name"]) {
            NSLog(@"Name of employee2 changed: ");
            NSLog(@"%@", change);
        }
        if ([keyPath isEqualToString:@"position"]) {
            NSLog(@"Position of employee2 changed: ");
            NSLog(@"%@", change);
        }
    }
}

#pragma mark - Action handle
- (IBAction)printDidTap:(UIButton *)sender {
    [self print];
}

- (IBAction)createShopDidTap:(UIButton *)sender {
    [self createShop];
}

- (IBAction)changeDidTap:(UIButton *)sender {
    [self.employee1 setValue:self.nameTextField1.text forKey:@"name"];
    [self.employee1 setValue:self.positionTextField1.text forKey:@"position"];
    
    self.employee2.name = self.nameTextField2.text;
    self.employee2.position = self.positionTextField2.text;
}

- (IBAction)printerTypeChanged:(UISegmentedControl *)sender {
    [SettingManager sharedInstance].printerType = sender.selectedSegmentIndex;
}

- (IBAction)onlineChanged:(UISwitch *)sender {
    [SettingManager sharedInstance].offlineEnable = !sender.on;
}

@end
