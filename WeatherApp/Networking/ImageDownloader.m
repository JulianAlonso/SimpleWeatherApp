//
//  ImageDownloader.m
//  WeatherApp
//
//  Created by Julian Alonso on 9/3/15.
//  Copyright (c) 2015 Julian. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

+ (void)imageWithURL:(NSString *)url completionBlock:(void(^)(UIImage *image))completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{

        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completionBlock([UIImage imageWithData:imageData]);
            
        });
    });
}

@end
