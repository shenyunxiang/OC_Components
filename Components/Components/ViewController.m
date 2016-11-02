//
//  ViewController.m
//  Components
//
//  Created by 沈云翔 on 2016/10/31.
//  Copyright © 2016年 shenyunxiang. All rights reserved.
//

#import "ViewController.h"
#import "SY_PicLableBtn.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SY_PicLableBtn *btn = [SY_PicLableBtn buttonWithPicLabType:PicLabTypeTopImage];
    btn.frame = CGRectMake(60, 60, 0, 0);
    
    [self.view addSubview:btn];
    btn.title = @"House";

    btn.imageStr = @"addressBook_default_userIcon";
    
    btn.titleFont = [UIFont systemFontOfSize:15];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
