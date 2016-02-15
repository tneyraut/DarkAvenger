//
//  MissileObject.m
//  DarkAvenger
//
//  Created by Thomas Mac on 06/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import "MissileObject.h"

@interface MissileObject()

@property(nonatomic) float vitesse;

@property(nonatomic, strong) NSTimer *timerAnimation;

@property(nonatomic, strong) GestionnaireCollision *gestionnaireCollision;

@end

@implementation MissileObject

#pragma init

- (void) initialisationMissileWithDegats:(float)degats WithPositionX:(float)x WithPositionY:(float)y FromIA:(BOOL)IA InView:(UIView *)view WithGestionnaireCollision:(GestionnaireCollision *)gestionnaireCollision
{
    self.degats = degats;
    
    self.className = @"MissileObject";
    
    self.vitesse = 1.0;
    
    self.IA = IA;
    
    self.gestionnaireCollision = gestionnaireCollision;
    
    //217.17x823.7 - 31x118 - 22x82
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, 22.0f, 82.0f)];
    
    if (self.IA)
    {
        [self.imageView setImage:[UIImage imageNamed:NSLocalizedString(@"IMAGE_NAME_MISSILE_IA", @"IMAGE_NAME_MISSILE_IA")]];
    }
    else
    {
        [self.imageView setImage:[UIImage imageNamed:NSLocalizedString(@"IMAGE_NAME_MISSILE", @"IMAGE_NAME_MISSILE")]];
    }
    
    [view addSubview:self.imageView];
    
    [self.gestionnaireCollision addObject:self WithClassName:self.className WithImageView:self.imageView];
    
    self.timerAnimation = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(animationMissile) userInfo:nil repeats:YES];
}

#pragma gestion animation

- (void) animationMissile
{
    CGRect viewFrame = [[UIScreen mainScreen] bounds];
    
    if (self.IA)
    {
        [self.imageView setFrame:CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y + self.vitesse, self.imageView.frame.size.width, self.imageView.frame.size.height)];
        
        if (self.imageView.frame.origin.y >= viewFrame.size.height)
        {
            
            [self removeMissile];
        }
    }
    else
    {
        [self.imageView setFrame:CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y - self.vitesse, self.imageView.frame.size.width, self.imageView.frame.size.height)];
        
        if (self.imageView.frame.origin.y <= -self.imageView.frame.size.height)
        {
            [self removeMissile];
        }
    }
}

#pragma gestion missile

- (void) destructionMissile
{
    [self.timerAnimation invalidate];
    
    [self.gestionnaireCollision removeObject:self];
    
    [self.imageView setFrame:CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, 40.0f, 40.0f)];
    
    [self.imageView setImage:[UIImage imageNamed:NSLocalizedString(@"IMAGE_NAME_EXPLOSION", @"IMAGE_NAME_EXPLOSION")]];
    
    self.timerAnimation = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(removeMissile) userInfo:nil repeats:YES];
}

- (void) removeMissile
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
