//
//  TestAPIManager.m
//  APIManagers
//
//  Created by casa's script.
//  Copyright © 2018年 casa. All rights reserved.
//

#import "TestAPIManager.h"
#import "APIManagersService.h"

NSString * const kTestAPIManagerParamKeyPage = @"page";

@interface TestAPIManager () <XKAPIManagerValidator>

@property (nonatomic, strong, readwrite) NSString *errorMessage;

@end

@implementation TestAPIManager

@synthesize errorMessage = _errorMessage;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.validator = self;
        self.cachePolicy = XKAPIManagerCachePolicyNoCache;
    }
    return self;
}

#pragma mark - XKAPIManager
- (NSString *)methodName {
    return @"TestAPIManager";
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
