//
//  ViewController.m
//  SymbolsKeyboard
//
//  Created by liyongfei on 2018/3/15.
//  Copyright © 2018年 liyongfei. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"
#import <YYKit.h>
#import "CarmerImageCollectionViewCell.h"
#import "CarmerADDImageCollectionViewCell.h"
#import "ZYQAssetPickerController.h"
//#include "main."
@interface ViewController ()<YYTextViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,ZYQAssetPickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
//@property (weak, nonatomic) IBOutlet UITextField *textField;
{
    UITextField *titleField;
    YYTextView *commentView;
    UILabel *countLabel;
    NSString *countStr;
    
    UICollectionView *collertionView;
    UIButton *imgBtn;
    
    NSMutableArray *imgArr;
}
@end
#define maxTextCount @"300"
#define kSmallGray [UIColor colorWithRed:241.0/255.0 green:242.0/255.0 blue:243.0/255.0 alpha:1.0f]
#define kSmallBlue [UIColor colorWithRed:16.0/255.0 green:170.0/255.0 blue:243.0/220.0 alpha:1.0f]
#define kSmallTextGray [UIColor colorWithRed:64.0/255.0 green:64.0/255.0 blue:64.0/220.0 alpha:1.0f]
@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"发布新帖";
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [releaseBtn setTitle:@"发布" forState:UIControlStateNormal];
    [releaseBtn setTitleColor:kSmallBlue forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releaseBtn];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTitleFieldView];
    [self setUpImgView];
    
    [self setCarmerCollectView];
    
    [self initValue];
    
}
#define url @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521196009983&di=a448ff8400dea9653f1f31308c685f0a&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%253D580%2Fsign%3Dd34ba9a5cd1b9d168ac79a69c3dfb4eb%2Fad8f3aca7bcb0a465792b0436863f6246a60af91.jpg"
#define url1 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521196009984&di=ba90749f87cb03bc38571a0afaab7fec&imgtype=0&src=http%3A%2F%2Fa3.topitme.com%2F8%2Fec%2F2d%2F11289854872e22dec8l.jpg"
#define url2 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521196582411&di=7cf645521cadd411e7de36825a044425&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Fd833c895d143ad4b26d681ea81025aafa40f0624.jpg"
- (void)initValue
{
    imgArr = [NSMutableArray array];
//    UIImage *img = [UIImage imageNamed:@"ttt"];
//
////    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:img,@"0", nil];
//
//    [imgArr addObject:img];
//
//    [imgArr addObject:img];
//    [imgArr addObject:img];
}
- (void)setShadowView:(CGFloat)shadowY shadowHeight:(CGFloat)shadowHeight
{
    UIView *shadowView = [[UIView alloc] init];
    shadowView.backgroundColor = kSmallGray;
    shadowView.frame = CGRectMake(0, shadowY, self.view.frame.size.width, shadowHeight);
    [self.view addSubview:shadowView];
}
- (void)setTitleFieldView
{
    
    [self setShadowView:0 shadowHeight:5];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(10, 20, self.view.frame.size.width, 50);
    titleLabel.textColor = kSmallTextGray;
    titleLabel.text = @"标题";
    titleLabel.font = [UIFont systemFontOfSize:22];
    [titleLabel sizeToFit];
    [self.view addSubview:titleLabel];
    
    titleField = [[UITextField alloc] init];
    titleField.font = [UIFont systemFontOfSize:20];
    titleField.textColor = kSmallTextGray;
    titleField.delegate = self;
//    titleField.placeholder = @"";
    titleField.x = CGRectGetMaxX(titleLabel.frame) + 5;
    titleField.width = self.view.width - titleField.x - 10;
    titleField.height = 50;
    titleField.centerY = titleLabel.centerY;
//    titleField.backgroundColor = [UIColor redColor];
    [self.view addSubview:titleField];
    
    
    [self setShadowView:CGRectGetMaxY(titleField.frame) shadowHeight:1];
    
    commentView = [[YYTextView alloc] init];
    commentView.delegate = self;
    commentView.font = [UIFont systemFontOfSize:18];
    commentView.textColor = kSmallTextGray;
    commentView.placeholderText = @"尽情挥洒你的文采吧~";
    commentView.frame = CGRectMake(10, CGRectGetMaxY(titleField.frame) + 1, self.view.width - 20, self.view.height * 0.32);
//    commentView.backgroundColor = [UIColor redColor];
    [self.view addSubview:commentView];
    
    countStr = @"00";
    
    countLabel = [[UILabel alloc] init];
    
    countLabel.text = [NSString stringWithFormat:@"%@/%@",countStr,maxTextCount];
    countLabel.textColor = kSmallTextGray;
    [countLabel sizeToFit];
    countLabel.x = self.view.width - 10 - countLabel.width;
    countLabel.y = CGRectGetMaxY(commentView.frame) + 2;
    [self.view addSubview:countLabel];

    [self setShadowView:CGRectGetMaxY(countLabel.frame) shadowHeight:1];
}
- (void)setUpImgView
{
    UIButton *emjoyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [emjoyBtn setBackgroundImage:[UIImage imageNamed:@"3gHud"] forState:UIControlStateNormal];
    [emjoyBtn addTarget:self action:@selector(buttonDidSelected:) forControlEvents:UIControlEventTouchUpInside];
    emjoyBtn.x = 20;
    emjoyBtn.tag = 10;
    emjoyBtn.y = CGRectGetMaxY(countLabel.frame) + 5;
    [emjoyBtn sizeToFit];
    
    [self.view addSubview:emjoyBtn];
    
    imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imgBtn setBackgroundImage:[UIImage imageNamed:@"3gHud"] forState:UIControlStateNormal];
    [imgBtn addTarget:self action:@selector(buttonDidSelected:) forControlEvents:UIControlEventTouchUpInside];
    imgBtn.x = CGRectGetMaxX(emjoyBtn.frame) + 20;
    imgBtn.y = CGRectGetMaxY(countLabel.frame) + 5;
    [imgBtn sizeToFit];
    imgBtn.tag = 11;
    [self.view addSubview:imgBtn];
    
    [self setShadowView:CGRectGetMaxY(emjoyBtn.frame) + 5 shadowHeight:1];
}

- (void)setCarmerCollectView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    
//     [layout setSectionInset:UIEdgeInsetsMake(0, 5, 0, 5)];
    collertionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imgBtn.frame) + 20, self.view.width, 120) collectionViewLayout:layout];
    collertionView.backgroundColor = [UIColor whiteColor];
    collertionView.scrollEnabled = NO;
    collertionView.delegate = self;
    collertionView.dataSource = self;
    [self.view addSubview:collertionView];
}
#pragma mark - collertionView代理方法
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.width * 0.25 - 5, self.view.width * 0.25 + 10);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return imgArr.count + 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    
    
    
    if (indexPath.row == imgArr.count) {
        static NSString *addID = @"myAddCarmerCell";
        
        
        UINib *nib = [UINib nibWithNibName:@"CarmerADDImageCollectionViewCell"
                                    bundle: [NSBundle mainBundle]];
        [collectionView registerNib:nib forCellWithReuseIdentifier:addID];
        
        CarmerADDImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:addID forIndexPath:indexPath];
         cell.imgView.image = [UIImage imageNamed:@"3gHud"];
        
        if (imgArr.count < 3 && imgArr.count >  0) {
            cell.hidden = NO;
        }
        else
        {
            cell.hidden = YES;
        }
       
        
        return cell;
    }else{
        
        static NSString *ID = @"myCarmerCell";
        
        UINib *nib = [UINib nibWithNibName:@"CarmerImageCollectionViewCell"
                                    bundle: [NSBundle mainBundle]];
        [collectionView registerNib:nib forCellWithReuseIdentifier:ID];
        
        CarmerImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        [cell.imgView setImage:imgArr[indexPath.row]];
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setImage:[UIImage imageNamed:@"3gHud"] forState: UIControlStateNormal];
        deleteBtn.tag = indexPath.row;
        deleteBtn.size = CGSizeMake(30, 30);
        [deleteBtn addTarget:self action:@selector(buttonDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.frame = CGRectMake(cell.width - deleteBtn.width, 0, 30, 30);
        [cell addSubview:deleteBtn];
         return cell;
    }
    
 
  
    
   
}


#pragma mark - 退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - YYTextView- // 统计字数以及限制字数
#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
//    NSLog(@"%d",[ViewController stringContainsEmoji:textField.text]);
    

    if (titleField.text.length > 19) {
        titleField.text = [textField.text substringToIndex:19];
    }else{
        
    }
    return YES;
}

#pragma mark -------YYTextViewDelegate
- (void)textViewDidChangeSelection:(YYTextView *)textView
{
    
    NSRange textRange = [textView selectedRange];
    [textView setText:[self disable_emoji:[textView text]]];
    [textView setSelectedRange:textRange];
    
    NSUInteger count = textView.text.length;
    NSUInteger maxCount = [[NSNumber numberWithString:maxTextCount] integerValue];
    if (count > maxCount) {
        textView.text = [textView.text substringToIndex:maxCount];
        count = count - 1;
    }
    countStr = [NSString stringWithFormat:@"%lu",count];
    countLabel.text = [NSString stringWithFormat:@"%@/%@",countStr,maxTextCount];
    [countLabel sizeToFit];
}
//禁止输入表情
- (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

#pragma mark - 点击按钮事件
- (void)buttonDidSelected:(id)sender
{
    UIButton* button = (UIButton*)sender;
    NSInteger tag = button.tag;
    
    
    // 表情
    if (tag == 10) {
        
    }
    else if (tag == 11)// 相册
    {
        [self showCamera];
    }
    else if (tag == 0)
    {
        [imgArr removeObjectAtIndex:tag];
        
//        if (imgArr.count < 3) {
//            [imgArr addObject:[UIImage imageNamed:@"3gHud"]];
//        }
        
        [collertionView reloadData];
    }
    else if (tag == 1)
    {
        [imgArr removeObjectAtIndex:tag];
//        if (imgArr.count < 3) {
//            [imgArr addObject:[UIImage imageNamed:@"3gHud"]];
//        }
         [collertionView reloadData];
    }
    else if (tag == 2)
    {
//        if (imgArr.count < 3) {
//            [imgArr addObject:[UIImage imageNamed:@"3gHud"]];
//        }
        [imgArr removeObjectAtIndex:tag];
        [collertionView reloadData];
    }

}
/**
 *  打开相册
 */
- (void)showCamera
{

    ZYQAssetPickerController *imagePicker = [[ZYQAssetPickerController alloc] init];
    imagePicker.maximumNumberOfSelection = 3;
    imagePicker.assetsFilter = ZYQAssetsFilterAllPhotos;
    imagePicker.showEmptyGroups = NO;
    imagePicker.delegate = self;

    [self presentViewController:imagePicker animated:YES completion:nil];
    
}
#pragma mark - ZYQAssetPickerControllerDelegate
//选择图片上限提示
-(void)assetPickerControllerDidMaximum:(ZYQAssetPickerController *)picker{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"到达3张图片上限" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    
    for (ZYQAsset *asset in assets) {
        [asset setGetThumbnail:^(UIImage *result) {
            [imgArr addObject:result];
            //        NSLog(@"%@",result);
        }];
    }
    [collertionView reloadData];
}

@end
