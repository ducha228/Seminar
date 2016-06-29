//
//  UndoManager.m
//  DesignPatternExample
//
//  Created by DucHa on 6/29/16.
//  Copyright © 2016 DucHa. All rights reserved.
//

#import "UndoManager.h"

@interface UndoManager()
@property (nonatomic, strong) NSMutableArray *undoStack;
@property (nonatomic, strong) NSMutableArray *objects;
@end

@implementation UndoManager
+ (instancetype)sharedInstance {
    static UndoManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UndoManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    self.objects = [NSMutableArray arrayWithArray:@[@"Object 1", @"Object 2", @"Object 3", @"Object 4", @"Object 5", @"Object 6"]];
    self.undoStack = [NSMutableArray array];
    return self;
}

- (void)deleteObjectAtIndex:(NSInteger)index {
    NSString *deletedObject = self.objects[index];
    
    NSMethodSignature *signature = [self methodSignatureForSelector:@selector(addObject:atIndex:)];
    NSInvocation *undoInvocation = [NSInvocation invocationWithMethodSignature:signature];
    [undoInvocation setSelector:@selector(addObject:atIndex:)];
    [undoInvocation setTarget:self];
    //Index will start from 2
    [undoInvocation setArgument:&deletedObject atIndex:2];
    [undoInvocation setArgument:&index atIndex:3];
    [undoInvocation retainArguments];
    
    [self.undoStack addObject:undoInvocation];
    
    [self.objects removeObjectAtIndex:index];
}

- (void)addObject:(NSString *)object atIndex:(NSInteger)index {
    if (index < self.objects.count) {
        [self.objects insertObject:object atIndex:index];
    } else {
        [self.objects addObject:object];
    }
}

- (void)undoAction {
    if (self.undoStack.count > 0) {
        NSInvocation *undoInvocation = [self.undoStack lastObject];
        [self.undoStack removeLastObject];
        [undoInvocation invoke];
    }
}

- (NSArray *)getObjects {
    return self.objects;
}
@end
