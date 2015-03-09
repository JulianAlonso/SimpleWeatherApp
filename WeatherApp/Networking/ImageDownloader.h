//
//  ImageDownloader.h
//  WeatherApp
//
//  Created by Julian Alonso on 9/3/15.
//  Copyright (c) 2015 Julian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageDownloader : NSObject

+ (void)imageWithURL:(NSString *)url completionBlock:(void(^)(UIImage *image))completionBlock;

@end
