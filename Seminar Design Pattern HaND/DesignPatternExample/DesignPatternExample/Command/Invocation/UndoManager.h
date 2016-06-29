//
//  UndoManager.h
//  DesignPatternExample
//
//  Created by DucHa on 6/29/16.
//  Copyright © 2016 DucHa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UndoManager : NSObject
+ (instancetype)sharedInstance;
- (void)deleteObjectAtIndex:(NSInteger)index;
- (void)addObject:(NSString *)object atIndex:(NSInteger)index;
- (void)undoAction;
- (NSArray *)getObjects;
@end
