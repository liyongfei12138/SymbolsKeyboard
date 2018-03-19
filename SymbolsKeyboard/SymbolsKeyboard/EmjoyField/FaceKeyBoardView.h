//
//  FaceKeyBoardView.h
//  SymbolsKeyboard
//
//  Created by liyongfei on 2018/3/18.
//  Copyright © 2018年 liyongfei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GrayColor [UIColor colorWithRed:231 / 255.0 green:231 / 255.0 blue:231 / 255.0 alpha:1]
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//#define ToolBarHeight 0

typedef void (^FaceKeyBoardBlock)(NSString * faceName,NSInteger faceTag);
typedef void (^FaceKeyBoardSendBlock)(void);
typedef void (^FaceKeyBoardDeleteBlock)(void);

@interface FaceKeyBoardView : UIView

- (void)setFaceKeyBoardBlock:(FaceKeyBoardBlock)block;
- (void)setFaceKeyBoardSendBlock:(FaceKeyBoardSendBlock)block;
- (void)setFaceKeyBoardDeleteBlock:(FaceKeyBoardDeleteBlock)block;
@end

