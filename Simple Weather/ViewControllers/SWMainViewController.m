//
//  ViewController.m
//  Simple Weather
//
//  Created by Kostya on 20.12.15.
//  Copyright © 2015 Stolyarenko K.S. All rights reserved.
//

#import "SWMainViewController.h"
#import <MapKit/MapKit.h>
#import "SWMapViewController.h"
#import "AFNetworking.h"
#import "SWConstants.h"

@interface SWMainViewController ()<UITextFieldDelegate,MyMapProtocol>
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidity;
@property (weak, nonatomic) IBOutlet UILabel *weatherstatus;
@property (weak, nonatomic) IBOutlet UILabel *pressure;
@property (weak, nonatomic) IBOutlet UILabel *tempmin;
@property (weak, nonatomic) IBOutlet UILabel *tempmax;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *wind;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@end

@implementation SWMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender
{
    [segue.destinationViewController setDelegate:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    NSString *userCityName = textField.text;
    self.name.text = textField.text;
    userCityName = [userCityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    textField.text = userCityName;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *urlString = [BasicUrl stringByAppendingString:WeatherCityNameUrl];
    urlString = [NSString stringWithFormat:urlString, textField.text];
    NSURL *url = [NSURL URLWithString:urlString];

    [manager GET:url.absoluteString parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject)
         {
             NSDictionary *json = responseObject;
             [self configurationScreenWithDictionary:json];
         }
         failure:^(NSURLSessionTask *operation, NSError *error)
         {
             NSLog(@"Error: %@", error);
         }];
        textField.text = nil;
    return YES;
}

#pragma mark - MapKit Delegate

-(void)didSelectLocation:(CLLocationCoordinate2D)location
{
    NSString* latt = [NSString stringWithFormat:@"%f", location.latitude];
    NSString* longg = [NSString stringWithFormat:@"%f", location.longitude];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString *urlString = [BasicUrl stringByAppendingString:UserCityNameUrl];
    urlString = [NSString stringWithFormat:urlString, latt,longg];
    NSURL *url = [NSURL URLWithString:urlString];
    [manager GET:url.absoluteString parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject)
         {
             NSDictionary *json = responseObject;
             [self configurationScreenWithDictionary:json];
             [self.navigationController popViewControllerAnimated:YES];

         }
         failure:^(NSURLSessionTask *operation, NSError *error)
         {
             NSLog(@"Error: %@", error);
         }];
}

#pragma mark - Update UI

- (void)configurationScreenWithDictionary:(NSDictionary *)weatherDictionary
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *nameCity = weatherDictionary[@"name"];
        self.cityNameLabel.text = nameCity;
        self.name.text = nameCity;
        
        NSDictionary *mainDictionary = weatherDictionary[@"main"];
        
        NSString *temperatureString = mainDictionary[@"temp"];
        NSInteger temp = [temperatureString integerValue];
        self.temperatureLabel.text = [@(temp - 273) description];
        
        
        NSString *temperatureMINString = mainDictionary[@"temp_min"];
        NSInteger tempMIN = [temperatureMINString integerValue];
        self.tempmin.text = [@(tempMIN - 273) description];
        
        
        NSString *temperatureMAXString = mainDictionary[@"temp_max"];
        NSInteger tempmax = [temperatureMAXString integerValue];
        self.tempmax.text = [@(tempmax - 273) description];
        
        NSString *pressureString = mainDictionary[@"pressure"];
        NSInteger pressure = [pressureString integerValue];
        self.pressure.text = [@(pressure) description];
        
        
        NSString *humidityString = mainDictionary[@"humidity"];
        NSInteger humidity = [humidityString integerValue];
        self.humidity.text = [@(humidity) description];
        
        NSDictionary *windDictionary = weatherDictionary[@"wind"];
        NSString *windString = windDictionary[@"speed"];
        NSInteger wind = [windString integerValue];
        NSLog(@"%li",(long)wind);
        self.wind.text = [@(wind) description];
        
        NSArray *statusesWeather = weatherDictionary[@"weather"];
        NSDictionary *status = statusesWeather[0];
        NSString *weatherstatusString = status[@"main"];
        self.weatherstatus.text = weatherstatusString;
        
        [self setImageWithStatus:weatherstatusString];
    });
}

-(void)setImageWithStatus:(NSString *)weatherstatusString
{
    if ([weatherstatusString isEqualToString:@"Clouds"])
    {
        [self.weatherImageView setImage:[UIImage imageNamed:ImageClouds]];
    }
    else if ([weatherstatusString isEqualToString:@"Sun"]||[weatherstatusString isEqualToString:@"Clear"])
    {
        [self.weatherImageView setImage:[UIImage imageNamed:ImageSun]];
    }
    else if ([weatherstatusString isEqualToString:@"Rain"])
    {
        [self.weatherImageView setImage:[UIImage imageNamed:ImageRain]];
    }
    else if ([weatherstatusString isEqualToString:@"Snow"])
    {
        [self.weatherImageView setImage:[UIImage imageNamed:ImageSnow]];
    }
    else if ([weatherstatusString isEqualToString:@"Fog"])
    {
        [self.weatherImageView setImage:[UIImage imageNamed:ImageFog]];
    }
    else if ([weatherstatusString isEqualToString:@"Drizzle"])
    {
        [self.weatherImageView setImage:[UIImage imageNamed:ImageDrizzle]];
    }
}

@end
