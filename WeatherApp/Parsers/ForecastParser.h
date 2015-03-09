//
//  WeatherParser.h
//  WeatherApp
//
//  Created by Julian Alonso on 9/3/15.
//  Copyright (c) 2015 Julian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Forecast.h"

@interface ForecastParser : NSObject

- (Forecast *)parseForecastWithData:(NSData *)data;

- (NSArray *)parseWeekForecastWithData:(NSData *)data;

@end
