//
//  SpecificLabelWithImage.m
//  DarkAvenger
//
//  Created by Thomas Mac on 12/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import "SpecificLabelWithImage.h"

@interface SpecificLabelWithImage()

@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation SpecificLabelWithImage

- (void) initialisationWithNameImage:(NSString *)image AndText:(NSString *)text
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.height, self.frame.size.height)];
    
    [self.imageView setImage:[UIImage imageNamed:image]];
    
    [self addSubview:self.imageView];
    
    [self setTextColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]];
    
    [self setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0]];
    
    [self setShadowColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
    
    [self setShadowOffset:CGSizeMake(0, 1)];
    
    [self setTextAlignment:NSTextAlignmentRight];
    
    [self setText:text];
}

@end
