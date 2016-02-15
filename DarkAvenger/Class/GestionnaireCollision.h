//
//  GestionnaireCollision.h
//  DarkAvenger
//
//  Created by Thomas Mac on 09/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GameViewController.h"

#import "GestionnaireAnimationAsteroide.h"

@interface GestionnaireCollision : NSObject

#pragma initialisation

- (void) initialisationWithGestionnaireAnimationAsteroide:(GestionnaireAnimationAsteroide *)gestionnaireAnimationAsteroide;

#pragma gestion object

- (void) addObject:(NSObject *)object WithClassName:(NSString *)className WithImageView:(UIImageView *)imageView;

- (void) removeObject:(NSObject *)object;

- (void) removeGestionnaireCollision;

#pragma gestion des collisions

- (void) startGestionCollisions;

@end
