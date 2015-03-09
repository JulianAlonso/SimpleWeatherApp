//
//  WeatherAPIHelper.h
//  WeatherApp
//
//  Created by Julian Alonso on 9/3/15.
//  Copyright (c) 2015 Julian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WeatherAPIHelper <NSObject>

- (void)currentDayForecastWithCompletionBlock:(void(^)(NSData *resultData))completionBlock;

- (void)nextWeekForecastWithCompletionBlock:(void(^)(NSData *resultData))completionBlock;

@end
