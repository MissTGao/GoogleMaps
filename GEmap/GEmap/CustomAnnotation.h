//
//  CustomAnnotation.h
//  Leqi
//
//  Created by 张汇丰 on 16/6/1.
//  Copyright © 2016年 张汇丰. All rights reserved.
//  自定义的大头针

#import <Foundation/Foundation.h>
//#import <MAMapKit/MAMapKit.h>
#import <GoogleMaps/GoogleMaps.h>


@interface CustomAnnotation : NSObject
//<MAAnnotation>
//
@property (nonatomic, readonly) CLLocationCoordinate2D  coordinate;
@property (nonatomic, retain)   NSString                *markTitle;
@property (nonatomic, retain)   NSString                *markSubTitle;
@property (nonatomic, retain)   UIImage                 *image;

-(id)initWithCoordinate:(CLLocationCoordinate2D)theCoordinate
           andMarkTitle:(NSString *)theMarkTitle
        andMarkSubTitle:(NSString *)theMarkSubTitle;


@end
