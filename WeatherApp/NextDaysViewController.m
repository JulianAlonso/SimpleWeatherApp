//
//  NextDaysViewController.m
//  WeatherApp
//
//  Created by Julian Alonso on 9/3/15.
//  Copyright (c) 2015 Julian. All rights reserved.
//

#import "NextDaysViewController.h"
#import "WeatherAPIProvider.h"
#import "ForecastParser.h"
#import "WeatherTableViewCell.h"
#import "ImageDownloader.h"

NSString *const kWeatherCell = @"cell";

@interface NextDaysViewController ()

@property (weak, nonatomic) IBOutlet UITableView *weatherTableView;

@property (nonatomic, strong) NSArray *forecasts;

@end

@interface NextDaysViewController (DataSourceAndDelegate) <UITableViewDataSource, UITableViewDelegate>

@end

@implementation NextDaysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.weatherTableView.dataSource = self;
    self.weatherTableView.delegate = self;
    
    [self.weatherTableView registerNib:[UINib nibWithNibName:@"WeatherTableViewCell" bundle:nil] forCellReuseIdentifier:kWeatherCell];
    
    [self updateData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)updateData
{
    __weak typeof(self) weakSelf = self;
    [self.weatherAPIHelper nextWeekForecastWithCompletionBlock:^(NSData *resultData) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSArray *forecasts = [strongSelf.forecastParser parseWeekForecastWithData:resultData];
        
        strongSelf.forecasts = forecasts;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [strongSelf.weatherTableView reloadData];
        });
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

@implementation NextDaysViewController (DataSourceAndDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherTableViewCell *cell = [self.weatherTableView dequeueReusableCellWithIdentifier:kWeatherCell];
    
    Forecast *forecast = self.forecasts[indexPath.row];
    
    cell.cityNameLabel.text = forecast.cityName;
    cell.weatherDescriptionLabel.text = forecast.weatherDescription;
    cell.tempLabel.text = [NSString stringWithFormat:@"%.0f%%", forecast.temp];
    
    [ImageDownloader imageWithURL:forecast.iconURL completionBlock:^(UIImage *image) {
        
        cell.iconImageView.image = image;
        
    }];

    return cell;
}

@end
