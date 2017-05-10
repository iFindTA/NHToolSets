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
    
    NSString *qrInfos = @"{\"key\":\"孙凯\"}";
    
    CGRect info = CGRectMake(100, 100, 100, 100);
    UIImage *image = [UIImage pb_generateQRCode:qrInfos size:info.size];
//    UIImage *image = [UIImage pb_imagePathed:@"sina150"];
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
    
    info.origin.y += 100;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = info;
    [btn setTitle:@"time ago" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(timeAgoEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.definesPresentationContext = true;
    
    NSString *name = @" 曾魁";
    NSString *ascii = [name pb_zhHans2Ascii4Type:PBZHHans2AsciiTypeLastChar];
    NSLog(@"asccis:%@",ascii);
    name = @"y保护伞";
    ascii = [name pb_zhHansTransform2Ascii];
    NSLog(@"asccis:%@",ascii);
    name = @"_y保护伞";
    ascii = [name pb_zhHansTransform2Ascii];
    NSLog(@"asccis:%@",ascii);
    
    NSString *usr = @"nanhujiaju";
    NSLog(@"origin:%@---sha256:%@--md5:%@---sha1hash:%@",usr,usr.pb_SHA256,usr.pb_MD5Hash,usr.pb_SHA1Hash);
}

- (void)doSomething {
    
}

- (void)timeAgoEvent {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *someString = @"2016-07-6 16:25:33";
    NSTimeInterval interval = arc4random()%100000000;
    NSDate *justNow = [NSDate dateWithTimeIntervalSinceNow:30];
    NSLog(@"just now:%@",[justNow pb_timeAgo]);
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:-interval];
    now = [formatter dateFromString:someString];
    NSString *time = [formatter stringFromDate:now];
    NSLog(@"time is :%@",time);
    NSLog(@"time ago is:%@",[now pb_timeAgo]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
