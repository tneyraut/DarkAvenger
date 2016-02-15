//
//  LaserObject.m
//  DarkAvenger
//
//  Created by Thomas Mac on 06/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import "LaserObject.h"

@interface LaserObject()

@property(nonatomic) float vitesse;

@property(nonatomic, strong) NSTimer *timerAnimation;

@property(nonatomic, strong) GestionnaireCollision *gestionnaireCollision;

@end

@implementation LaserObject

#pragma init

- (void) initialisationLaserWithDegats:(float)degats WithPositionX:(float)x WithPositionY:(float)y InView:(UIView *)view FromIA:(BOOL)IA WithGestionnaireCollision:(GestionnaireCollision *)gestionnaireCollision
{
    self.degats = degats;
    
    self.className = @"LaserObject";
    
    self.vitesse = 0.5;
    
    self.IA = IA;
    
    self.gestionnaireCollision = gestionnaireCollision;
    
    //78x246 - 19.5x61.5 - 12x38
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, 5.0f, 40.0f)];
    
    if (self.IA)
    {
        [self.imageView setImage:[UIImage imageNamed:NSLocalizedString(@"IMAGE_NAME_LASER_IA", @"IMAGE_NAME_LASER_IA")]];
    }
    else
    {
        [self.imageView setImage:[UIImage imageNamed:NSLocalizedString(@"IMAGE_NAME_LASER", @"IMAGE_NAME_LASER")]];
    }
    
    [view addSubview:self.imageView];
    
    [self.gestionnaireCollision addObject:self WithClassName:self.className WithImageView:self.imageView];
    
    self.timerAnimation = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(animationLaser) userInfo:nil repeats:YES];
}

#pragma gestion animation

- (void) animationLaser
{
    CGRect viewFrame = [[UIScreen mainScreen] bounds];
    
    if (self.IA)
    {
        [self.imageView setFrame:CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y + self.vitesse, self.imageView.frame.size.width, self.imageView.frame.size.height)];
        
        if (self.imageView.frame.origin.y >= viewFrame.size.height)
        {
            
            [self removeLaser];
        }
    }
    else
    {
        [self.imageView setFrame:CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y - self.vitesse, self.imageView.frame.size.width, self.imageView.frame.size.height)];
        
        if (self.imageView.frame.origin.y <= -self.imageView.frame.size.height)
        {
            [self removeLaser];
        }
    }
}

#pragma gestion laser

- (void) destructionLaser
{
    [self.timerAnimation invalidate];
    
    [self.gestionnaireCollision removeObject:self];
    
    [self.imageView setFrame:CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, 20.0f, 20.0f)];
    
    [self.imageView setImage:[UIImage imageNamed:NSLocalizedString(@"IMAGE_NAME_EXPLOSION", @"IMAGE_NAME_EXPLOSION")]];
    
    self.timerAnimation = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(removeLaser) userInfo:nil repeats:YES];
}

- (void) removeLaser
{
    [self.timerAnimation invalidate];
    
    [self.imageView setHidden:YES];
    
    [self.imageView removeFromSuperview];
    
    self.timerAnimation = nil;
    
    self.imageView = nil;
    
    self.className = nil;
    
    self.gestionnaireCollision = nil;
}

@end
