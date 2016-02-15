//
//  GestionnaireCaracteristiquesVaisseau.m
//  DarkAvenger
//
//  Created by Thomas Mac on 07/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import "GestionnaireCaracteristiquesVaisseau.h"

@implementation GestionnaireCaracteristiquesVaisseau

+ (void) initialisationCaracteristiquesVaisseau:(NSUserDefaults *)sauvegarde
{
    [sauvegarde setObject:@"1"
                   forKey:NSLocalizedString(@"KEY_NAME_LEVEL", @"KEY_NAME_LEVEL")];
    
    [sauvegarde setObject:@"1000"
                   forKey:NSLocalizedString(@"KEY_NAME_XP_OBJECTIF", @"KEY_NAME_XP_OBJECTIF")];
    
    [sauvegarde setObject:@"100"
                   forKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")];
    
    [sauvegarde setObject:@"3"
                   forKey:NSLocalizedString(@"KEY_NAME_COQUE_ACTUELLE", @"KEY_NAME_COQUE_ACTUELLE")];
    
    [sauvegarde setObject:@"3"
                   forKey:NSLocalizedString(@"KEY_NAME_COQUE_CAPACITE", @"KEY_NAME_COQUE_CAPACITE")];
    
    [sauvegarde setObject:@"1"
                   forKey:NSLocalizedString(@"KEY_NAME_BOUCLIER_CAPACITE", @"KEY_NAME_BOUCLIER_CAPACITE")];
    
    [sauvegarde setObject:@"3"
                   forKey:NSLocalizedString(@"KEY_NAME_MISSILE_CAPACITE", @"KEY_NAME_MISSILE_CAPACITE")];
    
    [sauvegarde setObject:@"3"
                   forKey:NSLocalizedString(@"KEY_NAME_NOMBRE_MISSILE_RESTANT", @"KEY_NAME_NOMBRE_MISSILE_RESTANT")];
    
    [sauvegarde setObject:@"2"
                   forKey:NSLocalizedString(@"KEY_NAME_MISSILE_DEGATS", @"KEY_NAME_MISSILE_DEGATS")];
    
    [sauvegarde setObject:@"5"
                   forKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_MISSILE", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_MISSILE")];
    
    [sauvegarde setObject:@"0"
                   forKey:NSLocalizedString(@"KEY_NAME_XP_ACCUMULES", @"KEY_NAME_XP_ACCUMULES")];
    
    [sauvegarde setObject:@"100"
                   forKey:NSLocalizedString(@"KEY_NAME_RECOMPENSE_LEVEL_UP", @"KEY_NAME_RECOMPENSE_LEVEL_UP")];
    
    [sauvegarde setObject:@"1"
                   forKey:NSLocalizedString(@"KEY_NAME_LASER_DEGATS", @"KEY_NAME_LASER_DEGATS")];
    
    [sauvegarde setObject:@"1"
                   forKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_LASER", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_LASER")];
    
    [sauvegarde setObject:@"1"
                   forKey:NSLocalizedString(@"KEY_NAME_LAST_MISSION_NUMBER", @"KEY_NAME_LAST_MISSION_NUMBER")];
    
    [sauvegarde setObject:@"3"
                   forKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_BOUCLIER", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_BOUCLIER")];
    
    [sauvegarde synchronize];
}

+ (void) setAllAmeliorations:(NSUserDefaults *)sauvegarde
{
    int coutReparationVaisseau = 10 * ([[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COQUE_CAPACITE", @"KEY_NAME_COQUE_CAPACITE")] intValue] - [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COQUE_ACTUELLE", @"KEY_NAME_COQUE_ACTUELLE")] intValue]);
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", coutReparationVaisseau]
                   forKey:NSLocalizedString(@"KEY_NAME_COUT_REPARATION_VAISSEAU", @"KEY_NAME_COUT_REPARATION_VAISSEAU")];
    
    int coutAmeliorationCoque = 10 * ([[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COQUE_CAPACITE", @"KEY_NAME_COQUE_CAPACITE")] intValue] + 1);
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", coutAmeliorationCoque]
                   forKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_COQUE", @"KEY_NAME_COUT_AMELIORATION_COQUE")];
    
    [sauvegarde setObject:@"1"
                   forKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_COQUE", @"KEY_NAME_AMELIORATION_COQUE")];
    
    int coutAmeliorationBouclier = 100 * ([[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_BOUCLIER_CAPACITE", @"KEY_NAME_BOUCLIER_CAPACITE")] intValue] + 1);
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", coutAmeliorationBouclier]
                   forKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_BOUCLIER", @"KEY_NAME_COUT_AMELIORATION_BOUCLIER")];
    
    [sauvegarde setObject:@"1"
                   forKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_BOUCLIER", @"KEY_NAME_AMELIORATION_BOUCLIER")];
    
    int coutAmeliorationCapaciteMissile = 50 * ([[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_MISSILE_CAPACITE", @"KEY_NAME_MISSILE_CAPACITE")] intValue] + 1);
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", coutAmeliorationCapaciteMissile]
                   forKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_CAPACITE_MISSILE", @"KEY_NAME_COUT_AMELIORATION_CAPACITE_MISSILE")];
    
    [sauvegarde setObject:@"1"
                   forKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_CAPACITE_MISSILE", @"KEY_NAME_AMELIORATION_CAPACITE_MISSILE")];
    
    int coutAmeliorationDegatsMissile = 100 * ([[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_MISSILE_DEGATS", @"KEY_NAME_MISSILE_DEGATS")] floatValue] + 1);
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", coutAmeliorationDegatsMissile]
                   forKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_DEGATS_MISSILE", @"KEY_NAME_COUT_AMELIORATION_DEGATS_MISSILE")];
    
    [sauvegarde setObject:@"0.5"
                   forKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_DEGATS_MISSILE", @"KEY_NAME_AMELIORATION_DEGATS_MISSILE")];
    
    int coutAmeliorationTempsRechargementMissile = 100 * (1 + (5 - [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_MISSILE", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_MISSILE")] floatValue]) * 10);
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", coutAmeliorationTempsRechargementMissile]
                   forKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_MISSILE", @"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_MISSILE")];
    
    [sauvegarde setObject:@"0.1"
                   forKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_TEMPS_DE_RECHARGEMENT_MISSILE", @"KEY_NAME_AMELIORATION_TEMPS_DE_RECHARGEMENT_MISSILE")];
    
    [sauvegarde setObject:@"50"
                   forKey:NSLocalizedString(@"KEY_NAME_COUT_ACHAT_MISSILE", @"KEY_NAME_COUT_ACHAT_MISSILE")];
    
    int coutAmeliorationDegatsLaser = 100 * (2 + [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_LASER_DEGATS", @"KEY_NAME_LASER_DEGATS")] intValue]);
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", coutAmeliorationDegatsLaser]
                   forKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_DEGATS_LASER", @"KEY_NAME_COUT_AMELIORATION_DEGATS_LASER")];
    
    [sauvegarde setObject:@"0.25"
                   forKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_DEGATS_LASER", @"KEY_NAME_AMELIORATION_DEGATS_LASER")];
    
    int coutAmeliorationTempsRechargementLaser = 100 * (1 + (1 - [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_LASER", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_LASER")] intValue]) * 10);
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", coutAmeliorationTempsRechargementLaser]
                   forKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_LASER", @"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_LASER")];
    
    [sauvegarde setObject:@"0.1"
                   forKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_TEMPS_DE_RECHARGEMENT_LASER", @"KEY_NAME_AMELIORATION_TEMPS_DE_RECHARGEMENT_LASER")];
    
    int coutAmeliorationTempsRechargementBouclier = 100 * (1 + (3 - [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_BOUCLIER", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_BOUCLIER")] floatValue]) * 10);
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", coutAmeliorationTempsRechargementBouclier]
                   forKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_BOUCLIER", @"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_BOUCLIER")];
    
    [sauvegarde setObject:@"0.1"
                   forKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_TEMPS_DE_RECHARGEMENT_BOUCLIER", @"KEY_NAME_AMELIORATION_TEMPS_DE_RECHARGEMENT_BOUCLIER")];
    
    [sauvegarde synchronize];
}

+ (BOOL) reparationVaisseau:(NSUserDefaults *)sauvegarde
{
    int coins = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")] intValue];
    
    int coutReparationVaisseau = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_REPARATION_VAISSEAU", @"KEY_NAME_COUT_REPARATION_VAISSEAU")] intValue];
    
    if (coins < coutReparationVaisseau)
    {
        return NO;
    }
    
    //REVOIR... pour réparer un peu mais pas à fond...
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", (coins - coutReparationVaisseau)]
                   forKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")];
    
    [sauvegarde setObject:[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COQUE_CAPACITE", @"KEY_NAME_COQUE_CAPACITE")]
                   forKey:NSLocalizedString(@"KEY_NAME_COQUE_ACTUELLE", @"KEY_NAME_COQUE_ACTUELLE")];
    
    [sauvegarde synchronize];
    
    return YES;
}

+ (BOOL) ameliorationCoque:(NSUserDefaults *)sauvegarde
{
    int coins = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")] intValue];
    
    int coutAmeliorationCoque = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_COQUE", @"KEY_NAME_COUT_AMELIORATION_COQUE")] intValue];
    
    if (coins < coutAmeliorationCoque)
    {
        return NO;
    }
    
    int newCoqueCapacite = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COQUE_CAPACITE", @"KEY_NAME_COQUE_CAPACITE")] intValue] + [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_COQUE", @"KEY_NAME_AMELIORATION_COQUE")] intValue];
    
    int newCoqueStatus = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COQUE_ACTUELLE", @"KEY_NAME_COQUE_ACTUELLE")] intValue] + [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_COQUE", @"KEY_NAME_AMELIORATION_COQUE")] intValue];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", newCoqueCapacite]
                   forKey:NSLocalizedString(@"KEY_NAME_COQUE_CAPACITE", @"KEY_NAME_COQUE_CAPACITE")];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", newCoqueStatus]
                   forKey:NSLocalizedString(@"KEY_NAME_COQUE_ACTUELLE", @"KEY_NAME_COQUE_ACTUELLE")];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", (coins - coutAmeliorationCoque)]
                   forKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")];
    
    [sauvegarde synchronize];
    
    return YES;
}

+ (BOOL) ameliorationBouclier:(NSUserDefaults *)sauvegarde
{
    int coins = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")] intValue];
    
    int coutAmeliorationBouclier = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_BOUCLIER", @"KEY_NAME_COUT_AMELIORATION_BOUCLIER")] intValue];
    
    if (coins < coutAmeliorationBouclier)
    {
        return NO;
    }
    
    int newBouclier = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_BOUCLIER_CAPACITE", @"KEY_NAME_BOUCLIER_CAPACITE")] intValue] + [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_BOUCLIER", @"KEY_NAME_AMELIORATION_BOUCLIER")] intValue];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", newBouclier]
                   forKey:NSLocalizedString(@"KEY_NAME_BOUCLIER_CAPACITE", @"KEY_NAME_BOUCLIER_CAPACITE")];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", (coins - coutAmeliorationBouclier)]
                   forKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")];
    
    [sauvegarde synchronize];
    
    return YES;
}

+ (BOOL) ameliorationCapaciteMissile:(NSUserDefaults *)sauvegarde
{
    int coins = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")] intValue];
    
    int coutAmeliorationCapaciteMissile = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_CAPACITE_MISSILE", @"KEY_NAME_COUT_AMELIORATION_CAPACITE_MISSILE")] intValue];
    
    if (coins < coutAmeliorationCapaciteMissile)
    {
        return NO;
    }
    
    int newCapaciteMissile = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_MISSILE_CAPACITE", @"KEY_NAME_MISSILE_CAPACITE")] intValue] + [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_CAPACITE_MISSILE", @"KEY_NAME_AMELIORATION_CAPACITE_MISSILE")] intValue];
    
    int newNombreMissiles = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_NOMBRE_MISSILE_RESTANT", @"KEY_NAME_NOMBRE_MISSILE_RESTANT")] intValue] + [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_CAPACITE_MISSILE", @"KEY_NAME_AMELIORATION_CAPACITE_MISSILE")] intValue];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", newCapaciteMissile]
                   forKey:NSLocalizedString(@"KEY_NAME_MISSILE_CAPACITE", @"KEY_NAME_MISSILE_CAPACITE")];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", newNombreMissiles]
                   forKey:NSLocalizedString(@"KEY_NAME_NOMBRE_MISSILE_RESTANT", @"KEY_NAME_NOMBRE_MISSILE_RESTANT")];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", (coins - coutAmeliorationCapaciteMissile)]
                   forKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")];
    
    [sauvegarde synchronize];
    
    return YES;
}

+ (BOOL) ameliorationDegatsMissile:(NSUserDefaults *)sauvegarde
{
    int coins = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")] intValue];
    
    int coutAmeliorationDegatsMissile = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_DEGATS_MISSILE", @"KEY_NAME_COUT_AMELIORATION_DEGATS_MISSILE")] intValue];
    
    if (coins < coutAmeliorationDegatsMissile)
    {
        return NO;
    }
    
    float newDegatsMissile = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_MISSILE_DEGATS", @"KEY_NAME_MISSILE_DEGATS")] floatValue] + [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_DEGATS_MISSILE", @"KEY_NAME_AMELIORATION_DEGATS_MISSILE")] floatValue];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%f", newDegatsMissile]
                   forKey:NSLocalizedString(@"KEY_NAME_MISSILE_DEGATS", @"KEY_NAME_MISSILE_DEGATS")];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", (coins - coutAmeliorationDegatsMissile)]
                   forKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")];
    
    [sauvegarde synchronize];
    
    return YES;
}

+ (BOOL) ameliorationTempsRechargementMissile:(NSUserDefaults *)sauvegarde
{
    int coins = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")] intValue];
    
    int coutAmeliorationTempsRechargementMissile = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_MISSILE", @"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_MISSILE")] intValue];
    
    if (coins < coutAmeliorationTempsRechargementMissile)
    {
        return NO;
    }
    
    float newTempsRechargementMissile = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_MISSILE", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_MISSILE")] floatValue] - [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_TEMPS_DE_RECHARGEMENT_MISSILE", @"KEY_NAME_AMELIORATION_TEMPS_DE_RECHARGEMENT_MISSILE")] floatValue];
    
    if (newTempsRechargementMissile < 0.1)
    {
         return NO;
    }
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%f", newTempsRechargementMissile]
                   forKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_MISSILE", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_MISSILE")];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", (coins - coutAmeliorationTempsRechargementMissile)]
                   forKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")];
    
    [sauvegarde synchronize];
    
    return YES;
}

+ (BOOL) achatMissile:(NSUserDefaults *)sauvegarde
{
    int coins = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")] intValue];
    
    int coutAchatMissile = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_ACHAT_MISSILE", @"KEY_NAME_COUT_ACHAT_MISSILE")] intValue];
    
    if (coins < coutAchatMissile)
    {
        return NO;
    }
    
    int newNombreMissiles = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_NOMBRE_MISSILE_RESTANT", @"KEY_NAME_NOMBRE_MISSILE_RESTANT")] intValue] + 1;
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", newNombreMissiles]
                   forKey:NSLocalizedString(@"KEY_NAME_NOMBRE_MISSILE_RESTANT", @"KEY_NAME_NOMBRE_MISSILE_RESTANT")];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", (coins - coutAchatMissile)]
                   forKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")];
    
    [sauvegarde synchronize];
    
    return YES;
}

+ (BOOL) ameliorationDegatsLaser:(NSUserDefaults *)sauvegarde
{
    int coins = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")] intValue];
    
    int coutAmeliorationDegatsLaser = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_DEGATS_LASER", @"KEY_NAME_COUT_AMELIORATION_DEGATS_LASER")] intValue];
    
    if (coins < coutAmeliorationDegatsLaser)
    {
        return NO;
    }
    
    float newDegatsLaser = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_LASER_DEGATS", @"KEY_NAME_LASER_DEGATS")] floatValue] + [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_DEGATS_LASER", @"KEY_NAME_AMELIORATION_DEGATS_LASER")] floatValue];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%f", newDegatsLaser]
                   forKey:NSLocalizedString(@"KEY_NAME_LASER_DEGATS", @"KEY_NAME_LASER_DEGATS")];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", (coins - coutAmeliorationDegatsLaser)]
                   forKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")];
    
    [sauvegarde synchronize];
    
    return YES;
}

+ (BOOL) ameliorationTempsRechargementLaser:(NSUserDefaults *)sauvegarde
{
    int coins = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")] intValue];
    
    int coutAmeliorationTempsRechargementLaser = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_LASER", @"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_LASER")] intValue];
    
    if (coins < coutAmeliorationTempsRechargementLaser)
    {
        return NO;
    }
    
    float newTempsRechargementLaser = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_LASER", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_LASER")] floatValue] - [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_TEMPS_DE_RECHARGEMENT_LASER", @"KEY_NAME_AMELIORATION_TEMPS_DE_RECHARGEMENT_LASER")] floatValue];
    
    if (newTempsRechargementLaser < 0.1)
    {
        return NO;
    }
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%f", newTempsRechargementLaser]
                   forKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_LASER", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_LASER")];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", (coins - coutAmeliorationTempsRechargementLaser)]
                   forKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")];
    
    [sauvegarde synchronize];
    
    return YES;
}

+ (BOOL) ameliorationTempsRechargementBouclier:(NSUserDefaults *)sauvegarde
{
    int coins = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")] intValue];
    
    int coutAmeliorationTempsRechargementBouclier = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_BOUCLIER", @"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_BOUCLIER")] intValue];
    
    if (coins < coutAmeliorationTempsRechargementBouclier)
    {
        return NO;
    }
    
    float newTempsRechargementBouclier = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_BOUCLIER", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_BOUCLIER")] floatValue] - [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_TEMPS_DE_RECHARGEMENT_BOUCLIER", @"KEY_NAME_AMELIORATION_TEMPS_DE_RECHARGEMENT_BOUCLIER")] floatValue];
    
    if (newTempsRechargementBouclier < 0.1)
    {
        return NO;
    }
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%f", newTempsRechargementBouclier]
                   forKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_BOUCLIER", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_BOUCLIER")];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", (coins - coutAmeliorationTempsRechargementBouclier)]
                   forKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")];
    
    [sauvegarde synchronize];
    
    return YES;
}

+ (void) levelUP:(NSUserDefaults *)sauvegarde
{
    int newLevel = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_LEVEL", @"KEY_NAME_LEVEL")] intValue] + 1;
    
    int newXPObjectif = 1000 * newLevel;
    
    int newCoins = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")] intValue] + 100 * (newLevel - 1);
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", newLevel]
                   forKey:NSLocalizedString(@"KEY_NAME_LEVEL", @"KEY_NAME_LEVEL")];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", newXPObjectif]
                   forKey:NSLocalizedString(@"KEY_NAME_XP_OBJECTIF", @"KEY_NAME_XP_OBJECTIF")];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", 0]
                   forKey:NSLocalizedString(@"KEY_NAME_XP_ACCUMULES", @"KEY_NAME_XP_ACCUMULES")];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", newCoins]
                   forKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")];
}

@end
