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
            forecast.temp = [[[[newData valueForKeyPath:@"main"] firstObject] valueForKey:@"temp"] floatValue];
            forecast.minTemp = [[[[newData valueForKey:@"main"] firstObject] valueForKey:@"temp_min"] floatValue];
            forecast.maxTemp = [[[[newData valueForKey:@"main"] firstObject] valueForKey:@"temp_max"] floatValue];
            forecast.pressure = [[[[newData valueForKey:@"main"] firstObject] valueForKey:@"pressure"] floatValue];
            forecast.humidity = [[[[newData valueForKey:@"main"] firstObject] valueForKey:@"humidity"] floatValue];
            forecast.weatherDescription = [[[[newData valueForKey:@"weather"] firstObject] valueForKey:@"description"] firstObject];
            
            return forecast;
        }
    }
    
    return nil;
}

- (NSArray *)parseWeekForecastWithData:(NSData *)data
{
    NSError *error;
    NSDictionary *jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (!error)
    {
        if (jsonObjects)
        {
            NSMutableArray *array = [NSMutableArray array];
            NSString *cityName = [jsonObjects valueForKeyPath:@"city.name"];
            
            for (NSDictionary *dic in jsonObjects[@"list"])
            {
                Forecast *forecast = [[Forecast alloc] init];
                forecast.cityName = cityName;
                forecast.weatherDescription = [[[dic valueForKeyPath:@"weather"] firstObject] valueForKeyPath:@"description"];
                forecast.iconURL = [self iconUrlFromDictionary:dic];
                forecast.temp = [[dic valueForKeyPath:@"temp.eve"] floatValue];
                
                [array addObject:forecast];
            }
            return array;
        }
    }
    return nil;
}

- (NSString *)iconUrlFromDictionary:(NSDictionary *)dictionary
{
    NSString *iconSuffix = [[[dictionary valueForKey:@"weather"]firstObject] valueForKey:@"icon"];
    return  [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", iconSuffix];
}

@end
