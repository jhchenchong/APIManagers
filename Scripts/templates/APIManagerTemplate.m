//
//  __APIManagerFileName__.m
//  APIManagers
//
//  Created by 浪漫恋星空
//  Copyright © __year__年 浪漫恋星空. All rights reserved.
//

#import "__APIManagerFileName__.h"
#import "APIManagersService.h"

NSString * const k__APIManagerFileName__ParamKey<#API param name#> = @"<#API param name#>";

@interface __APIManagerFileName__ () <XKAPIManagerValidator>

@property (nonatomic, strong, readwrite) NSString *errorMessage;

@end

@implementation __APIManagerFileName__

@synthesize errorMessage = _errorMessage;

- (instancetype)init {
    if (self = [super init]) {
        self.validator = self;
        self.cachePolicy = __CachePolicy__;
    }
    return self;
}

#pragma mark - XKAPIManager
- (NSString *)methodName {
    return @"__MethodName__";
}

- (NSString *)serviceIdentifier {
    return XKServiceIdentifierAPIManagers;
}

- (XKAPIManagerRequestType)requestType {
    return XKAPIManagerRequestTypeGet;
}

#pragma mark - XKAPIManagerValidator
- (XKAPIManagerErrorType)manager:(XKAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data {
    return XKAPIManagerErrorTypeNoError;
}

- (XKAPIManagerErrorType)manager:(XKAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    return XKAPIManagerErrorTypeNoError;
}

#pragma mark - interceptors
- (BOOL)beforePerformFailWithResponse:(XKURLResponse *)response {
    [super beforePerformFailWithResponse:response];
    return YES;
}

@end
