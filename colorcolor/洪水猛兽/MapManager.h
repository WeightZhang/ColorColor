//
//  MapManager.h
//  ColorColor
//
//  Created by zhangweikai on 2020/4/19.
//  Copyright © 2020 张伟凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageTools.h"
#import "MapConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapManager : NSObject{
//    MapArray mapArray;
}

+ (UIView*)createMapViewWith:(MapConfig*)config;

@end

NS_ASSUME_NONNULL_END
