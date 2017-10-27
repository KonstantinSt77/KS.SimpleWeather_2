//
//  SWConstants.m
//  Simple Weather
//
//  Created by Kostya on 27.10.2017.
//  Copyright © 2017 Stolyarenko K.S. All rights reserved.
//

#import "SWConstants.h"

@implementation SWConstants

//server
NSString *const BasicUrl = @"http://api.openweathermap.org";
NSString *const WeatherCityNameUrl = @"/data/2.5/weather?q=%@,uk&appid=37e0cb1eed95e56934c68507ca80d49f&mine=true";
NSString *const UserCityNameUrl = @"/data/2.5/weather?lat=%@&lon=%@&appid=37e0cb1eed95e56934c68507ca80d49f";

//image name
NSString *const ImageClouds = @"Clouds";
NSString *const ImageSun = @"Sun";
NSString *const ImageRain = @"Rain";
NSString *const ImageSnow = @"Snow";
NSString *const ImageFog = @"Fog";
NSString *const ImageDrizzle = @"Drizzle";
NSString *const ImagePin = @"pin2";

//number constants
int const AnnViewSize = 50;

@end
