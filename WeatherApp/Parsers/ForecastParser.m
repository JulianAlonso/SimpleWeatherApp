//
//  WeatherParser.m
//  WeatherApp
//
//  Created by Julian Alonso on 9/3/15.
//  Copyright (c) 2015 Julian. All rights reserved.
//

#import "ForecastParser.h"

@implementation ForecastParser

- (Forecast *)parseForecastWithData:(NSData *)data
{
    NSError *error;
    NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (!error)
    {
        if (jsonObjects)
        {
            Forecast *forecast = [[Forecast alloc] init];
            NSDictionary *newData = jsonObjects[@"list"];
            
            forecast.cityName = [[newData valueForKey:@"name"]firstObject];
            forecast.iconURL = [self iconUrlFromDictionary:newData];
            
            return forecast;
        }
    }
    
    return nil;
}

- (NSString *)iconUrlFromDictionary:(NSDictionary *)dictionary
{
    NSString *iconSuffix = [[[[dictionary valueForKey:@"weather"]firstObject] valueForKey:@"icon"]firstObject];
    return  [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", iconSuffix];
    
}

@end
