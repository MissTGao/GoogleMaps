/*
 * Copyright 2016 Google Inc. All rights reserved.
 *
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
 * file except in compliance with the License. You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under
 * the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
 * ANY KIND, either express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "Samples.h"

// Map Demos
#import "BasicMapViewController.h"
#import "CustomIndoorViewController.h"
#import "DoubleMapViewController.h"
#import "FrameRateViewController.h"
#import "GestureControlViewController.h"
#import "IndoorMuseumNavigationViewController.h"
#import "IndoorViewController.h"
#import "MapTypesViewController.h"
#import "MapZoomViewController.h"
#import "MyLocationViewController.h"
#import "SnapshotReadyViewController.h"
#import "StyledMapViewController.h"
#import "TrafficMapViewController.h"
#import "VisibleRegionViewController.h"

// Panorama Demos
#import "FixedPanoramaViewController.h"
#import "PanoramaViewController.h"

// Overlay Demos
#import "AnimatedCurrentLocationViewController.h"
#import "AnimatedUIViewMarkerViewController.h"
#import "CustomMarkersViewController.h"
#import "GradientPolylinesViewController.h"
#import "GroundOverlayViewController.h"
#import "MarkerEventsViewController.h"
#import "MarkerInfoWindowViewController.h"
#import "MarkerLayerViewController.h"
#import "MarkersViewController.h"
#import "PolygonsViewController.h"
#import "PolylinesViewController.h"
#import "TileLayerViewController.h"

// Camera Demos
#import "CameraViewController.h"
#import "FitBoundsViewController.h"
#import "MapLayerViewController.h"

// Services
#import "GeocoderViewController.h"
#import "StructuredGeocoderViewController.h"

@implementation Samples

+ (NSArray *)loadSections {
  return @[ @"Map", @"Panorama", @"Overlays", @"Camera", @"Services" ];
}

+ (NSArray *)loadDemos {
  NSArray *mapDemos =
  @[[self newDemo:[BasicMapViewController class]
        withTitle:@"Basic Map"
   andDescription:nil],
    [self newDemo:[MapTypesViewController class]
        withTitle:@"Map Types"
   andDescription:nil],
    [self newDemo:[StyledMapViewController class]
        withTitle:@"Styled Map"
   andDescription:nil],
    [self newDemo:[TrafficMapViewController class]
        withTitle:@"Traffic Layer"
   andDescription:nil],
    [self newDemo:[MyLocationViewController class]
        withTitle:@"My Location"
   andDescription:nil],
    [self newDemo:[IndoorViewController class]
        withTitle:@"Indoor"
   andDescription:nil],
    [self newDemo:[CustomIndoorViewController class]
        withTitle:@"Indoor with Custom Level Select"
   andDescription:nil],
    [self newDemo:[IndoorMuseumNavigationViewController class]
        withTitle:@"Indoor Museum Navigator"
   andDescription:nil],
    [self newDemo:[GestureControlViewController class]
        withTitle:@"Gesture Control"
   andDescription:nil],
    [self newDemo:[SnapshotReadyViewController class]
        withTitle:@"Snapshot Ready"
   andDescription:nil],
    [self newDemo:[DoubleMapViewController class]
        withTitle:@"Two Maps"
   andDescription:nil],
    [self newDemo:[VisibleRegionViewController class]
        withTitle:@"Visible Regions"
   andDescription:nil],
    [self newDemo:[MapZoomViewController class]
        withTitle:@"Min/Max Zoom"
   andDescription:nil],
    [self newDemo:[FrameRateViewController class]
        withTitle:@"Frame Rate"
   andDescription:nil],
  ];

  NSArray *panoramaDemos =
  @[[self newDemo:[PanoramaViewController class]
        withTitle:@"Street View"
   andDescription:nil],
    [self newDemo:[FixedPanoramaViewController class]
        withTitle:@"Fixed Street View"
   andDescription:nil]];

  NSArray *overlayDemos =
  @[[self newDemo:[MarkersViewController class]
        withTitle:@"Markers"
   andDescription:nil],
    [self newDemo:[CustomMarkersViewController class]
        withTitle:@"Custom Markers"
   andDescription:nil],
    [self newDemo:[AnimatedUIViewMarkerViewController class]
        withTitle:@"UIView Markers"
   andDescription:nil],
    [self newDemo:[MarkerEventsViewController class]
        withTitle:@"Marker Events"
   andDescription:nil],
    [self newDemo:[MarkerLayerViewController class]
        withTitle:@"Marker Layer"
   andDescription:nil],
    [self newDemo:[MarkerInfoWindowViewController class]
        withTitle:@"Custom Info Windows"
   andDescription:nil],
    [self newDemo:[PolygonsViewController class]
        withTitle:@"Polygons"
   andDescription:nil],
    [self newDemo:[PolylinesViewController class]
        withTitle:@"Polylines"
   andDescription:nil],
    [self newDemo:[GroundOverlayViewController class]
        withTitle:@"Ground Overlays"
   andDescription:nil],
    [self newDemo:[TileLayerViewController class]
        withTitle:@"Tile Layers"
   andDescription:nil],
    [self newDemo:[AnimatedCurrentLocationViewController class]
        withTitle:@"Animated Current Location"
   andDescription:nil],
    [self newDemo:[GradientPolylinesViewController class]
        withTitle:@"Gradient Polylines"
   andDescription:nil]];

  NSArray *cameraDemos =
  @[[self newDemo:[FitBoundsViewController class]
        withTitle:@"Fit Bounds"
   andDescription:nil],
    [self newDemo:[CameraViewController class]
        withTitle:@"Camera Animation"
   andDescription:nil],
    [self newDemo:[MapLayerViewController class]
        withTitle:@"Map Layer"
   andDescription:nil]];

  NSArray *servicesDemos =
  @[[self newDemo:[GeocoderViewController class]
        withTitle:@"Geocoder"
   andDescription:nil],
    [self newDemo:[StructuredGeocoderViewController class]
        withTitle:@"Structured Geocoder"
   andDescription:nil],
  ];

  return @[mapDemos, panoramaDemos, overlayDemos, cameraDemos, servicesDemos];
}

+ (NSDictionary *)newDemo:(Class) class
                withTitle:(NSString *)title
           andDescription:(NSString *)description {
  return [[NSDictionary alloc] initWithObjectsAndKeys:class, @"controller",
          title, @"title", description, @"description", nil];
}
@end
