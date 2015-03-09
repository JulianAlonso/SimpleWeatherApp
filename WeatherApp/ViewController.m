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
#import "ImageDownloader.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *minTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (nonatomic, strong) Forecast *currentForecast;

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
        
        strongSelf.currentForecast = [strongSelf.forecastParser parseForecastWithData:resultData];
        
        [strongSelf updateViewElements];
        
    }];
}

- (void)updateViewElements
{
    self.cityNameLabel.text = self.currentForecast.cityName;
    self.tempLabel.text = [NSString stringWithFormat:@"%f", self.currentForecast.temp];
    self.minTempLabel.text = [NSString stringWithFormat:@"%f", self.currentForecast.minTemp];
    self.maxTempLabel.text = [NSString stringWithFormat:@"%f", self.currentForecast.maxTemp];
    self.pressureLabel.text = [NSString stringWithFormat:@"%f", self.currentForecast.pressure];
    self.humidityLabel.text = [NSString stringWithFormat:@"%f", self.currentForecast.humidity];
    self.weatherDescriptionLabel.text = self.currentForecast.weatherDescription;
    
    [ImageDownloader imageWithURL:self.currentForecast.iconURL completionBlock:^(UIImage *image) {
        
        self.iconImageView.image = image;
        
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
