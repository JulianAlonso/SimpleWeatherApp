//
//  ViewController.h
//  WeatherApp
//
//  Created by Julian Alonso on 9/3/15.
//  Copyright (c) 2015 Julian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherAPIHelper.h"

@class ForecastParser;

@interface ViewController : UIViewController

@property (nonatomic, strong) id<WeatherAPIHelper> weatherAPIHelper;
@property (nonatomic, strong) ForecastParser *forecastParser;

@end

