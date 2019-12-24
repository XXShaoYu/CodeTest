//
//  ViewController.m
//  A 段项目 地图
//
//  Created by lanou3g on 15/9/14.
//  Copyright (c) 2015年 冯超. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "LOanimation.h"
@interface ViewController ()<MKMapViewDelegate>

/**
 *  地图
 */
@property (nonatomic,strong) MKMapView *mpView;


/**
 *  定位管理者
 */
@property (nonatomic,strong) CLLocationManager *mgr;


@property (nonatomic,assign) CLLocationCoordinate2D C2D;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //授权
    self.mgr =[[CLLocationManager alloc]init];
    [self.mgr requestWhenInUseAuthorization];
    
    // 1. 初始化
    self.mpView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    
    // 1.5 代理
    self.mpView.delegate =self;
    
    // 1.7 显示用户的位置
    self.mpView.showsUserLocation = YES;
    
    // 1.8 地图样式
    self.mpView.mapType = MKMapTypeStandard;
//    MKMapTypeStandard = 0,
//    MKMapTypeSatellite,
//    MKMapTypeHybrid
    
    // 1.9 追踪模式
    self.mpView.userTrackingMode = MKUserTrackingModeFollow;
//    MKUserTrackingModeNone = 0, // the user's location is not followed
//    MKUserTrackingModeFollow, // the map follows the user's location
//    MKUserTrackingModeFollowWithHeading, // the map follows the user's location and heading
    
    // 1.9.1 设置地图不能旋转
    self.mpView.rotateEnabled = YES;
    
    // 2. 添加到父视图上面
    [self.view addSubview:self.mpView];
    
}

#pragma mark----


// 开始加载地图
-(void)mapViewWillStartLoadingMap:(MKMapView *)mapView
{
    
    NSLog(@"开始加载");
    
}

// 失败加载
-(void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    
    NSLog(@"加载失败");
    
}

// 结束加载
-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    
    NSLog(@"加载结束");

}

// 获取用户的位置
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"获取用户位置");
    
    //大头针上的字
    userLocation.title = @"蓝欧";
    self.C2D = userLocation.coordinate;
    //子标题
    userLocation.subtitle = @"三十二";
    
}

// 结束获取用户的位置
-(void)mapViewDidStopLocatingUser:(MKMapView *)mapView
{
    
    NSLog(@"获取用户位置结束");
    
}


// 显示区域将要改变
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    NSLog(@"显示区域将要改变");
    
}

// 显示区域已经改变
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    NSLog(@"显示区域已经改变");
    
}


//---------------------------------------自定义---------------------------------------//


#pragma mark ----点击方法
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    LOanimation *an = [[LOanimation alloc]init];
    an.title = @"蓝欧";
    an.subtitle = @"32";
    an.coordinate =_C2D;
    //an.coordinate = CLLocationCoordinate2DMake(39.9, 116.4);
    an.icom = [UIImage imageNamed:@"DYIC5ZG_A@~~PERT`IM$~LI.jpg"];
    [self.mpView addAnnotation:an];
    
}

#pragma mark --- 大头针
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    if (![annotation isKindOfClass:[LOanimation class]]) return nil;
        
    static NSString * inden = @"inder";
    MKAnnotationView *anView = [mapView dequeueReusableAnnotationViewWithIdentifier:inden];
    if (anView == nil) {
        anView = [[MKAnnotationView alloc]init];
    }
    
    // 大头针图片
    anView.image = ((LOanimation *)annotation).icom;
    
    // 设置title
    anView.annotation = annotation;
    
    // 大头针可以点击
    anView.canShowCallout = YES;
    
    // 设置冒泡左边视图
    anView.leftCalloutAccessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"屏幕快照 2015-09-14 17.01.52"]];
    
    return anView;
}







@end
