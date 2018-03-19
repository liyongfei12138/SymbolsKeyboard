//
//  FacesManager.m
//  SymbolsKeyboard
//
//  Created by liyongfei on 2018/3/18.
//  Copyright © 2018年 liyongfei. All rights reserved.
//

#import "FacesManager.h"

@implementation FacesManager


+(instancetype)share
{
    static FacesManager * m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[FacesManager alloc] init];
    });
    return m ;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self fetchAllFaces];
//        [self fetchRecentlyFaces];
    }
    return self;
}

- (void)fetchAllFaces
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
//    NSLog(@"%@",path);
      NSDictionary * dict = [[NSDictionary alloc]initWithContentsOfFile:path];
    NSArray * listContentsArray = dict[@"AllFaces"];
//    NSLog(@"%@",listContentsArray);
//    NSArray * arrFace = [NSArray arrayWithContentsOfFile:path];
   
    _AllFaces = listContentsArray;
}
//- (void)fetchRecentlyFaces
//{
//    NSUserDefaults * defauls = [NSUserDefaults standardUserDefaults];
//    NSArray * arrFace = [defauls objectForKey:@"RecentlyFaces"];
//    _RecentlyFaces = arrFace;
//}



@end
