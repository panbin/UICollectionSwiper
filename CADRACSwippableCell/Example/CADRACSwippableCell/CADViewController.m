//
//  CADViewController.m
//  CADRACSwippableCell
//
//  Created by Joan Romano on 16/04/14.
//  Copyright (c) 2014 Crows And Dogs. All rights reserved.
//

#import "CADViewController.h"

#import "CADSampleCell.h"
#import <ReactiveCocoa/RACSignal+Operations.h>

static NSString *const kReuseIdentifier = @"ReuseIdentifier";

@interface CADViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //        //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为100*100
    layout.itemSize = CGSizeMake(320, 100);
    layout.minimumLineSpacing = 5;
    
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    //        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor redColor];
    ////        _collectionView.showsVerticalScrollIndicator = NO;
    ////        _collectionView.showsHorizontalScrollIndicator = NO;
    ////
    ////
    [_collectionView registerClass:[CADSampleCell class]
        forCellWithReuseIdentifier:kReuseIdentifier];
    [self.view addSubview:_collectionView];
    
    
    [_collectionView registerClass:[CADSampleCell class] forCellWithReuseIdentifier:kReuseIdentifier];
    
//    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(CADSampleCell.class) bundle:nil] forCellWithReuseIdentifier:kReuseIdentifier];
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CADSampleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = (CGRect){
        .size = CGSizeMake(CGRectGetWidth(collectionView.bounds)/2, CGRectGetHeight(cell.bounds))
    };
    
    cell.allowedDirection = arc4random_uniform(2);
    cell.revealView = bottomView;
    cell.textLabel.text = cell.allowedDirection == CADRACSwippableCellAllowedDirectionRight ? @"Right" : @"Left";
    [[cell.revealViewSignal filter:^BOOL(NSNumber *isRevealed) {
        return [isRevealed boolValue];
    }] subscribeNext:^(id x) {
        [[self.collectionView visibleCells] enumerateObjectsUsingBlock:^(CADSampleCell *otherCell, NSUInteger idx, BOOL *stop) {
            if (otherCell != cell)
            {
                [otherCell hideRevealViewAnimated:YES];
            }
        }];
    }];
    
    bottomView.backgroundColor = cell.allowedDirection == CADRACSwippableCellAllowedDirectionRight ? [UIColor redColor] : [UIColor blueColor];
    
    return cell;
}

@end
