//
//  VaisseauObject.h
//  DarkAvenger
//
//  Created by Thomas Mac on 06/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GestionnaireCollision.h"
#import "GameViewController.h"

@interface VaisseauObject : NSObject

@property(nonatomic) int nombreMissilesrestant;

@property(nonatomic) float degatsMissile;

@property(nonatomic) float degatsLaser;

@property(nonatomic) float vieRestante;

@property(nonatomic) BOOL IA;

@property(nonatomic, strong) NSString *className;

@property(nonatomic, strong) UIImageView *imageView;

#pragma init

- (void) initVaisseauPlayer:(NSUserDefaults *)sauvegarde InView:(UIView *)view WithGestionnaireCollision:(GestionnaireCollision *)gestionnaireCollision WithViewController:(GameViewController *)gameViewController;

- (void) initIAWithLevel:(int)level WithSauvegarde:(NSUserDefaults *)sauvegarde InView:(UIView *)view WithGestionnaireCollision:(GestionnaireCollision *)gestionnaireCollision WithViewController:(GameViewController *)gameViewController;

#pragma gestion laser et missile

- (void) tirerLaserInView:(UIView *)view;

- (void) tirerMissileInView:(UIView *)view;

#pragma gestion du vaisseau

- (void) subitDesDegats:(float)degats;

- (void) allDegats;

- (void) deallocVaisseau;

#pragma gestion des timers

- (void) stopAllTimers;

@end
