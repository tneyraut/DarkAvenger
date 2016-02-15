//
//  MissileObject.h
//  DarkAvenger
//
//  Created by Thomas Mac on 06/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GestionnaireCollision.h"

@interface MissileObject : NSObject

@property(nonatomic, strong) NSString *className;

@property(nonatomic) float degats;

@property(nonatomic) BOOL IA;

@property(nonatomic, strong) UIImageView *imageView;

#pragma init

- (void) initialisationMissileWithDegats:(float)degats WithPositionX:(float)x WithPositionY:(float)y FromIA:(BOOL)IA InView:(UIView *)view WithGestionnaireCollision:(GestionnaireCollision *)gestionnaireCollision;

#pragma gestion missile

- (void) destructionMissile;

- (void) removeMissile;

@end
