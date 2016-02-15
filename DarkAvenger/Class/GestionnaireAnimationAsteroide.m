//
//  GestionnaireAnimationAsteroide.m
//  DarkAvenger
//
//  Created by Thomas Mac on 02/09/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import "GestionnaireAnimationAsteroide.h"

#import "GestionnaireCollision.h"

@interface GestionnaireAnimationAsteroide()

@property(nonatomic, strong) NSMutableArray *asteroidesArray;

@property(nonatomic, strong) NSTimer *timerAnimation;

@end

@implementation GestionnaireAnimationAsteroide

#pragma initialisation

- (void)initialisation
{
    self.asteroidesArray = [[NSMutableArray alloc] init];
}

#pragma gestion object

- (void) addAsteroide:(AsteroideObject *)asteroide
{
    [self.asteroidesArray addObject:asteroide];
    
    [self startAnimationAsteroide];
}

- (void) removeAsteroide:(AsteroideObject *)asteroide
{
    for (int i=0;i<self.asteroidesArray.count;i++)
    {
        AsteroideObject *asteroideObject = self.asteroidesArray[i];
        if ([asteroideObject isEqual:asteroide])
        {
            [self.asteroidesArray removeObjectAtIndex:i];
            return;
        }
    }
}

- (void) removeGestionnaireAnimationAsteroide
{
    [self.timerAnimation invalidate];
    
    [self.asteroidesArray removeAllObjects];
    
    self.timerAnimation = nil;
    
    self.asteroidesArray = nil;
}

#pragma gestion des animations

- (void)startAnimationAsteroide
{
    if (![self.timerAnimation isValid])
    {
        self.timerAnimation = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(asteroideAnimation) userInfo:nil repeats:YES];
    }
}

- (void) asteroideAnimation
{
    for (int i=0;i<self.asteroidesArray.count;i++)
    {
        AsteroideObject *asteroide = self.asteroidesArray[i];
        
        [asteroide.imageView setFrame:CGRectMake(asteroide.imageView.frame.origin.x + asteroide.vitesseX, asteroide.imageView.frame.origin.y + asteroide.vitesseY, asteroide.imageView.frame.size.width, asteroide.imageView.frame.size.height)];
        
        CGRect frameView = [[UIScreen mainScreen] bounds];
        
        if (!asteroide.inGestionnaireCollision && asteroide.imageView.frame.origin.y >= 0)
        {
            asteroide.inGestionnaireCollision = YES;
            
            [asteroide.gestionnaireCollision addObject:asteroide WithClassName:asteroide.className WithImageView:asteroide.imageView];
        }
        
        if (asteroide.imageView.frame.origin.y >= frameView.size.height)
        {
            [asteroide destructionAsteroide];
        }
    }
}

@end
