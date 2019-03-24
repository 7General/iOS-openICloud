//
//  MainViewController.m
//  UNRecognisedSelector
//
//  Created by zzg on 2018/12/22.
//  Copyright © 2018年 zzg. All rights reserved.
//

#import "MainViewController.h"
#import "Father.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //guagua://groupcode/?id=331807746243031042&encryptStr=97AB6DF4F29F8D66496C92D150D07D1FFE619A447EE5A2901A18CDC655187D8E53C52E2DC2D9ECAD9218B6AE56669152750E4009112DF23581E13F0835A52255&time=1545811616855

    
    
    NSString * joinGroupInfo = @"guagua://groupcode/?id=331807746243031042&encryptStr=97AB6DF4F29F8D66496C92D150D07D1FFE619A447EE5A2901A18CDC655187D8E53C52E2DC2D9ECAD9218B6AE56669152750E4009112DF23581E13F0835A52255&time=1545811616855";
    
    NSString * charId = [self queryParamters:@"id" webaddress:joinGroupInfo];
    NSString * encryptStr = [self queryParamters:@"encryptStr" webaddress:joinGroupInfo];
    NSString * time = [self queryParamters:@"time" webaddress:joinGroupInfo];
    
    NSLog(@"charid--:%@---->>>encryptStr:%@====>>>time:%@",charId,encryptStr,time);

}

- (NSString *) queryParamters:(NSString *)paramKey webaddress:(NSString *)urlAddress {
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",paramKey];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *matches = [regex matchesInString:urlAddress
                                      options:0
                                        range:NSMakeRange(0, [urlAddress length])];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [urlAddress substringWithRange:[match rangeAtIndex:2]];
        return tagValue;
    }
    return @"";
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    Father * father = [[Father alloc] init];
    [father derveCar];
}


@end
