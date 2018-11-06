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

@property (nonatomic, assign, readwrite) BOOL isFirstPage;
@property (nonatomic, assign, readwrite) BOOL isLastPage;
@property (nonatomic, assign, readwrite) NSUInteger pageNumber;
@property (nonatomic, strong, readwrite) NSString *errorMessage;

@end

@implementation __APIManagerFileName__

@synthesize errorMessage = _errorMessage;

#pragma mark - life cycle
- (instancetype)init {
    if (self = [super init]) {
        self.validator = self;
        self.cachePolicy = __CachePolicy__;
        _pageSize = 10;
        _pageNumber = 0;
        _isFirstPage = YES;
        _isLastPage = NO;
    }
    return self;
}

#pragma mark - public methods
- (NSInteger)loadData {
    [self cleanData];
    return [super loadData];
}

- (void)loadNextPage {
    if (self.isLastPage) {
        if ([self.interceptor respondsToSelector:@selector(manager:didReceiveResponse:)]) {
            [self.interceptor manager:self didReceiveResponse:nil];
        }
        return;
    }

    if (!self.isLoading) {
        [super loadData];
    }
}

- (void)cleanData {
    [super cleanData];
    self.isFirstPage = YES;
    self.pageNumber = 0;
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    NSMutableDictionary *result = [params mutableCopy];
    if (result == nil) {
        result = [[NSMutableDictionary alloc] init];
    }

    if (result[@"limit"] == nil) {
        result[@"limit"] = @(self.pageSize);
    } else {
        self.pageSize = [result[@"limit"] integerValue];
    }

    if (result[@"offset"] == nil) {
        if (self.isFirstPage == NO) {
            result[@"offset"] = @(self.pageNumber * self.pageSize);
        } else {
            result[@"offset"] = @(0);
        }
    } else {
        self.pageNumber = [result[@"offset"] unsignedIntegerValue] / self.pageSize;
    }

    return result;
}

#pragma mark - interceptors
- (BOOL)beforePerformSuccessWithResponse:(XKURLResponse *)response {
    self.isFirstPage = NO;
    NSInteger totalPageCount = ceil([response.content[@"data"][@"total"] doubleValue]/(double)self.pageSize);
    if (self.pageNumber == totalPageCount - 1) {
        self.isLastPage = YES;
    } else {
        self.isLastPage = NO;
    }
    self.pageNumber++;
    return [super beforePerformSuccessWithResponse:response];
}

- (BOOL)beforePerformFailWithResponse:(XKURLResponse *)response {
    [super beforePerformFailWithResponse:response];
    self.errorMessage = response.content[@"info"];
    return YES;
}

#pragma mark - XKAPIManager
- (NSString *)methodName {
    return @"__MethodName__";
}

- (NSString *)serviceIdentifier {
    return XKServiceIdentifierAMap;
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

#pragma mark - getters and setters
- (NSUInteger)currentPageNumber {
    return self.pageNumber;
}

@end
