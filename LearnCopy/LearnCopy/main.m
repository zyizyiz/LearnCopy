//
//  main.m
//  LearnCopy
//
//  Created by ios on 2019/1/3.
//  Copyright © 2019年 KN. All rights reserved.
//
/*
copy       对不可变对象进行浅拷贝（指针拷贝，不改变内存地址），
           对可变对象进行深拷贝（重新开辟一块内存，改变内存地址），
           对自定义对象进行深拷贝
 
mutable    对对象进行深拷贝（改变其内存地址）
 
注意：      对多层对象（NSDictionary、NSArray）的内层不进行拷贝（元素内存地址不变）
 
 解决第二层没有深拷贝的问题
 [NSMutableArray alloc] initWithArray:<#(nonnull NSArray *)#> copyItems:<#(BOOL)#>
 归档和解档解决多层没有深拷贝的问题
 [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:<#(nonnull id)#>]]
*/

#import <Foundation/Foundation.h>

// copy         对不可变对象进行浅拷贝
// mutableCopy  对不可变对象进行深拷贝
void copyNSString(){
    NSString *str = @"123";
    NSString *copyStr = [str copy];
    NSMutableString *mutableStr = [str mutableCopy];
    // copy 浅拷贝，不拷贝对象本身，仅仅是拷贝指向对象的指针。
    // mutableCopy 深拷贝，是直接拷贝整个对象内存到另一块内存中。
    // 指针地址不一样
    NSLog(@"str:%@ ----> %p",str,str);
    NSLog(@"copyStr:%@ ----> %p",copyStr,copyStr);
    NSLog(@"mutableStr:%@ ----> %p",mutableStr,mutableStr);
    NSLog(@"-----------------------------");
    str = @"456";
    NSLog(@"str:%@ ----> %p",str,str);
    NSLog(@"copyStr:%@ ----> %p",copyStr,copyStr);
    NSLog(@"mutableStr:%@ ----> %p",mutableStr,mutableStr);
}

// copy mutableCopy 对可变参数进行深拷贝
void copyNSMutableString(){
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"123"];
    NSString *copyStr = [str copy];
    NSMutableString *mutableStr = [str mutableCopy];
    // 指针地址不一样
    NSLog(@"str:%@ ----> %p",str,str);
    NSLog(@"copyStr:%@ ----> %p",copyStr,copyStr);
    NSLog(@"mutableStr:%@ ----> %p",mutableStr,mutableStr);
    NSLog(@"-----------------------------");
    [str appendString:@"456"];
    NSLog(@"str:%@ ----> %p",str,str);
    NSLog(@"copyStr:%@ ----> %p",copyStr,copyStr);
    NSLog(@"mutableStr:%@ ----> %p",mutableStr,mutableStr);
}


@interface CityInfo :NSObject<NSCopying,NSMutableCopying>

@property(nonatomic,copy)NSString *cityName;
@property(nonatomic,copy)NSString *cityDesribe;
@end

@implementation CityInfo

- (id)copyWithZone:(NSZone *)zone {
    CityInfo *city = [[CityInfo allocWithZone:zone] init];
    city.cityName = self.cityName;
    city.cityDesribe = self.cityDesribe;
    return city;
}

-(id)mutableCopyWithZone:(NSZone *)zone {
    CityInfo *city = [[CityInfo allocWithZone:zone]init];
    city.cityName = self.cityName;
    city.cityDesribe = self.cityDesribe;
    return city;
}

@end

// copy mutableCopy 对自定义对象实行深拷贝
void copyCustomObject() {
    CityInfo *city = [[CityInfo alloc]init];
    city.cityName = @"杭州";
    city.cityDesribe = @"西湖";
    CityInfo *copyCity = [city copy];
    CityInfo *mutableCity = [city mutableCopy];
    NSLog(@"city:%p ---- name: %@ ----- desribe: %@",city,city.cityName,city.cityDesribe);
    NSLog(@"copyCity:%p ---- name: %@ ----- desribe: %@",copyCity,copyCity.cityName,copyCity.cityDesribe);
    NSLog(@"mutableCity:%p ---- name: %@ ----- desribe: %@",mutableCity,mutableCity.cityName,mutableCity.cityDesribe);
}

void copyDictionary(){
    NSMutableString *str1 = [NSMutableString stringWithFormat:@"123"];
    NSMutableString *str2 = [NSMutableString stringWithFormat:@"456"];
    
    NSLog(@"str1 : %lu > %p ------ str2 : %lu > %p",[str1 retainCount],str1,[str2 retainCount],str2);
    // str1 : 1 > 0x100524780 ------ str2 : 1 > 0x100524d60
    NSDictionary * dic = @{
                           @"str1":str1,
                           @"str2":str2
                           };
    // 字典储存指针
    // str1 : 2 > 0x100524780 ------ str2 : 2 > 0x100524d60
    NSLog(@"str1 : %lu > %p ------ str2 : %lu > %p",[str1 retainCount],str1,[str2 retainCount],str2);
    // 浅拷贝 地址一样
    NSDictionary *copyDic = [dic copy];
    NSMutableDictionary *mutableDic = [dic mutableCopy];
    NSLog(@"dic:%@ ------ %p",dic,dic);
    NSLog(@"copyDic:%@ ------ %p",copyDic,copyDic);
    NSLog(@"mutableDic:%@ ------ %p",mutableDic,mutableDic);
    NSLog(@"-----------------------------");
    [str1 appendString:@"abc"];
    NSLog(@"dic:%@ ------ %p",dic,dic);
    NSLog(@"copyDic:%@ ------ %p",copyDic,copyDic);
    /*
     mutableDic:{
     str1 = 123abc;
     str2 = 456;
     } ------ 0x100707e20
     深拷贝的同时 对二层对象不进行深拷贝，而是进行复制（不增加其引用计数）
     */
    NSLog(@"mutableDic:%@ ------ %p",mutableDic,mutableDic);
    NSLog(@"str1 : %lu > %p ------ str2 : %lu > %p",[str1 retainCount],str1,[str2 retainCount],str2);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSMutableString *str1 = [NSMutableString stringWithFormat:@"123"];
        NSMutableString *str2 = [NSMutableString stringWithFormat:@"456"];
        
        NSLog(@"str1 : %lu > %p ------ str2 : %lu > %p",[str1 retainCount],str1,[str2 retainCount],str2);
        // 数组遇到nil截止 , 数组内部指针拷贝 +1
        NSMutableArray *array = [NSMutableArray arrayWithObjects:str1,str2, nil];
        // 对数组进行深拷贝 将数组内部的第二层对象进行指针拷贝
        NSArray *copyArray = [array copy];
        NSMutableArray *mutableArray = [array mutableCopy];
        
        NSLog(@"str1 : %lu > %p ------ str2 : %lu > %p",[str1 retainCount],str1,[str2 retainCount],str2);
        NSLog(@"array:%@ ----- %p",array,array);
        NSLog(@"copyArray:%@ ----- %p",copyArray,copyArray);
        NSLog(@"mutableArray:%@ ----- %p",mutableArray,mutableArray);
        NSLog(@"-----------------------------");
        
        
        [str1 appendString:@"abc"];
        NSLog(@"array:%@ ----- %p",array,array);
        NSLog(@"copyArray:%@ ----- %p",copyArray,copyArray);
        NSLog(@"mutableArray:%@ ----- %p",mutableArray,mutableArray);
        NSLog(@"-----------------------------");
        
        
        [array addObject:@"789"];
        NSLog(@"array:%@ ----- %p",array,array);
        NSLog(@"copyArray:%@ ----- %p",copyArray,copyArray);
        NSLog(@"mutableArray:%@ ----- %p",mutableArray,mutableArray);
        
        /*
         解决第二层没有深拷贝的问题
         [NSMutableArray alloc] initWithArray:<#(nonnull NSArray *)#> copyItems:<#(BOOL)#>
         归档和解档解决多层没有深拷贝的问题
         [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:<#(nonnull id)#>]]
         */
        
        
    }
    return 0;
}


