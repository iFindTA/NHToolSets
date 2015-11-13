//
//  ViewController.m
//  NHUtilSetsPro
//
//  Created by hu jiaju on 15/11/2.
//  Copyright © 2015年 hu jiaju. All rights reserved.
//

#import "ViewController.h"
#import "NHUtils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Util Sets";
    
    CGRect info = CGRectMake(100, 100, 100, 100);
    UIImage *image = [UIImage imageNamed:@"sina150"];
    UIImage *dark = [image darkColor:[UIColor blackColor] lightLevel:0.5];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:info];
    imgView.image = image;
    [self.view addSubview:imgView];
    
    info.origin.y += 150;
    imgView = [[UIImageView alloc] initWithFrame:info];
    imgView.image = dark;
    [self.view addSubview:imgView];
    
    info.origin.y += 150;
    CGRect bounds ;
    bounds.origin = CGPointZero;
    bounds.size = info.size;
    UIView *view = [[UIView alloc] initWithFrame:bounds];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    imgView = [[UIImageView alloc] initWithFrame:info];
    imgView.image = image;
    [imgView addSubview:view];
    [self.view addSubview:imgView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end