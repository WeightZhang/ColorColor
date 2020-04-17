//
//  SoundBtn.m
//  洪水猛兽
//
//  Created by 张伟凯 on 14-6-15.
//  Copyright (c) 2014年 张伟凯. All rights reserved.
//

#import "SoundBtn.h"

@implementation SoundBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}
- (void)awakeFromNib{
    [self setImage:[UIImage imageNamed:@"menu_btn_sound_off"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"menu_btn_sound_on"] forState:UIControlStateSelected];

}
//重写hight方法
- (void)setHighlighted:(BOOL)highlighted{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
