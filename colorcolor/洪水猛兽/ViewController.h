//
//  ViewController.h
//  洪水猛兽
//
//  Created by 张伟凯 on 14-6-8.
//  Copyright (c) 2014年 张伟凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "OverView.h"
@interface ViewController : BaseViewController
@property(nonatomic,strong)NSMutableArray *saveArray;

//颜色相关
@property(nonatomic,strong)NSArray *currentColor;
@end
