//
//  ViewController.m
//  WeatherApp
//
//  Created by Julian Alonso on 9/3/15.
//  Copyright (c) 2015 Julian. All rights reserved.
//

#import "ViewController.h"
#import "WeatherAPIProvider.h"
#import "ForecastParser.h"
#import "Forecast.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self downloadCurrentForecast];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadCurrentForecast
{
    __weak typeof(self) weakSelf = self;
    [self.weatherAPIHelper currentDayForecastWithCompletionBlock:^(NSData *resultData) {
        __strong typeof(weakSelf) strongSelf = self;
        
        Forecast *todayWeather = [strongSelf.forecastParser parseForecastWithData:resultData];
        NSLog(@"Forecast in %@", todayWeather.cityName);
    }];
}

#pragma mark - Lazy getters.
- (id<WeatherAPIHelper>)weatherAPIHelper
{
    if (!_weatherAPIHelper)
    {
        _weatherAPIHelper = [[WeatherAPIProvider alloc] init];
    }
    return _weatherAPIHelper;
}

- (ForecastParser *)forecastParser
{
    if (!_forecastParser)
    {
        _forecastParser = [[ForecastParser alloc] init];
    }
    return _forecastParser;
}

@end
