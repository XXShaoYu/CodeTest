//
//  ViewController.m
//  A段项目   地图 定位
//
//  Created by lanou3g on 15/9/14.
//  Copyright (c) 2015年 冯超. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>



@interface ViewController ()<CLLocationManagerDelegate>


/**
 *  定位管理者
 */
@property (nonatomic,strong) CLLocationManager *mgr;

/**
 *  编码于反编码
 */
@property (nonatomic,strong) CLGeocoder *geo;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//--------------------------------------------定位管理者-----------------------------------------------//
    //0.判断是否具备定位服务
    if (![CLLocationManager locationServicesEnabled]) return;
    
    //1.初始化
    self.mgr = [[CLLocationManager alloc]init];
    
    
    // 1.5 判断版本
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >7.0 ) {
        
        //2.授权
        //2.1 返回一种状态
        if ([CLLocationManager authorizationStatus]!= kCLAuthorizationStatusAuthorizedWhenInUse) {
            
            //2.2 请求一种授权方式
            [self.mgr requestAlwaysAuthorization];
        }
        
    }
    
    //2.3 定位频率
    self.mgr.distanceFilter = kCLLocationAccuracyThreeKilometers;
    
    //distanceFilter 最小更新距离
    //desiredAccuracy 定位精度
    
    //2.4 定位精度
    self.mgr.desiredAccuracy = kCLLocationAccuracyBest;
    
    //2.5 设置代理
    self.mgr.delegate =self;
    
    //3.开始定位
    //[self.mgr startUpdatingLocation];
    
    
    
    
    // 调用 - (void)geoWithAdree:(NSString *)adress
    //[self geoWithAdree:@"北京"];
    
    // 输入坐标 (经度.纬度)
    CLLocationCoordinate2D coo2D =CLLocationCoordinate2DMake(39.904989, 116.45285);
    // 调用 - (void)regeo:(CLLocationCoordinate2D)coor
    [self regeo:coo2D];
    
   
}


#pragma mark 编码
//--------------------------------------------编码-----------------------------------------------//

- (void)geoWithAdree:(NSString *)adress
{
    // 初始化
    self.geo = [[CLGeocoder alloc]init];
    
    // 编码方法
    [self.geo geocodeAddressString:adress completionHandler:^(NSArray *placemarks, NSError *error) {
        // 有错误返回
        if (error) {
            NSLog(@" line =%d error = %@",__LINE__,error);
            
            return ;
            
        }
        // 没有错误打印具体位置信息
        CLPlacemark *placemark =placemarks.lastObject;
    
        
        // 获取经纬度的所有key 跟value 的信息
        // 编码是输入一个城市.获取这个城市所在的那个国家 那个城市
        [placemark.addressDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            
            NSLog(@"key = %@ value = %@",key,obj);
            
        }];
        
//       精度 latitude;
//       维度 longitude;
        NSLog(@"经度 = %f 纬度 = %f",placemark.location.coordinate.latitude,placemark.location.coordinate.longitude);
        
    }];
    
}

#pragma mark 反编码
//--------------------------------------------反编码-----------------------------------------------//

- (void)regeo:(CLLocationCoordinate2D)coor
{
    // 初始化编码管理者
    self.geo = [[CLGeocoder alloc]init];
    
    // 创建位置
    CLLocation *loca =[[CLLocation alloc]initWithLatitude:coor.latitude longitude:coor.longitude];
    
    // 执行反编码
    [self.geo reverseGeocodeLocation:loca completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            NSLog(@"line = %D error =%@",__LINE__,error);
        }
        CLPlacemark *pl =placemarks.firstObject;
        
        // 获取经纬度的所有key 跟value 的信息
        // 反编码是给一个地理坐标(经度.维度)返回这个地理坐标所在的那个国家或者城市
        [pl.addressDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSLog(@"key =%@ vlue = %@",key,obj);
        }];
        
        //       精度 latitude;
        //       维度 longitude;
        NSLog(@" 经度 = %f  纬度 =  %f",pl.location.coordinate.latitude,pl.location.coordinate.longitude);
    }];
    
}

#pragma mark   ---------- 代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // 取出最后一个元素
    CLLocation *loc = locations.lastObject;
    
    // 打印经纬度
    NSLog(@"%f  %f",loc.coordinate.latitude,loc.coordinate.longitude);
    
    // 停止定位
    //[self.mgr stopUpdatingLocation];
    

    
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    
    
    
}









@end
