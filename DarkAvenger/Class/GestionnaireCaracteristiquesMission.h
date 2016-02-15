//
//  GestionnaireCaracteristiquesMission.h
//  DarkAvenger
//
//  Created by Thomas Mac on 09/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GestionnaireCaracteristiquesMission : NSObject

+ (void) setAllCaracteristiquesMission:(NSUserDefaults *)sauvegarde WithLevel:(int)level;

+ (int) getRecompenseXPMissionWithLevel:(int)level;

+ (int) getRecompenseCoinsMissionWithLevel:(int)level;

@end
