//
//  __APIManagerFileName__.h
//  APIManagers
//
//  Created by 浪漫恋星空.
//  Copyright © __year__年 浪漫恋星空. All rights reserved.
//

#import <XKNetworking/XKNetworking.h>

extern NSString * const k__APIManagerFileName__ParamKey<#API param name#>;

@interface __APIManagerFileName__ : XKAPIBaseManager <XKAPIManager, XKPagableAPIManager>

@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign, readonly) NSUInteger currentPageNumber;
@property (nonatomic, assign, readonly) BOOL isLastPage;

- (void)loadNextPage;

@end
