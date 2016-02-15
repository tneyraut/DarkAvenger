//
//  GestionnaireCollision.m
//  DarkAvenger
//
//  Created by Thomas Mac on 09/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import "GestionnaireCollision.h"

#import "LaserObject.h"
#import "VaisseauObject.h"
#import "MissileObject.h"
#import "AsteroideObject.h"

@interface GestionnaireCollision()

@property(nonatomic, weak) GestionnaireAnimationAsteroide *gestionnaireAnimationAsteroide;

@property(nonatomic, strong) NSMutableArray *objectArray;

@property(nonatomic, strong) NSMutableArray *classNameArray;

@property(nonatomic, strong) NSMutableArray *imageViewArray;

@property(nonatomic, strong) NSTimer *timerVerificationCollision;

@end

@implementation GestionnaireCollision

#pragma initialisation

- (void) initialisationWithGestionnaireAnimationAsteroide:(GestionnaireAnimationAsteroide *)gestionnaireAnimationAsteroide
{
    self.gestionnaireAnimationAsteroide = gestionnaireAnimationAsteroide;
    
    self.objectArray = [[NSMutableArray alloc] init];
    
    self.classNameArray = [[NSMutableArray alloc] init];
    
    self.imageViewArray = [[NSMutableArray alloc] init];
}

#pragma gestion object

- (void) addObject:(NSObject *)object WithClassName:(NSString *)className WithImageView:(UIImageView *)imageView
{
    [self.objectArray addObject:object];
    
    [self.classNameArray addObject:className];
    
    [self.imageViewArray addObject:imageView];
}

- (void) removeObject:(NSObject *)object
{
    int indice = -1;
    
    for (int i=0; i<self.objectArray.count; i++) {
        if ([object isEqual:self.objectArray[i]])
        {
            indice = i;
        }
    }
    
    if (indice != -1)
    {
        [self.objectArray removeObjectAtIndex:indice];
        
        [self.classNameArray removeObjectAtIndex:indice];
        
        [self.imageViewArray removeObjectAtIndex:indice];
    }
}

- (void) removeGestionnaireCollision
{
    [self.timerVerificationCollision invalidate];
    
    for (int i=0;i<self.objectArray.count;i++)
    {
        if ([self.classNameArray[i] isEqualToString:@"VaisseauObject"])
        {
            VaisseauObject *vaisseauObject = self.objectArray[i];
            
            [vaisseauObject deallocVaisseau];
        }
        
        else if ([self.classNameArray[i] isEqualToString:@"AsteroideObject"])
        {
            AsteroideObject *asteroideObject = self.objectArray[i];
            
            [asteroideObject removeAsteroide];
        }
        
        else if ([self.classNameArray[i] isEqualToString:@"MissileObject"])
        {
            MissileObject *missileObject = self.objectArray[i];
            
            [missileObject removeMissile];
        }
        
        else if ([self.classNameArray[i] isEqualToString:@"LaserObject"])
        {
            LaserObject *laserObject = self.objectArray[i];
            
            [laserObject removeLaser];
        }
    }
    
    [self.objectArray removeAllObjects];
    
    [self.classNameArray removeAllObjects];
    
    [self.imageViewArray removeAllObjects];
    
    self.timerVerificationCollision = nil;
    
    self.objectArray = nil;
    
    self.classNameArray = nil;
    
    self.imageViewArray = nil;
}

#pragma gestion des collisions

- (void) startGestionCollisions
{
    if ([self.timerVerificationCollision isValid])
    {
        return;
    }
    
    self.timerVerificationCollision = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(gestionCollisions) userInfo:nil repeats:YES];
}

- (void) gestionCollisions
{
    for (int i=0;i<[self.imageViewArray count];i++)
    {
        for (int j=(i + 1); j<[self.imageViewArray count]; j++)
        {
            if ([self collisionBetween:self.imageViewArray[i] And:self.imageViewArray[j]])
            {
                [self collisionEffectBetweenIndice:i And:j];
            }
        }
    }
}

- (BOOL) collisionBetween:(UIImageView *)firstImageView And:(UIImageView *)secondImageView
{
    return (firstImageView.frame.origin.x <= secondImageView.frame.origin.x
            && secondImageView.frame.origin.x <= (firstImageView.frame.origin.x + firstImageView.frame.size.width)
            && firstImageView.frame.origin.y <= secondImageView.frame.origin.y
            && secondImageView.frame.origin.y <= (firstImageView.frame.origin.y + firstImageView.frame.size.height))
    || (secondImageView.frame.origin.x <= firstImageView.frame.origin.x
        && firstImageView.frame.origin.x <= (secondImageView.frame.origin.x + secondImageView.frame.size.width)
        && secondImageView.frame.origin.y <= firstImageView.frame.origin.y
        && firstImageView.frame.origin.y <= (secondImageView.frame.origin.y + secondImageView.frame.size.height))
    || (firstImageView.frame.origin.x <= secondImageView.frame.origin.x
        && secondImageView.frame.origin.x <= (firstImageView.frame.origin.x + firstImageView.frame.size.width)
        && firstImageView.frame.origin.y <= (secondImageView.frame.origin.y + secondImageView.frame.size.height)
        && (secondImageView.frame.origin.y + secondImageView.frame.size.height) <= (firstImageView.frame.origin.y + firstImageView.frame.size.height))
    || (secondImageView.frame.origin.x <= firstImageView.frame.origin.x
        && firstImageView.frame.origin.x <= (secondImageView.frame.origin.x + secondImageView.frame.size.width)
        && secondImageView.frame.origin.y <= (firstImageView.frame.origin.y + firstImageView.frame.size.height)
        && (firstImageView.frame.origin.y + firstImageView.frame.size.height) <= (secondImageView.frame.origin.y + secondImageView.frame.size.height));
}

- (void) collisionEffectBetweenIndice:(int)firstIndice And:(int)secondIndice
{
    NSString *firstClassName = self.classNameArray[firstIndice];
    
    NSString *secondClassName = self.classNameArray[secondIndice];
    
    if ([firstClassName isEqualToString:@"VaisseauObject"] && [secondClassName isEqualToString:@"VaisseauObject"])
    {
        VaisseauObject *firstObjectVaisseau = self.objectArray[firstIndice];
        
        VaisseauObject *secondObjectVaisseau = self.objectArray[secondIndice];
        
        if (!firstObjectVaisseau.IA)
        {
            [firstObjectVaisseau allDegats];
        }
        else
        {
            [secondObjectVaisseau allDegats];
        }
    }
    
    else if ([firstClassName isEqualToString:@"VaisseauObject"] && [secondClassName isEqualToString:@"AsteroideObject"])
    {
        VaisseauObject *firstObjectVaisseau = self.objectArray[firstIndice];
        
        AsteroideObject *secondObjectAsteroide = self.objectArray[secondIndice];
        
        [secondObjectAsteroide destructionAsteroide];
        
        [firstObjectVaisseau subitDesDegats:secondObjectAsteroide.degats];
    }
    
    else if ([firstClassName isEqualToString:@"VaisseauObject"] && [secondClassName isEqualToString:@"MissileObject"])
    {
        VaisseauObject *firstObjectVaisseau = self.objectArray[firstIndice];
        
        MissileObject *secondObjectMissile = self.objectArray[secondIndice];
        
        if ((firstObjectVaisseau.IA && !secondObjectMissile.IA) || (!firstObjectVaisseau.IA && secondObjectMissile.IA))
        {
            [secondObjectMissile destructionMissile];
            
            [firstObjectVaisseau subitDesDegats:secondObjectMissile.degats];
        }
    }
    
    else if ([firstClassName isEqualToString:@"VaisseauObject"] && [secondClassName isEqualToString:@"LaserObject"])
    {
        VaisseauObject *firstObjectVaisseau = self.objectArray[firstIndice];
        
        LaserObject *secondObjectLaser = self.objectArray[secondIndice];
        
        if ((firstObjectVaisseau.IA && !secondObjectLaser.IA) || (!firstObjectVaisseau.IA && secondObjectLaser.IA))
        {
            [secondObjectLaser destructionLaser];
            
            [firstObjectVaisseau subitDesDegats:secondObjectLaser.degats];
        }
    }
    
    else if ([firstClassName isEqualToString:@"AsteroideObject"] && [secondClassName isEqualToString:@"LaserObject"])
    {
        AsteroideObject *firstObjectAsteroide = self.objectArray[firstIndice];
        
        LaserObject *secondObjectLaser = self.objectArray[secondIndice];
        
        [secondObjectLaser destructionLaser];
        
        [firstObjectAsteroide subitDesDegats:secondObjectLaser.degats];
    }
    
    else if ([firstClassName isEqualToString:@"AsteroideObject"] && [secondClassName isEqualToString:@"MissileObject"])
    {
        AsteroideObject *firstObjectAsteroide = self.objectArray[firstIndice];
        
        MissileObject *secondObjectMissile = self.objectArray[secondIndice];
        
        [secondObjectMissile destructionMissile];
        
        [firstObjectAsteroide subitDesDegats:secondObjectMissile.degats];
    }
    
    else if ([firstClassName isEqualToString:@"AsteroideObject"] && [secondClassName isEqualToString:@"VaisseauObject"])
    {
        AsteroideObject *firstObjectAsteroide = self.objectArray[firstIndice];
        
        VaisseauObject *secondObjectVaisseau = self.objectArray[secondIndice];
        
        [firstObjectAsteroide destructionAsteroide];
        
        [secondObjectVaisseau subitDesDegats:firstObjectAsteroide.degats];
    }
    
    else if ([firstClassName isEqualToString:@"MissileObject"] && [secondClassName isEqualToString:@"VaisseauObject"])
    {
        MissileObject *firstObjectMissile = self.objectArray[firstIndice];
        
        VaisseauObject *secondObjectVaisseau = self.objectArray[secondIndice];
        
        if ((firstObjectMissile.IA && !secondObjectVaisseau.IA) || (!firstObjectMissile.IA && secondObjectVaisseau.IA))
        {
            [firstObjectMissile destructionMissile];
            
            [secondObjectVaisseau subitDesDegats:firstObjectMissile.degats];
        }
    }
    
    else if ([firstClassName isEqualToString:@"LaserObject"] && [secondClassName isEqualToString:@"VaisseauObject"])
    {
        LaserObject *firstObjectLaser = self.objectArray[firstIndice];
        
        VaisseauObject *secondObjectVaisseau = self.objectArray[secondIndice];
        
        if ((firstObjectLaser.IA && !secondObjectVaisseau.IA) || (!firstObjectLaser.IA && secondObjectVaisseau.IA))
        {
            [firstObjectLaser destructionLaser];
            
            [secondObjectVaisseau subitDesDegats:firstObjectLaser.degats];
        }
    }
    
    else if ([firstClassName isEqualToString:@"LaserObject"] && [secondClassName isEqualToString:@"AsteroideObject"])
    {
        LaserObject *firstObjectLaser = self.objectArray[firstIndice];
        
        AsteroideObject *secondObjectAsteroide = self.objectArray[secondIndice];
        
        [firstObjectLaser destructionLaser];
        
        [secondObjectAsteroide subitDesDegats:firstObjectLaser.degats];
    }
    
    else if ([firstClassName isEqualToString:@"MissileObject"] && [secondClassName isEqualToString:@"AsteroideObject"])
    {
        MissileObject *firstObjectMissile = self.objectArray[firstIndice];
        
        AsteroideObject *secondObjectAsteroide = self.objectArray[secondIndice];
        
        [firstObjectMissile destructionMissile];
        
        [secondObjectAsteroide subitDesDegats:firstObjectMissile.degats];
    }
    
    /*else if ([firstClassName isEqualToString:@"AsteroideObject"] && [secondClassName isEqualToString:@"AsteroideObject"])
    {
        AsteroideObject *firstObjectAsteroide = self.objectArray[firstIndice];
        
        AsteroideObject *secondObjectAsteroide = self.objectArray[secondIndice];
        
        [firstObjectAsteroide subitDesDegats:secondObjectAsteroide.degats];
        
        [secondObjectAsteroide subitDesDegats:firstObjectAsteroide.degats];
    }
    
    else if ([firstClassName isEqualToString:@"LaserObject"] && [secondClassName isEqualToString:@"LaserObject"])
    {
        LaserObject *firstObjectLaser = self.objectArray[firstIndice];
        
        LaserObject *secondObjectLaser = self.objectArray[secondIndice];
        
        [firstObjectLaser destructionLaser];
        
        [secondObjectLaser destructionLaser];
    }
    
    else if ([firstClassName isEqualToString:@"LaserObject"] && [secondClassName isEqualToString:@"MissileObject"])
    {
        LaserObject *firstObjectLaser = self.objectArray[firstIndice];
        
        MissileObject *secondObjectMissile = self.objectArray[secondIndice];
        
        [firstObjectLaser destructionLaser];
        
        [secondObjectMissile destructionMissile];
    }
    
    else if ([firstClassName isEqualToString:@"MissileObject"] && [secondClassName isEqualToString:@"LaserObject"])
    {
        MissileObject *firstObjectMissile = self.objectArray[firstIndice];
        
        LaserObject *secondObjectLaser = self.objectArray[secondIndice];
        
        [firstObjectMissile destructionMissile];
        
        [secondObjectLaser destructionLaser];
    }
    
    else if ([firstClassName isEqualToString:@"MissileObject"] && [secondClassName isEqualToString:@"MissileObject"])
    {
        MissileObject *firstObjectMissile = self.objectArray[firstIndice];
        
        MissileObject *secondObjectMissile = self.objectArray[secondIndice];
        
        [firstObjectMissile destructionMissile];
        
        [secondObjectMissile destructionMissile];
    }*/
}

@end
