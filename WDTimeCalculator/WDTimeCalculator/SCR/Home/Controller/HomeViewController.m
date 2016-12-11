//
//  HomeViewController.m
//  WDTimeCalculator
//
//  Created by YJHou on 2016/12/11.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self _setUpHomeNavgationView];
    [self _setUpHomeMainView];
    [self _loadHomeDataFormServer];
}

- (void)_setUpHomeNavgationView{
    self.navigationItem.title = @"工时计算器";
}

- (void)_setUpHomeMainView{
    
}

-(void)_loadHomeDataFormServer{
    
}

@end
