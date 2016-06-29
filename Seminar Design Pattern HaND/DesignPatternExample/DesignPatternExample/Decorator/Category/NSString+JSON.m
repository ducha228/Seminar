//
//  NSString+JSON.m
//  DesignPatternExample
//
//  Created by DucHa on 6/29/16.
//  Copyright © 2016 DucHa. All rights reserved.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)
- (id)objectFromJSONString {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    return json;
}
@end
