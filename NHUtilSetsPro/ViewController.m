//
//  ViewController.m
//  NHUtilSetsPro
//
//  Created by hu jiaju on 15/11/2.
//  Copyright © 2015年 hu jiaju. All rights reserved.
//

#import "ViewController.h"
#import "PBKits.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"PBToolKits";
    
    CGRect info = CGRectMake(100, 100, 100, 100);
//    UIImage *image = [UIImage imageNamed:@"sina150"];
    UIImage *image = [UIImage pb_imagePathed:@"sina150"];
    UIImage *dark = [image pb_darkColor:[UIColor blackColor] lightLevel:0.5];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:info];
    imgView.image = image;
    [self.view addSubview:imgView];
    
    info.origin.y += 150;
    imgView = [[UIImageView alloc] initWithFrame:info];
    imgView.image = dark;
    [self.view addSubview:imgView];
    
    info.origin.y += 150;
    imgView = [[UIImageView alloc] initWithFrame:info];
    imgView.image = [UIImage pb_iconFont:nil withName:@"\U0000E616" withSize:100 withColor:[UIColor blueColor]];
    [self.view addSubview:imgView];
    
    info.origin.y += 150;
    UIView *bgView = [[UIView alloc] initWithFrame:(CGRect){.origin=info.origin,.size=CGSizeMake(70, 30)}];
    CGBCornerColor corner = {8,0xF5F5F5};
    CGBWidthColor border = {1,0xC8C8C8};
    [bgView pb_addRound:corner withBorder:border];
    [self.view addSubview:bgView];
    
    weakify(self);
    PBMAIN(^{
        strongify(self);
        [self doSomething];
        NSLog(@"some thing");
    });
    
    PBMAINDelay(2.5, ^{
        NSLog(@"some thing delay");
    });
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NHINFO" ofType:@"DB"];
    BOOL nilvalue = PBIsEmpty(filePath);
    NSLog(@"path:%@=== is null value :%d",filePath,nilvalue);
    
    NSString *appname = [NSBundle pb_displayName];
    NSLog(@"app name :%@",appname);
    NSString *ver = [NSBundle pb_releaseVersion];
    NSLog(@"release ver:%@",ver);
    
    BOOL higher = PBSysHighThan(@"8.0");
    NSLog(@"screen scale:%d",higher);
    
}

- (void)doSomething {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
