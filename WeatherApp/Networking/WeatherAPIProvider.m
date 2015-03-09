//
//  WeatherAPIProvider.m
//  WeatherApp
//
//  Created by Julian Alonso on 9/3/15.
//  Copyright (c) 2015 Julian. All rights reserved.
//

#import "WeatherAPIProvider.h"

@implementation WeatherAPIProvider

- (void)currentDayForecastWithCompletionBlock:(void (^)(NSData *))completionBlock
{
    NSString *weatherURL = @"http://api.openweathermap.org/data/2.5/find?q=Madrid,es&units=metric";
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:[NSURL URLWithString:weatherURL]
           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               //TODO: check errors.
               completionBlock(data);
    }] resume];
}

- (void)nextWeekForecastWithCompletionBlock:(void (^)(NSData *))completionBlock
{
    NSString *weatherURL = @"http://speedy-bison-5608.vagrantshare.com/person/";//@"http://api.openweathermap.org/data/2.5/forecast/daily?q=Madrid,es&units=metric&cnt=7";
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:[NSURL URLWithString:weatherURL]
           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               //TODO: check errors.
               completionBlock(data);
    }] resume];
}

@end
