//
//  SWMapViewController.h
//  Simple Weather
//
//  Created by Stolyarenko on 02.02.16.
//  Copyright © 2016 Stolyarenko K.S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AFNetworking.h"
#import "SWMainViewController.h"

@protocol MyMapProtocol
-(void)didSelectLocation:(CLLocationCoordinate2D)location;
@end

@interface SWMapViewController : UIViewController
@property (nonatomic, weak) id <MyMapProtocol> delegate;
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@end
