//
//  BaseModel.m
//  NSinvocation练习
//
//  Created by mac on 15-10-27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>
@implementation BaseModel
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        if (aDecoder == nil) {
            return self;
        }
        NSMutableArray *propertyArray = [self getPropertyNameArray];
        for (NSString *name in propertyArray) {
            id value = [aDecoder decodeObjectForKey:name];
            [self setValue:value forKey:name];
        }
    }
    return  self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    NSMutableArray *propertyArray = [self getPropertyNameArray];
    for (NSString *name in propertyArray) {
        id values = [self valueForKey:name];
        [aCoder encodeObject:values forKey:name];
    }
}
- (id)copyWithZone:(NSZone *)zone
{
    id objcCopy = [[[self class] allocWithZone:zone] init];
    NSMutableArray *propertyArray = [self getPropertyNameArray];
    for (NSString *name in propertyArray) {
        id value = [self valueForKey:name];
        if ([value respondsToSelector:@selector(copyWithZone:)]) {
            [objcCopy setValue:[value copy] forKey:name];
        } else {
            [objcCopy setValue:value forKey:name];
        }
    }
    return objcCopy;
}
- (id)mutableCopyWithZone:(NSZone *)zone
{
    id objcCopy = [[[self class] allocWithZone:zone]init];
    NSMutableArray *propertyArray = [self getPropertyNameArray];
    for(NSString *name in propertyArray){
        id value = [self valueForKey:name];
        if ([value respondsToSelector:@selector(mutableCopyWithZone:)]) {
            [objcCopy setValue:[value mutableCopy] forKey:name];
        } else {
            [objcCopy setValue:value forKey:name];
        }
    }
    return objcCopy;
}

- (NSString*)description
{
    NSMutableArray *propertyNameArray = [self getPropertyNameArray];
    NSMutableString *descrip = [[NSMutableString alloc]initWithCapacity:100];
    for (NSString *name in propertyNameArray) {
        [descrip appendFormat:@"[%@=%@]",name,[self valueForKey:name]];
    }
    
    return [NSString stringWithFormat:@"%@:{%@}",[super description],descrip];
//    NSMutableString *descrip = [[NSMutableString alloc]initWithCapacity:100];
//    NSMutableArray *propertyNameArray = [self getPropertyNameArray];
//    for (NSString *name in propertyNameArray) {
//        SEL getSel = NSSelectorFromString(name);
//        if ([self respondsToSelector:getSel]) {
//            NSMethodSignature *signature = nil;
//            signature = [self methodSignatureForSelector:getSel];
//            NSInvocation *invocaton = [NSInvocation invocationWithMethodSignature:signature];
//            [invocaton setTarget:self];
//            [invocaton setSelector:getSel];
//            NSObject *valueObjc = nil;
//            [invocaton invoke];
//            [invocaton getReturnValue:&valueObjc];
//            [descrip appendFormat:@"[%@=%@]",name,[self valueForKey:name]];
//        }
//    }
//    return [NSString stringWithFormat:@"%@:{%@}",[super description],descrip];
}
//获取属性
- (NSMutableArray *)getPropertyNameArray
{
    Class clazz = [self class];
    u_int count;
    objc_property_t *properties = class_copyPropertyList(clazz, &count);
    NSMutableArray *propertyArray = [[NSMutableArray alloc]initWithCapacity:count];
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    free(properties);
    return propertyArray;
}

@end
