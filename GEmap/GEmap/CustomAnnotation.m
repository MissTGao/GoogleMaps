//
//  CustomAnnotation.m
//  Leqi
//
//  Created by 张汇丰 on 16/6/1.
//  Copyright © 2016年 张汇丰. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation

-(id)initWithCoordinate:(CLLocationCoordinate2D)theCoordinate
           andMarkTitle:(NSString *)theMarkTitle
        andMarkSubTitle:(NSString *)theMarkSubTitle
{
    if (self = [super init]) {
        _coordinate     = theCoordinate;
        _markTitle      = theMarkTitle;
        _markSubTitle   = theMarkSubTitle;
    }
    return self;
}

- (NSString *)title
{
    return self.markTitle;
}

- (NSString *)subtitle
{
    return self.markSubTitle;
}

@end
