//
//  MenuViewController.m
//  洪水猛兽
//
//  Created by 张伟凯 on 14-6-15.
//  Copyright (c) 2014年 张伟凯. All rights reserved.
//

#import "MenuViewController.h"
#import "SoundBtn.h"
#import "HelpView.h"
#import "AudioTool.h"

@interface MenuViewController ()
- (IBAction)helpClick:(id)sender;
@property (weak, nonatomic) IBOutlet SoundBtn *soundBtn;

- (IBAction)soundClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *quickStart;
@property (weak, nonatomic) IBOutlet UIButton *start;
@end

@implementation MenuViewController

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
     self.view.backgroundColor = [ColorTool RGBColorBG][arc4random()%12];
    if (!iOS7) {
        self.quickStart.titleLabel.textColor = [UIColor blackColor];
        self.start.titleLabel.textColor = [UIColor blackColor];
    }

}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    DataTool *data =[DataTool sharedDataTool];
    [data loadData];
    self.soundBtn.selected = data.soundOn;


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)helpClick:(id)sender {
    [self openTipView];
}

- (IBAction)soundClick:(SoundBtn*)sender {
   
    if (sender.selected == NO ) {
        sender.selected = YES;
        [AudioTool playSound:@"soundOn.mp3"];
        NSLog(@"soundClick__NO");
    }else if (sender.selected == YES ) {
        sender.selected = NO;
        NSLog(@"soundClick__YES");
    }
    [DataTool updataSaveDataWithSound:sender.selected];
}
- (void)openTipView{

        HelpView *helpView =  [[[NSBundle mainBundle] loadNibNamed:@"HelpView" owner:nil options:nil] lastObject];
        helpView.backgroundColor = [ColorTool RGBColorBG][arc4random()%12];
        helpView.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.5 animations:^{
                [self.view addSubview:helpView];
        helpView.transform = CGAffineTransformIdentity;
    }];

    
}
@end
