//
//  SWMapViewController.m
//  Simple Weather
//
//  Created by Stolyarenko on 02.02.16.
//  Copyright © 2016 Stolyarenko K.S. All rights reserved.
//

#import "SWMapViewController.h"
#import "AFNetworking.h"
#import "SWMainViewController.h"
#import "SWConstants.h"

@interface SWMapViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>
@end

@implementation SWMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *annView=(MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotation"];
    if (annView==nil)
    {
        annView=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation"];
    }
    annView.canShowCallout = YES;
    UIImage *image = [UIImage imageNamed:ImagePin];
    annView.image = image;
    [annView setFrame:CGRectMake(0, 0, AnnViewSize, AnnViewSize)];
    annView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annView.centerOffset = CGPointMake(0,-AnnViewSize/2);
    return annView;
}

- (IBAction)tapMap:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint point = [sender locationInView:self.mapView];
        CLLocationCoordinate2D mapCoordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = mapCoordinate;
        annotation.title = @"New point";
        annotation.subtitle = @"information";
        [self.mapView addAnnotation:annotation];
        [self.delegate didSelectLocation:mapCoordinate];
    }
}
@end
