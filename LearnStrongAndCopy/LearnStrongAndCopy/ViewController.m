//
//  ViewController.m
//  LearnStrongAndCopy
//
//  Created by ios on 2019/1/22.
//  Copyright © 2019年 KN. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) NSArray *immutableArray;


@property (nonatomic,copy) NSArray *copArray;

//@property (nonatomic,strong) NSMutableArray *mutableArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithObject:@"111"];
    self.immutableArray = [NSArray array];
    self.copArray = [NSArray array];
    NSLog(@"before mutableArray=%@,immutableArray=%@,copy=%@",mutableArray,self.immutableArray,self.copArray);
    
    self.immutableArray = mutableArray;
    self.copArray = mutableArray;
    [mutableArray addObject:@"222"];
    
    NSLog(@"after mutableArray=%@,immutableArray=%@,copy=%@",mutableArray,self.immutableArray,self.copArray);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
