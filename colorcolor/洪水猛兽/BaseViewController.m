//
//  BaseViewController.m
//  洪水猛兽
//
//  Created by 张伟凯 on 14-6-15.
//  Copyright (c) 2014年 张伟凯. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic,assign) int btnColor;   //按钮 颜色
@end

@implementation BaseViewController
#pragma mark - 切换颜色相关
- (NSArray *)currentColor{
    if (_currentColor == nil) {
        switch (self.btnColor) {
            case 0: _currentColor = [ColorTool RGBColor];  break;
            case 1: _currentColor = [ColorTool RGBColor1];  break;
            case 2: _currentColor = [ColorTool RGBColor2];  break;
            case 3: _currentColor = [ColorTool RGBColor3];  break;
                
            default:
                break;
        }
        _currentColor = [ColorTool RGBColor3];
    }
    return _currentColor;
}

- (BOOL)becomeFirstResponder{
    return YES;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (event.type == UIEventSubtypeMotionShake) {
//        NSLog(@"摇动手势 began");
        [UIView animateWithDuration:1.0 animations:^{
            self.view.backgroundColor =   [ColorTool RGBColorBG][arc4random()%12];
        }];
    }
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (event.type == UIEventSubtypeMotionShake) {
//        NSLog(@"摇动手势 end");
    }
}
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (event.type == UIEventSubtypeMotionShake) {
//        NSLog(@"摇动手势 cancell");
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
