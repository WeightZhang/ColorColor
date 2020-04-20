//
//  DataTool.m
//  洪水猛兽
//
//  Created by 张伟凯 on 14-6-15.
//  Copyright (c) 2014年 张伟凯. All rights reserved.
//

#import "DataTool.h"

@implementation DataTool

- (void)saveDateToBundle{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:self.gameMode forKey:@"gameMode"];
    [userDefaults setInteger:self.mapCol forKey:@"mapCol"];
    [userDefaults setInteger:self.mapRow forKey:@"mapRow"];
    [userDefaults setInteger:self.btnColor forKey:@"btnColor"];
    [userDefaults setInteger:self.soundOn forKey:@"soundOn"];
     [userDefaults setInteger:self.mapSize forKey:@"mapSize"];
    [userDefaults synchronize];
}

- (void)loadData{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.gameMode = [userDefaults integerForKey:@"gameMode"];
    self.mapCol = [userDefaults integerForKey:@"mapCol"];
    self.mapRow = [userDefaults integerForKey:@"mapRow"];
    self.btnColor = [userDefaults integerForKey:@"btnColor"];
    self.soundOn = [userDefaults integerForKey:@"soundOn"];
        self.mapSize = [userDefaults integerForKey:@"mapSize"];
            self.playTimes = [userDefaults integerForKey:@"playTimes"];
}
- (void)updataSaveDataWithPlayTimes{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:self.playTimes forKey:@"playTimes"];
    [userDefaults synchronize];
}
+ (void)updataSaveDataWithSound:(int)soundOn{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:soundOn forKey:@"soundOn"];
    [userDefaults synchronize];
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static DataTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    
    return instance;
}

+ (instancetype)sharedDataTool
{
    return [[self alloc] init];
}
@end
