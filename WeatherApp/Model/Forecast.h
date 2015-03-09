//
//  Forecast.h
//  WeatherApp
//
//  Created by Julian Alonso on 9/3/15.
//  Copyright (c) 2015 Julian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Forecast : NSObject

@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, assign) float temp;
@property (nonatomic, assign) float minTemp;
@property (nonatomic, assign) float maxTemp;
@property (nonatomic, assign) float pressure;
@property (nonatomic, assign) float humidity;
@property (nonatomic, strong) NSString *weatherDescription;
@property (nonatomic, strong) NSString *iconURL;

@end
