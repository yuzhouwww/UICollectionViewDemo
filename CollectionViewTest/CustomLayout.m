//
//  CustomLayout.m
//  CollectionViewTest
//
//  Created by yuzhou on 13-7-5.
//  Copyright (c) 2013年 wzyk. All rights reserved.
//

#import "CustomLayout.h"
#import <QuartzCore/QuartzCore.h>

@interface CustomLayout ()

@property (nonatomic,retain) NSMutableArray *insertArray;

@end

@implementation CustomLayout

- (CGSize)collectionViewContentSize
{
    return self.collectionView.bounds.size;
}

- (void)prepareLayout
{
    self.insertArray = [NSMutableArray array];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = CGSizeMake(80, 80);
    attributes.center = CGPointMake(indexPath.section * 100 + 50, 50);
    //只显示最后三个item
    if (indexPath.item < [self.collectionView numberOfItemsInSection:indexPath.section] - 3) {
        attributes.alpha = 0.0;
        return attributes;
    }
    //旋转一定的角度
    float angle = ([self.collectionView numberOfItemsInSection:indexPath.section] - indexPath.item - 1)/4.0*M_PI/6;
    attributes.transform3D = CATransform3DMakeRotation(angle, 0, 0, 1);
    attributes.zIndex = 0;
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //这里偷懒了直接返回所有item的layoutAttributes
    NSMutableArray *array = [NSMutableArray array];
    for (int section = 0; section < self.collectionView.numberOfSections; section++) {
        for (int item = 0; item < [self.collectionView numberOfItemsInSection:section]; item++) {
            NSIndexPath *path = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:path];
            [array addObject:attributes];
        }
    }
    return array;
}

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    //每次插入，删除，移动都会调用这个方法，这里把要插入的item记录下来，为下面的插入效果做准备
    [super prepareForCollectionViewUpdates:updateItems];
    for (UICollectionViewUpdateItem *updateItem in updateItems) {
        if (updateItem.updateAction == UICollectionUpdateActionInsert) {
            [self.insertArray addObject:updateItem.indexPathAfterUpdate];
        }
    }
}

- (void)finalizeCollectionViewUpdates
{
    //每次插入，删除，移动结束后都会调用这个方法
    [self.insertArray removeAllObjects];
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    //这个方法告知每个item刚出来时的初始布局
    //layoutAttributesForItemAtIndexPath:返回的是最终布局，初始和最终布局之间会有动画效果，这里用来做插入效果
    //对要插入的item做不同的设置
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    if ([self.insertArray containsObject:itemIndexPath]) {
        attributes.center = CGPointMake(160, 300);
    }
    return attributes;
}

- (void)dealloc
{
    [self.insertArray release];
    [super dealloc];
}

@end
