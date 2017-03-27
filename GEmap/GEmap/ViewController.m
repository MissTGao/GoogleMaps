//
//  ViewController.m
//  GEmap
//
//  Created by manman'swork on 17/2/21.
//  Copyright © 2017年 manman'swork. All rights reserved.
//

#import "ViewController.h"
#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

//#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "CustomAnnotation.h"
#import "TFHpple.h"


@import GoogleMaps;


static NSString *const kNormalType = @"Normal";
static NSString *const kRetroType = @"Retro";
static NSString *const kGrayscaleType = @"Grayscale";
static NSString *const kNightType = @"Night";
static NSString *const kNoPOIsType = @"No business points of interest, no transit";


@interface ViewController ()<UIActionSheetDelegate,GMSMapViewDelegate,CLLocationManagerDelegate>
{
    UIBarButtonItem *_barButtonItem;
    GMSMapView *_mapView;
    GMSMarker* _marker;

    GMSMapStyle *_retroStyle;
    GMSMapStyle *_grayscaleStyle;
    GMSMapStyle *_nightStyle;
    GMSMapStyle *_noPOIsStyle;
    BOOL _firstLocationUpdate;
    
    NSMutableArray *waypoints_;
    NSMutableArray *waypointStrings_;
    
//    GMSPlacesClient *_placesClient;
    
    UILabel *lab1;
    UILabel *lab2;
    UILabel *lab3;
    UILabel *lab4;


}

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CustomAnnotation *startAnnotation;

/** 经纬度点的数组*/
@property (strong, nonatomic) NSArray *itemModelAry;
@property (strong, nonatomic) NSArray *itemModelAry2;

@property (strong, nonatomic) NSString *setLanguage;
@property (strong, nonatomic) NSString *origin;



@property (strong, nonatomic) NSDate *departDate;




@end

@implementation ViewController

- (void)initLocationManager
{
    if (self.locationManager) {
        
        [self.locationManager startUpdatingLocation];
        
    } else {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 5.0;
        self.locationManager.headingFilter = 5;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            //[self.locationManager requestWhenInUseAuthorization];//只在前台开启定位
            [self.locationManager requestAlwaysAuthorization];//在后台也可定位
        }
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
            self.locationManager.allowsBackgroundLocationUpdates = YES;
        }
    }
}

- (CLLocationCoordinate2D)getFirstCoordinate {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(28.6505769, 77.230283);
    return coordinate;
}
- (void)drowMapLine {
    
    self.itemModelAry =@[@"-33.968",@"-33.768",@"-33.568",@"-33.868",@"-33.968"];
    self.itemModelAry2 =@[@"151.2086",@"151.2086",@"151.2086",@"151.2086",@"151.2086"];
    
    CLLocationCoordinate2D pointsToUse[self.itemModelAry.count];
    for (int i = 0; i < self.itemModelAry.count; i++) {
        CLLocationCoordinate2D coords;
        coords.latitude = ([self.itemModelAry[i] floatValue]);
        coords.longitude = ([self.itemModelAry[i] floatValue]);
        pointsToUse[i] = coords;
    }
    
//    CLLocationCoordinate2D srcLocation = CLLocationCoordinate2DMake(-33.868, 151.4086);
//
//    CLLocationCoordinate2D desLoc = CLLocationCoordinate2DMake(-32.868, 150.4086);
//
//    
//    NSString *direApi = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=false",
//                         srcLocation.latitude,
//                         srcLocation.longitude,
//                         desLoc.latitude,
//                         desLoc.longitude];
//    
    
    
//    if ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
//        NSString *urlString = [NSString stringWithFormat:@"comgooglemaps://?saddr=%f,%f&daddr=%f,%f&directionsmode=driving",
//                               srcLocation.latitude,
//                               srcLocation.longitude,
//                               desLoc.latitude,
//                               desLoc.longitude];
//        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: urlString]];
//    }
    
    
    
//        https://maps.googleapis.com/maps/api/directions/json?origin=Boston,MA&destination=Concord,MA&waypoints=Charlestown,MA|Lexington,MA&key=AIzaSyC7NsImh4ibV6y6t5accPQNvcJKKQBNA3c

    
    
    [self drawPathFrom];
    
//    [self requestDirecionsAndshowOnMap];
    
}



-(int) requestDirecionsAndshowOnMap{
    
    NSArray* mode=[[NSArray alloc]initWithObjects:@"transit",@"bicycling",@"walking",@"driving", nil];
    NSString *depart=[[NSString alloc] initWithFormat:@""];
    NSString *origin=[[NSString alloc] initWithFormat:@""];
    NSString *destination=[[NSString alloc] initWithFormat:@""];
    
    if (self.setLanguage)
        self.setLanguage=[NSString stringWithFormat:@"language=%@",self.setLanguage];
    else
        self.setLanguage=@"language=en";
    
//    if (searchModeOption==0) {
        if (self.departDate==nil) {
            self.departDate=[NSDate date];
        }
        
        depart=[NSString stringWithFormat:@"&departure_time=%i",(int)[self.departDate timeIntervalSince1970]];
        
//    }
    
    CLLocationCoordinate2D srcLocation = CLLocationCoordinate2DMake(-33.868, 151.4086);
    CLLocationCoordinate2D desLoc = CLLocationCoordinate2DMake(-32.868, 150.4086);


    
//    if (self.origin) {
//        origin=[NSString stringWithFormat:@"origin=%@",self.origin];
//    }else if (self.originCoordinate.latitude && self.originCoordinate.longitude){
        origin=[NSString stringWithFormat:@"origin=%f,%f",srcLocation.latitude,srcLocation.longitude];
//    }else{
//        NSLog(@"No origin setted");
//        return -1;
//    }
    
//    if (self.destination) {
//        destination=[NSString stringWithFormat:@"destination=%@",self.destination];
//    }else if (self.destinationCoordinate.latitude && self.destinationCoordinate.longitude){
        destination=[NSString stringWithFormat:@"destination=%f,%f",desLoc.latitude,desLoc.longitude];
//    }else{
//        NSLog(@"No destination setted");
//        return -1;
//    }
    
    NSString* URLforRequest=[[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?%@&%@&sensor=false&%@&alternative=false&mode=%@%@",origin,destination,@"language=en",[mode objectAtIndex:0],depart] stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
    
    // NSLog(@"%@",URLforRequest);
    
    NSURLRequest *requests = [NSURLRequest requestWithURL:[NSURL URLWithString:URLforRequest]];
    
    [NSURLConnection sendAsynchronousRequest:requests queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        
        if (error==nil && data) {
            // NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
          NSDictionary * directions = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            if (error) {
                NSLog(@"%@",error);
            }
            NSString* status=[directions objectForKey:@"status"];
            NSLog(@"Status: %@", status);
            
//            if ([status isEqualToString:@"OK"]) {
////                [self decodeResult];
//                if (aMapView)
//                    [self showOnMap:aMapView];
//            }
        }else NSLog(@"%@",error);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Request Done" object:nil];
        
        
    }];
    
    
    return 0;
}

//-(void) decodeResult{
//    
//    self.destination=[[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"] objectAtIndex:0] objectForKey:@"end_address"];
//    
//    self.distance=[[[[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"] objectAtIndex:0] objectForKey:@"distance"] objectForKey:@"text"] doubleValue];
//    
//    self.duration=[[[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"] objectAtIndex:0] objectForKey:@"duration"] objectForKey:@"text"];
//    
//    //Get Array of Instructions
//    
//    self.instrunctions=[[NSMutableArray alloc] init];
//    
//    for (int n=0; n<[[[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"] objectAtIndex:0] objectForKey:@"steps"]count]; n++) {
//        [self.instrunctions addObject:[[[[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"] objectAtIndex:0] objectForKey:@"steps"] objectAtIndex:n] objectForKey:@"html_instructions"]];
//    }
//    
//    //Get Overview Polyline
//    
//    NSString *polystring=[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"overview_polyline"]  objectForKey:@"points"];
//    NSMutableArray* decodedpolystring=[self decodePolyLine:polystring];
//    
//    int numberOfCC=[decodedpolystring count];
//    GMSMutablePath *path = [GMSMutablePath path];
//    for (int index = 0; index < numberOfCC; index++) {
//        CLLocation *location = [decodedpolystring objectAtIndex:index];
//        CLLocationCoordinate2D coordinate = location.coordinate;
//        [path addLatitude:coordinate.latitude longitude:coordinate.longitude];
//    }
//    
//    self.overviewPolilyne= [GMSPolyline polylineWithPath:path];
//    
//    //Get Coordinates of origin and destination to be displayed on a map
//    float lat=[[[[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"]objectAtIndex:0] objectForKey:@"end_location"] objectForKey:@"lat"] floatValue];
//    float lng=[[[[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"]objectAtIndex:0] objectForKey:@"end_location"] objectForKey:@"lng"] floatValue];
//    CLLocationCoordinate2D tmp;
//    tmp.latitude=lat;
//    tmp.longitude=lng;
//    self.destinationCoordinate=tmp;
//    
//    lat=[[[[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"]objectAtIndex:0] objectForKey:@"start_location"] objectForKey:@"lat"] floatValue];
//    lng=[[[[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"]objectAtIndex:0] objectForKey:@"start_location"] objectForKey:@"lng"] floatValue];
//    tmp.latitude=lat;
//    tmp.longitude=lng;
//    self.originCoordinate=tmp;
//    
//}



-(NSMutableArray *)decodePolyLine:(NSString *)encodedStr {
    NSMutableString *encoded = [[NSMutableString alloc] initWithCapacity:[encodedStr length]];
    [encoded appendString:encodedStr];
    [encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
                                options:NSLiteralSearch
                                  range:NSMakeRange(0, [encoded length])];
    NSInteger len = [encoded length];
    NSInteger index = 0;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger lat=0;
    NSInteger lng=0;
    while (index < len) {
        NSInteger b;
        NSInteger shift = 0;
        NSInteger result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lat += dlat;
        shift = 0;
        result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lng += dlng;
        NSNumber *latitude = [[NSNumber alloc] initWithFloat:lat * 1e-5];
        NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-5];
        
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
        [array addObject:location];
    }
    
    return array;
}


-(void)drawPathFrom{
    
//    AE26762kdznyk221sncnuk421s1cn

    

    
    
//    NSString *urlString = [NSString stringWithFormat:
//                           @"%@?origin=%f,%f&destination=%f,%f&sensor=true&mode=%@",
//                           @"https://maps.google.com/maps/api/directions/json",
//                           40.010799407958984,
//                           116.34710693359375,
//                           40.010799407958984,
//                           116.44710693959375,
//                           @"WALKING"
//                           ];
    //    DRIVING,
    //    WALKING,   walking
    //    TRANSIT   mode=transit
    //    bicycling
    
    
    
    NSString *urlString =  @"https://maps.googleapis.com/maps/api/directions/json?origin=40.010799407958984,116.34710693359375&destination=40.010799407958984,116.44710653959375&key=AIzaSyC7NsImh4ibV6y6t5accPQNvcJKKQBNA3c&mode=transit&language=zh-CN&alternatives=true";
    
    
//    NSString *urlString = [NSString stringWithFormat:
//                           @"%@?origin=%f,%f&destination=%f,%f&sensor=true&mode=%@&key=%@",
//                           @"https://maps.googleapis.com/maps/api/directions/json",
//                           40.010799407958984,
//                           116.44710693959375,
//                           40.010799407958984,
//                           116.34710693359375,
//                           @"transit",
//                        @"AIzaSyC7NsImh4ibV6y6t5accPQNvcJKKQBNA3c"
//                           ];
    
    
    
    
    
    NSURL *urlStr = [NSURL URLWithString:urlString];
    
    
//      http://maps.google.com/maps/api/directions/json?origin=-33.868000,155.408600&destination=-33.868000,155.408600&sensor=true
    
//      http://maps.google.com/maps/api/directions/json?origin=39.988350,116.417152&destination=39.999350,116.417152&sensor=true
    
    
    

    

//    驾车
//   https://maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&key=YOUR_API_KEY
    
//    自行车
//https://maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&avoid=highways&mode=bicycling&key=YOUR_API_KEY
    
//    公交
//    https://maps.googleapis.com/maps/api/directions/json?origin=Brooklyn&destination=Queens&mode=transit&key=YOUR_API_KEY



//    NSString *baseUrl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&sensor=true", @"学知园", @"qinnianlu"];
//    
//  NSString* depart=[NSString stringWithFormat:@"&departure_time=%i",(int)[self.departDate timeIntervalSince1970]];
//  NSString*  origin=[NSString stringWithFormat:@"origin=%f,%f",srcLocation.latitude,srcLocation.longitude];
//  NSString * destination=[NSString stringWithFormat:@"destination=%f,%f",desLoc.latitude,desLoc.longitude];
//    
//    
//
//    
//    NSString* URLforRequest=[[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?%@&%@&sensor=false&%@&alternative=false&mode=%@%@",origin,destination,self.setLanguage,@"walking",depart] stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
////    
//    NSURL *url1 = [NSURL URLWithString:[baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSURLRequest *request2 = [NSURLRequest requestWithURL:url1];

    NSLog(@"Url: %@", urlStr);
    NSURLRequest *request = [NSURLRequest requestWithURL:urlStr];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //        [self clearMapView];
        
//        NSLog(@"%@: %@",modeStr, url);
        
        if(!connectionError){
            NSDictionary *result        = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *routes             = [result objectForKey:@"routes"];
            NSDictionary *firstRoute    = [routes objectAtIndex:0]; //几条线路
            
            NSLog(@"共有几条路%lu",(unsigned long)routes.count);
            
            
            if (routes.count) {
                
                NSArray *legs   = [firstRoute[@"legs"][0] objectForKey:@"steps"]; //最重要的 路线
                
//                NSArray *userArray =[GooglelegsModel mj_objectArrayWithKeyValuesArray:legs];
//                
//                [GooglelegsModel mj_setupObjectClassInArray:^NSDictionary *{
//                    return @{
//                             @"steps" : @"legsModel",
//                             };
//                }];
//                
//                for (GooglelegsModel *model in userArray) {
//                    
//                    NSLog(@"html_instructions___-%@",model.html_instructions);
//                    
//                    
//                }
//                
                
                
                for (int i =0; i<legs.count; i++) {
                    
                    NSString *encodedPath1       = legs[i][@"polyline"][@"points"];
                    
                    GMSPolyline *polyPath       = [GMSPolyline polylineWithPath:[GMSPath pathFromEncodedPath:encodedPath1]];
                    //            polyPath.strokeColor        =aNumber;
                    polyPath.strokeWidth        = 1;
                    polyPath.map                = _mapView;
                    
                    
                    NSDictionary *arrival_stop  = [legs[i][@"transit_details"] objectForKey:@"arrival_stop"];   //到站
                    NSDictionary *departure_stop  = [legs[i][@"transit_details"] objectForKey:@"departure_stop"];   //上车
                    NSDictionary *line   = [legs[i][@"transit_details"] objectForKey:@"line"];   //公交线路
                    NSString *short_name= line[@"short_name"];//公交车类型
                    NSString *travel_mode1= line[@"vehicle"][@"type"]; //公交车类型
                    NSString *html_instructions= [legs[i] objectForKey:@"html_instructions"]; //详细路线
                    NSString *arrival_name= arrival_stop[@"name"]; //公交名字
                    NSString *departure_name= departure_stop[@"name"]; //公交车名字
                    
                    
                    NSLog(@"%@",html_instructions);
                    
                    
                    double latitude2 = [arrival_stop[@"location"][@"lat"] doubleValue];
                    double longitude2 =[arrival_stop[@"location"][@"lng"] doubleValue];
                    
                    double latitude = [departure_stop[@"location"][@"lat"] doubleValue];
                    double longitude =[departure_stop[@"location"][@"lng"] doubleValue];
                    
                    
                    //大头针
                    GMSMarker *marker2 = [[GMSMarker alloc] init];
                    marker2.position = CLLocationCoordinate2DMake(latitude2, longitude2);
                    marker2.title = arrival_name;
                    marker2.snippet = short_name;
                    marker2.map = _mapView;
                    if ([travel_mode1 isEqualToString:@"BUS"]) {
                        
                        marker2.icon =[UIImage imageNamed:@"Transfer_image"];
                        
                    }else if ([travel_mode1 isEqualToString:@"SUBWAY"]){
                        
                        marker2.icon =[UIImage imageNamed:@"Transfer_image"];
                        
                    }else if ([travel_mode1 isEqualToString:@"DRIVING"]){
                        
                        marker2.icon =[UIImage imageNamed:@"Transfer_image"];
                        
                    }
                    
                    
                    //大头针
                    GMSMarker *marker = [[GMSMarker alloc] init];
                    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
                    marker.title = departure_name;
                    marker.snippet = short_name;
                    marker.map = _mapView;
                    if ([travel_mode1 isEqualToString:@"BUS"]) {
                        
                        marker.icon =[UIImage imageNamed:@"Transfer_image"];
                        
                    }else if ([travel_mode1 isEqualToString:@"SUBWAY"]){
                        
                        marker.icon =[UIImage imageNamed:@"Transfer_image"];
                        
                    }else if ([travel_mode1 isEqualToString:@"DRIVING"]){
                        
                        marker.icon =[UIImage imageNamed:@"Transfer_image"];
                        
                    }
                    
                    
                }
                
                
                
                
                //                NSDictionary *firstRoute    = [routes objectAtIndex:0];
                //                NSString *encodedPath       = [firstRoute[@"overview_polyline"] objectForKey:@"points"];
                //
                //                GMSPolyline *polyPath       = [GMSPolyline polylineWithPath:[GMSPath pathFromEncodedPath:encodedPath]];
                //                //            polyPath.strokeColor        =aNumber;
                //                polyPath.strokeWidth        = 1;
                //                polyPath.map                = _mapView;
                
            }
            
        }
    }];
}


- (void)createCenterViw{
    /**
     中间定位图标
     */
    UIImageView *centerImageView=[[UIImageView alloc]initWithFrame:CGRectMake((_mapView.bounds.size.width)/2-7, (_mapView.bounds.size.height)/2-40, 15, 40)];
    centerImageView.image=[UIImage imageNamed:@"bubble_left"];
    [self.view addSubview:centerImageView];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个普通的Label
    UILabel *testLabel = [[UILabel alloc] init];
    //中央对齐
    testLabel.textAlignment = NSTextAlignmentCenter;
    testLabel.backgroundColor = [UIColor purpleColor];
    testLabel.numberOfLines = 0;
    testLabel.frame = CGRectMake(0, 200, self.view.frame.size.width, 300);
    [self.view addSubview:testLabel];
    
    //设置Attachment
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    //使用一张图片作为Attachment数据
    attachment.image = [UIImage imageNamed:@"logo1024"];
    //这里bounds的x值并不会产生影响
    attachment.bounds = CGRectMake(-600, 0, 20, 10);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"这是一串字"];
    [attributedString appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    testLabel.attributedText = attributedString;
    
    
    
    
    
    
    
//    waypoints_ = [[NSMutableArray alloc]init];
//    waypointStrings_ = [[NSMutableArray alloc]init];
//    [self drowMapLine];
//    lab1=[[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 20)];
//    lab2=[[UILabel alloc] initWithFrame:CGRectMake(20, 50, 200, 20)];
//    lab3=[[UILabel alloc] initWithFrame:CGRectMake(20, 80, 200, 20)];
//    lab4=[[UILabel alloc] initWithFrame:CGRectMake(20, 110, 200, 20)];
//    lab1.backgroundColor =[UIColor redColor];
//    [self initLocationManager];
//    
//    [self.locationManager startUpdatingLocation];
//    
////    _placesClient = [[GMSPlacesClient alloc] init];
//    
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.0107473
//                                                            longitude:116.3471082
//                                                                 zoom:14];
//    
//    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
//    _mapView.delegate =self;
//    _mapView.settings.compassButton = YES;
//    _mapView.settings.myLocationButton = YES;
//    
//    // Listen to the myLocation property of GMSMapView.
//
//    self.view = _mapView;
//    [self createCenterViw];
//    
//    
//
//    
//    
//
//    
////    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
////                                                            longitude:151.20
////                                                                 zoom:6];
////    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
//    _mapView.myLocationEnabled = YES;
//    
//    // Creates a marker in the center of the map.
////    //大头针
////    GMSMarker *marker = [[GMSMarker alloc] init];
////    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
////    marker.title = @"Sydney";
////    marker.snippet = @"Australia";
////    marker.map = _mapView;
////
//    
//    
//    self.startAnnotation = [[CustomAnnotation alloc] initWithCoordinate:[self getFirstCoordinate] andMarkTitle:@"开始" andMarkSubTitle:@""];
//    
//    
////    // 划线
//    GMSMutablePath *path = [GMSMutablePath path];
//    [path addCoordinate:CLLocationCoordinate2DMake(@(-33.860).doubleValue,@(151.208).doubleValue)];
//    [path addCoordinate:CLLocationCoordinate2DMake(@(-33.860).doubleValue,@(151.008).doubleValue)];
//    [path addCoordinate:CLLocationCoordinate2DMake(@(-33.860).doubleValue,@(150.508).doubleValue)];
//    [path addCoordinate:CLLocationCoordinate2DMake(@(-32.860).doubleValue,@(150.208).doubleValue)];
//    
//    GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
//    rectangle.strokeWidth = 2.f;
//    rectangle.map = _mapView;
//    
//    self.view = _mapView;
//    
//    
////    ，前两个是经纬度，后一个是地图的显示比例。这样地图就显示成功了！！！
////    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:0
////                                                            longitude:0
////                                                                 zoom:6];
////    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
////    _mapView.delegate = self;
////    self.view = _mapView;
////    [_mapView addSubview:lab1];
////    [_mapView addSubview:lab2];
////
////    [_mapView addSubview:lab3];
////
////    [_mapView addSubview:lab4];
////
////    
////    [_mapView addObserver:self
////               forKeyPath:@"myLocation"
////                  options:NSKeyValueObservingOptionNew
////                  context:NULL];
////
////    
////    // Ask for My Location data after the map has already been added to the UI.
////    dispatch_async(dispatch_get_main_queue(), ^{
////        _mapView.myLocationEnabled = YES;
////    });
//}
//
//- (void)locationManager:(CLLocationManager *)manager
//     didUpdateLocations:(NSArray *)locations
//{
//        CLLocation *location = [locations lastObject];
//        //    通过location  或得到当前位置的经纬度
//        CLLocationCoordinate2D curCoordinate2D=location.coordinate;
//    
//    
//    NSLog(@"latitude---%f",location.coordinate.latitude); //经纬度
//    NSLog(@"longitude---%f",location.coordinate.longitude);
//    NSLog(@"海拔－---%f",location.altitude);
//    NSLog(@"位置的垂直精度。如果海拔高度无效---%f",location.verticalAccuracy);
//    NSLog(@"速度---%f",location.speed);
//    NSLog(@"description---%@",location.description);
//
//    
//    lab1.text =[NSString stringWithFormat:@"经纬度－－%f",location.coordinate.latitude];
//    lab2.text =[NSString stringWithFormat:@"经纬度－－%f",location.coordinate.longitude];
//    lab3.text =[NSString stringWithFormat:@"海拔－－%f",location.altitude];
//    lab4.text =[NSString stringWithFormat:@"速度－－%f",location.verticalAccuracy];
//    
//    NSLog(@"%f----%f",curCoordinate2D.latitude,curCoordinate2D.longitude);
//    
//    
////        BOOL ischina = [[ZCChinaLocation shared] isInsideChina:(CLLocationCoordinate2D){curCoordinate2D.latitude,curCoordinate2D.longitude}];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied)
    {
        //访问被拒绝
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
    }
}



- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
    int popupWidth = 300;
    int contentWidth = 280;
    int contentHeight = 140;
    int contentPad = 10;
    int popupHeight = 200;
    int popupBottomPadding = 16;
    int popupContentHeight = contentHeight - popupBottomPadding;
    int buttonHeight = 30;
    int anchorSize = 20;
    CLLocationCoordinate2D anchor = marker.position;
    CGPoint point = [mapView.projection pointForCoordinate:anchor];
    
    
    UIView *outerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, popupWidth, popupHeight)];
    float offSet = anchorSize * M_SQRT2;
    CGAffineTransform rotateBy45Degrees = CGAffineTransformMakeRotation(M_PI_4); //rotate by 45 degrees
    UIView *callOut = [[UIView alloc] initWithFrame:CGRectMake((popupWidth - offSet)/2.0, popupHeight - offSet, anchorSize, anchorSize)];
    callOut.transform = rotateBy45Degrees;
    callOut.backgroundColor = [UIColor blackColor];
    [outerView addSubview:callOut];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, popupWidth, 190)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    
    view.layer.borderColor = [UIColor blackColor].CGColor;
    view.layer.borderWidth = 2.0f;
    
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentPad, 0, contentWidth, 22)];
    [titleLabel setFont:[UIFont systemFontOfSize:17.0]];
    titleLabel.text = [marker title];
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentPad, 24, contentWidth, 80)];
    [descriptionLabel setFont:[UIFont systemFontOfSize:12.0]];
    descriptionLabel.numberOfLines = 5;
    descriptionLabel.text = [marker snippet];
    
    [view addSubview:titleLabel];
    [view addSubview:descriptionLabel];
    
    
    [outerView addSubview:view];
    
    return outerView;
    
}
    
    
    


- (void)dealloc {
    [_mapView removeObserver:self
                  forKeyPath:@"myLocation"
                     context:NULL];
}

//地图代理
- (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture{
    NSLog(@"gesture === %@",[NSNumber numberWithBool:gesture]);
}

//这个代理方法主要作用就是当你移动镜头也就是拖动地推的时候，就会调用这个方法
- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position{
    NSLog(@"didChangeCameraPosition ==== %@",position);
}
//这个代理方法你就可以拿到屏幕中心点的位置的经纬度了，这是一个很简单的方法。当然，这个方法是有缺陷的，就是我们只能拿到经纬度，却拿不到经纬度所对应的地址之类的一些信息。
- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position{
    
    NSLog(@"idleAtCameraPosition ==== %@",position);
    NSLog(@"target ==== %f,%f",position.target.latitude,position.target.longitude);
    
    //这个方法是清理掉地图上所有的东西，包括什么大头针之类的，这里的目的是为了使地图上只有一个大头针
//    [_mapView clear];
//    _marker = [[GMSMarker alloc] init];
//    _marker.position = CLLocationCoordinate2DMake(position.target.latitude, position.target.longitude);
//    _marker.icon = [UIImage imageNamed:@"bigLoc"];
//    _marker.map = _mapView;
}

//这个三个代理方法要怎么解释我就真不知道了，大家伙可以试试
//开始
- (void)mapViewDidStartTileRendering:(GMSMapView *)mapView{
//    NSLog(@"mapViewDidStartTileRendering ==== %@",mapView);
}
//滑动
- (void)mapViewDidFinishTileRendering:(GMSMapView *)mapView{
//    NSLog(@"mapViewDidFinishTileRendering ==== %@",mapView);
}
//暂停
- (void)mapViewSnapshotReady:(GMSMapView *)mapView{
//    NSLog(@"mapViewSnapshotReady ==== %@",mapView);
}


#pragma mark - KVO updates

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!_firstLocationUpdate) {
        // If the first location update has not yet been recieved, then jump to that
        _firstLocationUpdate = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        _mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:14];
        NSLog(@"latitude---%f",location.coordinate.latitude); //经纬度
        NSLog(@"longitude---%f",location.coordinate.longitude);
        NSLog(@"海拔－－---%f",location.altitude);
        NSLog(@"位置的垂直精度。如果海拔高度无效---%f",location.verticalAccuracy);
        NSLog(@"速度---%f",location.speed);
        NSLog(@"description---%@",location.description);

        
        
        lab1.text =[NSString stringWithFormat:@"经纬度－－ %f",location.coordinate.latitude];
        lab2.text =[NSString stringWithFormat:@"经纬度－－ %f",location.coordinate.longitude];
        lab3.text =[NSString stringWithFormat:@"海拔－－ %f",location.altitude];
        lab4.text =[NSString stringWithFormat:@"速度－－ %f",location.speed];

        
        [[GMSGeocoder geocoder] reverseGeocodeCoordinate:CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude) completionHandler:^(GMSReverseGeocodeResponse* response, NSError* error) {
            for(GMSAddress* addressObj in [response results])
            {
                
                _marker.title=[NSString stringWithFormat:@"%@,%@",addressObj.thoroughfare,addressObj.subLocality];
                _marker.snippet=[NSString stringWithFormat:@"%@,%@,%@",addressObj.locality,addressObj.administrativeArea,addressObj.country];
            }
        }];
        

//        CLLocation *location = [change objectForKey:NSKeyValueChangeKindKey];

    }
}


//点击放大头针   //这个代理方法的主要作用就是，当你点击地图上的某一点时，你可以得到它的经纬度，但是呢，具体的地址还是得不到的
//点击
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:
(CLLocationCoordinate2D)coordinate {
    
//    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(
//                                                                 coordinate.latitude,
//                                                                 coordinate.longitude);
//    GMSMarker *marker = [GMSMarker markerWithPosition:position];
//    marker.map = _mapView;
//    [waypoints_ addObject:marker];
//    NSString *positionString = [[NSString alloc] initWithFormat:@"%f,%f",
//                                coordinate.latitude,coordinate.longitude];
//    [waypointStrings_ addObject:positionString];
//    if([waypoints_ count]>1){
//        NSString *sensor = @"false";
//        NSArray *parameters = [NSArray arrayWithObjects:sensor, waypointStrings_,
//                               nil];
//        NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
//        NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
//                                                          forKeys:keys];
////        MDDirectionService *mds=[[MDDirectionService alloc] init];
////        SEL selector = @selector(addDirections:);
////        [mds setDirectionsQuery:query
////                   withSelector:selector
////                   withDelegate:self];
//    }
}
//- (void)addDirections:(NSDictionary *)json {
//    
//    NSDictionary *routes = [json objectForKey:@"routes"][0];
//    
//    NSDictionary *route = [routes objectForKey:@"overview_polyline"];
//    NSString *overview_route = [route objectForKey:@"points"];
//    GMSPath *path = [GMSPath pathFromEncodedPath:overview_route];
//    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
//    polyline.map = _mapView;
//}
//


@end
