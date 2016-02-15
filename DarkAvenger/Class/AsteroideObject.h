//
//  AsteroideObject.h
//  DarkAvenger
//
//  Created by Thomas Mac on 06/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GameViewController.h"

@class GestionnaireCollision;

@class GestionnaireAnimationAsteroide;

@interface AsteroideObject : NSObject

@property(nonatomic, strong) NSString *className;

@property(nonatomic) float degats;

@property(nonatomic) float vitesseX;

@property(nonatomic) float vitesseY;

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic) BOOL inGestionnaireCollision;

@property(nonatomic, strong) GestionnaireCollision *gestionnaireCollision;

#pragma init

- (void) initWithType:(int)type WithPositionX:(float)x WithPositionY:(float)y InView:(UIView *)view WithGestionnaireCollision:(GestionnaireCollision *)gestionnaireCollision WithViewController:(GameViewController *)gameViewController WithGestionnaireAnimationAsteroide:(GestionnaireAnimationAsteroide *)gestionnaireAnimationAsteroide;

#pragma gestion asteroide

- (void) subitDesDegats:(float)degats;

- (void) destructionAsteroide;

- (void) removeAsteroide;

@end
