//
//  FMFilterCollectionViewController.m
//  Thousand Words
//
//  Created by Fredrick Myers on 3/4/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMFilterCollectionViewController.h"
#import "FMPhotoCollectionViewCell.h"
#import "Photo.h"
#define SATURATION_KEY_VALUE @0.5
#define GAUSSIANB_BLUR_RADIUS @1

@interface FMFilterCollectionViewController ()

@property (strong, nonatomic) NSMutableArray *filters;
@property (strong, nonatomic) CIContext *context;

@end

@implementation FMFilterCollectionViewController

- (NSMutableArray *)filters
{
    if (!_filters)
    {
        _filters = [[NSMutableArray alloc] init];
    }
    return _filters;
}

- (CIContext *)context
{
    if (!_context) {
        _context = [CIContext contextWithOptions:nil];
    }
    return _context;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.filters = [[[self class] PhotoFilters] mutableCopy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark - CollectioView DataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Photo Cell";
    FMPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageView.image = [self filteredImageFromImage:self.photo.image andFiler:self.filters[indexPath.row]];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.filters count];
}

#pragma mark - CollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FMPhotoCollectionViewCell *selectedCell = (FMPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.photo.image = selectedCell.imageView.image;
    
    NSError *error = nil;
    
    if (![[self.photo managedObjectContext] save:&error])
    {
        NSLog(@"%@", error);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Helper Methods

+ (NSArray *)PhotoFilters
{
    CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:nil];
    CIFilter *blur = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputRadiusKey, GAUSSIANB_BLUR_RADIUS, nil];
    CIFilter *colorClamp = [CIFilter filterWithName:@"CIColorClamp" keysAndValues:@"inputMaxComponents",
                            [CIVector vectorWithX:0.9 Y:0.9 Z:0.9 W:0.9], @"inputMinComponents",
                            [CIVector vectorWithX:0.2 Y:0.2 Z:0.2 W:0.2], nil];
    CIFilter *instant = [CIFilter filterWithName:@"CIPhotoEffectInstant" keysAndValues: nil];
    CIFilter *noir = [CIFilter filterWithName:@"CIPhotoEffectNoir" keysAndValues: nil];
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignetteEffect" keysAndValues: nil];
    CIFilter *colorControls = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputSaturationKey, SATURATION_KEY_VALUE, nil];
    CIFilter *transfer = [CIFilter filterWithName:@"CIPhotoEffectTransfer" keysAndValues: nil];
    CIFilter *unsharpen = [CIFilter filterWithName:@"CIUnsharpMask" keysAndValues: nil];
    CIFilter *monochrome = [CIFilter filterWithName:@"CIColorControls" keysAndValues: nil];
    
    NSArray *allFilers = @[sepia, blur, colorClamp, instant, noir, vignette, colorControls, transfer, unsharpen, monochrome];
    return allFilers;
}

- (UIImage *)filteredImageFromImage:(UIImage *)image andFiler:(CIFilter *)filter
{
    CIImage *unfilteredImage = [[CIImage alloc] initWithCGImage:image.CGImage];
    [filter setValue:unfilteredImage forKey:kCIInputImageKey];
    CIImage *filteredImage = [filter outputImage];
    
    CGRect extent = [filteredImage extent];
    
    CGImageRef cgImage = [self.context createCGImage:filteredImage fromRect:extent];
    
    UIImage *finalImage = [UIImage imageWithCGImage:cgImage];
    
    return finalImage;
}

@end
