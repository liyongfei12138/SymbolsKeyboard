//
//  MainViewController.m
//  SymbolsKeyboard
//
//  Created by liyongfei on 2018/3/18.
//  Copyright © 2018年 liyongfei. All rights reserved.
//

#import "MainViewController.h"
#import "XQGTextView.h"

@interface MainViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet XQGTextView *viewText;
@property (weak, nonatomic) IBOutlet UIView *viewChatToolBar;
@property (weak, nonatomic) IBOutlet UILabel *lalText;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //清空常用表情
    //    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    //    NSMutableArray * arrFaces = [defaults objectForKey:@"RecentlyFaces"];
    //    arrFaces = nil;
    //    [defaults setObject:arrFaces forKey:@"RecentlyFaces"];
    
    self.viewText.delegate = self;
 
    //监听键盘弹出的通知
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center addObserver:self selector:@selector(KeyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

//发送图文
- (void)sendPictureAndText
{
    //正则表达式取出表情
    NSString * str = self.viewText.text;
    NSMutableAttributedString * strAtt = [[NSMutableAttributedString alloc] initWithString:str];
    //创建匹配正则表达式类型描述模板
    NSString * pattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    //依据正则表达式创建匹配对象
    NSError * error = nil;
    //CaseInsensitive
    NSRegularExpression * regular = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    if (regular == nil)
    {
        NSLog(@"正则创建失败");
        NSLog(@"%@",error.localizedDescription);
        return;
    }
    //把搜索出来的结果存到数组中
    NSArray * result = [regular matchesInString:strAtt.string options:NSMatchingReportCompletion range:NSMakeRange(0, strAtt.string.length)];
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"emoticons.plist" ofType:nil];
    NSDictionary * dict = [[NSDictionary alloc]initWithContentsOfFile:path];
//    NSArray * listContentsArray =
    NSArray * arrPlist = dict[@"AllFaces"];
    
    for (NSInteger i = result.count - 1; i >= 0; i--)
    {
        NSTextCheckingResult * r = result[i];
        NSLog(@"%@",NSStringFromRange(r.range));
        NSString * imageStr = [strAtt.string substringWithRange:r.range];
        NSLog(@"%@",imageStr);
        
        for (NSDictionary * dic in arrPlist)
        {
            if ([dic[@"cht"] isEqualToString:imageStr])
            {
                NSTextAttachment * textAtt = [[NSTextAttachment alloc] init];
                textAtt.image = [UIImage imageNamed:dic[@"png"]];
                NSAttributedString * strImage = [NSAttributedString attributedStringWithAttachment:textAtt];
                [strAtt replaceCharactersInRange:r.range withAttributedString:strImage];
            }
        }
    }
    self.lalText.attributedText = strAtt;
}

//监听键盘弹出的方法
//-(void)KeyBoardWillChangeFrame: (NSNotification *)noteInfo
//{
    //获取键盘的Y值
//    CGRect keySize = [noteInfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat keyY = keySize.origin.y;
    //让view跟随键盘移动
//    CGFloat viewY = keyY - self.view.bounds.size.height;
    //让view变化和键盘变化一致
//    self.view.transform = CGAffineTransformMakeTranslation(0, viewY);
//}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    if ([touch.view isEqual:self.view]) {
        [self.view endEditing:YES];
    }
}
//监控编辑结束状态
-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.viewText.inputView = nil;
}


//- (IBAction)tapVoice:(UIButton *)sender {
//    NSLog(@"切换语音");
//}

- (IBAction)tapFace:(UIButton *)sender
{
    //如果还没弹出键盘就直接弹出表情键盘；弹出了就改变键盘样式
    if (self.viewText.isFirstResponder)
    {
        [self.viewText changeKeyBoard];
    }
    else
    {
        [self.viewText setFaceKeyBoard];
        [self.viewText becomeFirstResponder];
    }
}
- (IBAction)sendBtn:(id)sender
{
    //发送回调
//    [self.viewText setSendBlock:^{
        [self sendPictureAndText];
//    }];
}

//- (IBAction)tapMoreFunction:(UIButton *)sender {
//    NSLog(@"更多功能");
//}


@end
