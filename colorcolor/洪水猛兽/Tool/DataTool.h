//
//  DataTool.h
//  洪水猛兽
//
//  Created by 张伟凯 on 14-6-15.
//  Copyright (c) 2014年 张伟凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTool : NSObject
@property(nonatomic,assign)GameMode gameMode;
@property(nonatomic,assign)int mapSize;
@property(nonatomic,assign)int mapRow;
@property(nonatomic,assign)int mapCol;
@property(nonatomic,assign)int btnColor;
@property(nonatomic,assign)int soundOn;
@property(nonatomic,assign)int playTimes;

+ (instancetype)sharedDataTool;
- (void)loadData;
- (void)saveDateToBundle;

- (void)updataSaveDataWithPlayTimes;
+ (void)updataSaveDataWithSound:(int)soundOn;
@end
