//
//  AsteroideObject.m
//  DarkAvenger
//
//  Created by Thomas Mac on 06/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import "AsteroideObject.h"

#import "GestionnaireCollision.h"

#import "GestionnaireAnimationAsteroide.h"

@interface AsteroideObject()

@property(nonatomic) float vieRestante;

@property(nonatomic) int type;

@property(nonatomic, strong) NSTimer *timerAnimation;

@property(nonatomic, strong) GameViewController *gameViewController;

@property(nonatomic, strong) GestionnaireAnimationAsteroide *gestionnaireAnimationAsteroide;

@end

@implementation AsteroideObject

#pragma init

- (void) initWithType:(int)type WithPositionX:(float)x WithPositionY:(float)y InView:(UIView *)view WithGestionnaireCollision:(GestionnaireCollision *)gestionnaireCollision WithViewController:(GameViewController *)gameViewController WithGestionnaireAnimationAsteroide:(GestionnaireAnimationAsteroide *)gestionnaireAnimationAsteroide
{
    //222x248 - 148x165 - 111x124 - 74-83 - 55.5x62 - 44.4x49.6
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"IMAGE_NAME_ASTEROID", @"IMAGE_NAME_ASTEROID")]];
    
    self.type = type;
    
    self.inGestionnaireCollision = NO;
    
    self.vitesseX = 0.0;
    
    self.className = @"AsteroideObject";
    
    self.gestionnaireCollision = gestionnaireCollision;
    
    self.gameViewController = gameViewController;
    
    self.gestionnaireAnimationAsteroide = gestionnaireAnimationAsteroide;
    
    if (type == 1)
    {
        [self.imageView setFrame:CGRectMake(x, y, 44.4f, 49.6f)];
        
        self.vieRestante = 1;
        
        self.degats = 0.5;
        
        self.vitesseY = 0.4;
    }
    
    else if (type == 2)
    {
        [self.imageView setFrame:CGRectMake(x, y, 55.5f, 62.0f)];
        
        self.vieRestante = 2;
        
        self.degats = 1;
        
        self.vitesseY = 0.4;
    }
    
    else if (type == 3)
    {
        [self.imageView setFrame:CGRectMake(x, y, 74.0f, 83.0f)];
        
        self.vieRestante = 3;
        
        self.degats = 2;
        
        self.vitesseY = 0.3;
    }
    
    else if (type == 4)
    {
        [self.imageView setFrame:CGRectMake(x, y, 111.0f, 124.0f)];
        
        self.vieRestante = 5;
        
        self.degats = 3;
        
        self.vitesseY = 0.2;
    }
    
    else if (type == 5)
    {
        [self.imageView setFrame:CGRectMake(x, y, 148.0f, 165.0f)];
        
        self.vieRestante = 5;
        
        self.degats = 4;
        
        self.vitesseY = 0.2;
    }
    
    [view addSubview:self.imageView];
    
    //[self.gestionnaireCollision addObject:self WithClassName:self.className WithImageView:self.imageView];
    
    //self.timerAnimation = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(animationAsteroide) userInfo:nil repeats:YES];
}

#pragma gestion animation
/*
- (void) animationAsteroide
{
    [self.imageView setFrame:CGRectMake(self.imageView.frame.origin.x + self.vitesseX, self.imageView.frame.origin.y + self.vitesseY, self.imageView.frame.size.width, self.imageView.frame.size.height)];
    
    CGRect frameView = [[UIScreen mainScreen] bounds];
    
    if (self.imageView.frame.origin.y >= frameView.size.height)
    {
        [self removeAsteroide];
    }
}
*/
#pragma gestion asteroide

- (void) subitDesDegats:(float)degats
{
    self.vieRestante = self.vieRestante - degats;
    
    if (self.vieRestante <= 0)
    {
        [self.gameViewController ennemisKilled];
        
        int xpRecompense[5] = {1, 2, 4, 7, 10};
        
        self.gameViewController.xpEnnemisKilled = self.gameViewController.xpEnnemisKilled + xpRecompense[self.type - 1];
        
        [self destructionAsteroide];
    }
}

- (void) destructionAsteroide
{
    //[self.timerAnimation invalidate];
    
    [self.gestionnaireCollision removeObject:self];
    
    [self.gestionnaireAnimationAsteroide removeAsteroide:self];
    
    [self.imageView setImage:[UIImage imageNamed:NSLocalizedString(@"IMAGE_NAME_EXPLOSION", @"IMAGE_NAME_EXPLOSION")]];
    
    self.timerAnimation = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(removeAsteroide) userInfo:nil repeats:YES];
}

- (void) removeAsteroide
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
