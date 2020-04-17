//
//  OverView.h
//  洪水猛兽
//
//  Created by 张伟凯 on 14-6-13.
//  Copyright (c) 2014年 张伟凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OverView;
@protocol OverViewDelegate <NSObject>

@optional
- (void)overViewClickBackBtn;

@end

@interface OverView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) id<OverViewDelegate> delegate;

@property (nonatomic,assign) int topnum;
@property (nonatomic,assign) int bottomnum;
@property (nonatomic,assign) GameMode gameMode;
@end
