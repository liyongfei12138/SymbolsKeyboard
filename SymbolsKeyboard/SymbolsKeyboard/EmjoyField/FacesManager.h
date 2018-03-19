//
//  FacesManager.h
//  SymbolsKeyboard
//
//  Created by liyongfei on 2018/3/18.
//  Copyright © 2018年 liyongfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacesManager : NSObject

//@property (nonatomic, strong, readonly)NSArray * RecentlyFaces;
@property (nonatomic, strong, readonly)NSArray * AllFaces;
//@property (nonatomic, strong, readonly)NSArray * BigFaces;

+ (instancetype)share;
//- (void)fetchRecentlyFaces;
- (void)fetchAllFaces;
@end
