//
//  StrongAndCopy.m
//  LearnCopy
//
//  Created by ios on 2019/1/22.
//  Copyright © 2019年 KN. All rights reserved.
//

#import "StrongAndCopy.h"

@interface StrongAndCopy()


@property(nonatomic,copy)NSMutableArray *aArray;
@property(nonatomic,strong)NSMutableArray *bArray;

@end

@implementation StrongAndCopy

- (void)test
{
    NSMutableArray *cArray = [NSMutableArray array];
    _aArray = cArray;
    _bArray = cArray;
    NSLog(@"a.class = %@",[_aArray class]);
    NSLog(@"b.class = %@",[_bArray class]);
    
    [_aArray removeAllObjects];
    [_bArray removeAllObjects];
    
    
}


@end
