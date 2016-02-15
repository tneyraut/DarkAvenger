//
//  GestionnaireCaracteristiquesVaisseau.h
//  DarkAvenger
//
//  Created by Thomas Mac on 07/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GestionnaireCaracteristiquesVaisseau : NSObject

+ (void) initialisationCaracteristiquesVaisseau:(NSUserDefaults *)sauvegarde;

+ (void) setAllAmeliorations:(NSUserDefaults *)sauvegarde;

+ (BOOL) reparationVaisseau:(NSUserDefaults *)sauvegarde;

+ (BOOL) ameliorationCoque:(NSUserDefaults *)sauvegarde;

+ (BOOL) ameliorationBouclier:(NSUserDefaults *)sauvegarde;

+ (BOOL) ameliorationCapaciteMissile:(NSUserDefaults *)sauvegarde;

+ (BOOL) ameliorationDegatsMissile:(NSUserDefaults *)sauvegarde;

+ (BOOL) ameliorationTempsRechargementMissile:(NSUserDefaults *)sauvegarde;

+ (BOOL) achatMissile:(NSUserDefaults *)sauvegarde;

+ (BOOL) ameliorationDegatsLaser:(NSUserDefaults *)sauvegarde;

+ (BOOL) ameliorationTempsRechargementLaser:(NSUserDefaults *)sauvegarde;

+ (BOOL) ameliorationTempsRechargementBouclier:(NSUserDefaults *)sauvegarde;

+ (void) levelUP:(NSUserDefaults *)sauvegarde;

@end
