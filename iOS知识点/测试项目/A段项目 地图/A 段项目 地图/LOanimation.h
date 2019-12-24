//
//  LOanimation.h
//  A 段项目 地图
//
//  Created by lanou3g on 15/9/14.
//  Copyright (c) 2015年 冯超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface LOanimation : NSObject<MKAnnotation>

/**
 *  title
 */
@property (nonatomic,copy) NSString * title;

/**
 *  subtitle
 */
@property (nonatomic,copy) NSString * subtitle;

/**
 *  经纬度
 */
@property (nonatomic,assign) CLLocationCoordinate2D  coordinate;
/**
 *  图片
 */
@property (nonatomic,strong) UIImage * icom;



@end
