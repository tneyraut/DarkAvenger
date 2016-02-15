//
//  LaserObject.h
//  DarkAvenger
//
//  Created by Thomas Mac on 06/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GestionnaireCollision.h"

@interface LaserObject : NSObject

@property(nonatomic, strong) NSString *className;

@property(nonatomic) float degats;

@property(nonatomic) BOOL IA;

@property(nonatomic, strong) UIImageView *imageView;

#pragma init

- (void) initialisationLaserWithDegats:(float)degats WithPositionX:(float)x WithPositionY:(float)y InView:(UIView *)view FromIA:(BOOL)IA WithGestionnaireCollision:(GestionnaireCollision *)gestionnaireCollision;

#pragma gestion laser

- (void) destructionLaser;

- (void) removeLaser;

@end
