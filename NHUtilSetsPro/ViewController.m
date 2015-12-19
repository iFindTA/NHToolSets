//
//  ViewController.m
//  NHUtilSetsPro
//
//  Created by hu jiaju on 15/11/2.
//  Copyright © 2015年 hu jiaju. All rights reserved.
//

#import "ViewController.h"
#import "PBToolKits.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"PBToolKits";
    
    CGRect info = CGRectMake(100, 100, 100, 100);
    UIImage *image = [UIImage imageNamed:@"sina150"];
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
    
    PBMAIN(^{
        NSLog(@"some thing");
    });
    
    PBMAINDelay(2.5, ^{
        NSLog(@"some thing delay");
    });
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NHINFO" ofType:@"DB"];
    BOOL nilvalue = [NSString pb_isNull:filePath];
    NSLog(@"path:%@=== is null value :%d",filePath,nilvalue);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
