//
//  CADSampleCell.m
//  CADRACSwippableCell
//
//  Created by Joan Romano on 16/04/14.
//  Copyright (c) 2014 Crows And Dogs. All rights reserved.
//

#import "CADSampleCell.h"

@interface CADSampleCell ()



@end

@implementation CADSampleCell

- (UILabel *)textLabel
{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_textLabel];
    }
    
    return _textLabel;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        //这里一定要设置一个颜色
        self.backgroundColor = [UIColor yellowColor];
        [self textLabel];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = self.bounds;
}

- (void)fillWithObject:(id)object
{
    self.textLabel.text = object;
}


@end
