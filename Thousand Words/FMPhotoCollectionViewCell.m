//
//  FMPhotoCollectionViewCell.m
//  Thousand Words
//
//  Created by Fredrick Myers on 2/28/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMPhotoCollectionViewCell.h"
#define IMAGEVIEW_BORDER_LENGTH 5

@implementation FMPhotoCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, IMAGEVIEW_BORDER_LENGTH, IMAGEVIEW_BORDER_LENGTH)];
    [self.contentView addSubview:self.imageView];
}

@end
