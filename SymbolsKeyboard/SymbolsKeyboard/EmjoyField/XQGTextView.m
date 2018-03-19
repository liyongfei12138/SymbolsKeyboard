//
//  XQGTextView.m
//  SymbolsKeyboard
//
//  Created by liyongfei on 2018/3/18.
//  Copyright © 2018年 liyongfei. All rights reserved.
//

#import "XQGTextView.h"

@interface XQGTextView ()


@end
@implementation XQGTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadFaceKeyBoardView];
    }
    return self;
}

- (void)awakeFromNib
{
    [self loadFaceKeyBoardView];
}

- (void)loadFaceKeyBoardView
{
    self.viewFaceKB = [[FaceKeyBoardView alloc] init];
    
    __weak __block XQGTextView * copy_self = self;
    
    [self.viewFaceKB setFaceKeyBoardBlock:^(NSString *faceName, NSInteger faceTag) {
//        faceName = @"[33]";
        copy_self.text = [copy_self.text stringByAppendingString:faceName];
    }];
    
    [self.viewFaceKB setFaceKeyBoardSendBlock:^{
        copy_self.block();
        //清空textview
        copy_self.text = nil;
    }];
    [self.viewFaceKB setFaceKeyBoardDeleteBlock:^{
        NSMutableString * string = [[NSMutableString alloc] initWithString:copy_self.text];
        
        if (string.length > 0) {
            [string deleteCharactersInRange:NSMakeRange(copy_self.text.length - 1, 1)];
            copy_self.text = string;
        }
       
    }];
}

-(void)changeKeyBoard
{
    if (self.inputView != nil)
    {
        self.inputView = nil;
        [self reloadInputViews];
    }
    else
    {
        self.inputView = self.viewFaceKB;
        [self reloadInputViews];
    }
}

- (void)setFaceKeyBoard
{
    self.inputView = self.viewFaceKB;
}

- (void)setSendBlock:(SendBlock)block
{
    self.block = block;
}

@end

