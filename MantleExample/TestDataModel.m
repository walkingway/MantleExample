//
//  TestDataModel.m
//  MantleExample
//
//  Created by cheng way on 8/15/15.
//  Copyright (c) 2015 chengway. All rights reserved.
//

#import "TestDataModel.h"

@implementation TestDataModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"date": @"dt",
             @"locationName": @"name",
             @"humidity": @"main.humidity",
             @"temperature": @"main.temp",
             @"tempHigh": @"main.temp_max",
             @"tempLow": @"main.temp_min",
             @"sunrise": @"sys.sunrise",
             @"sunset": @"sys.sunset",
             @"conditionDescription": @"weather.description",
             @"condition": @"weather.pp.aa.dd",
             @"icon": @"weather.icon",
             @"windBearing": @"wind.deg",
             @"windSpeed": @"wind.speed",
             @"name": @"name",
             @"id": @"id"
             };
}

+ (NSValueTransformer *)toDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *dateNum, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:dateNum.floatValue];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    }];
}

+ (NSValueTransformer *)dateJSONTransformer {
    return [[self class] toDateJSONTransformer];
}

+ (NSValueTransformer *)sunriseJSONTransformer {
    return [[self class] toDateJSONTransformer];
}

+ (NSValueTransformer *)sunsetJSONTransformer {
    return [[self class] toDateJSONTransformer];
}

@end
