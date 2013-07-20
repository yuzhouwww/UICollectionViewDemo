//
//  ViewController.m
//  CollectionViewTest
//
//  Created by yuzhou on 13-7-5.
//  Copyright (c) 2013年 wzyk. All rights reserved.
//

#import "ViewController.h"
#import "ItemCell.h"
#import "CustomLayout.h"

@interface ViewController ()
{
    int num1;
    int num2;
    int num3;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    num1 = 5;
    num2 = 7;
    num3 = 9;
    //把ib和复用identifer绑定
    [contentCollectionView registerNib:[UINib nibWithNibName:@"ItemCell" bundle:nil] forCellWithReuseIdentifier:@"ItemCell"];
    [self action1:nil];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *array = @[@(num1),@(num2),@(num3)];
    return [[array objectAtIndex:section] intValue];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果没有复用的item会自动创建cell，别忘了前面我们绑定了ib哦
    ItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCell" forIndexPath:indexPath];
    cell.contentImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",indexPath.section]];
    return cell;
}

- (IBAction)action1:(id)sender {
    //在横向和竖向之间切换
    static int times = 0;
    times++;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(80, 80);
    flowLayout.scrollDirection = times % 2 == 1 ? UICollectionViewScrollDirectionHorizontal : UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [contentCollectionView setCollectionViewLayout:flowLayout animated:YES];
    [flowLayout release];
//    [contentCollectionView setContentOffset:CGPointZero animated:YES];
}

- (IBAction)action2:(id)sender {
    //切换到自定义布局
    CustomLayout *layout = [[CustomLayout alloc] init];
    [contentCollectionView setCollectionViewLayout:layout animated:YES];
    [layout release];
}

- (IBAction)action3:(id)sender {
    //与每个section轮流发生插入动作
    static int section = 0;
    int item = 0;
    switch (section % 3) {
        case 0:
            item = num1++;
            break;
        case 1:
            item = num2++;
            break;
        case 2:
            item = num3++;
            break;
        default:
            break;
    }
    NSIndexPath *path = [NSIndexPath indexPathForItem:item inSection:section++ % 3];
    [contentCollectionView insertItemsAtIndexPaths:@[path]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [contentCollectionView release];
    [super dealloc];
}
@end
