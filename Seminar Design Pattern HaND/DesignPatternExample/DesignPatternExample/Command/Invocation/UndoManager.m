//
//  UndoManager.m
//  DesignPatternExample
//
//  Created by DucHa on 6/29/16.
//  Copyright © 2016 DucHa. All rights reserved.
//

#import "UndoManager.h"

@implementation UndoManager
+ (instancetype)sharedInstance {
    static UndoManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UndoManager alloc] init];
    });
    return instance;
}

- (void)deleteObjectAtIndex:(NSInteger)index {
    NSString *deletedObject = self.objects[index];
    
    NSMethodSignature *signature = [self methodSignatureForSelector:@selector(addObject:atIndex:)];
    NSInvocation *undoInvocation = [NSInvocation invocationWithMethodSignature:signature];
    [undoInvocation setSelector:@selector(addObject:atIndex:)];
    [undoInvocation setTarget:self];
    [undoInvocation setArgument:&deletedObject atIndex:0];
    [undoInvocation setArgument:&index atIndex:1];
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
        [undoInvocation invoke];
        [self.undoStack removeLastObject];
    }
}
@end
