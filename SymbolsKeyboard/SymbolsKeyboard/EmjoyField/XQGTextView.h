//
//  XQGTextView.h
//  SymbolsKeyboard
//
//  Created by liyongfei on 2018/3/18.
//  Copyright © 2018年 liyongfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceKeyBoardView.h"
typedef void (^SendBlock)(void);
@interface XQGTextView : UITextView


@property (nonatomic, strong)FaceKeyBoardView * viewFaceKB;
@property (nonatomic, strong)SendBlock block;
-(void)changeKeyBoard;

- (void)setFaceKeyBoard;
- (void)setSendBlock:(SendBlock)block;
@end
