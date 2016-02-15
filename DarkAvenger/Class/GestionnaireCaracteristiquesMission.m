//
//  GestionnaireCaracteristiquesMission.m
//  DarkAvenger
//
//  Created by Thomas Mac on 09/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import "GestionnaireCaracteristiquesMission.h"

@implementation GestionnaireCaracteristiquesMission

+ (void)setAllCaracteristiquesMission:(NSUserDefaults *)sauvegarde WithLevel:(int)level
{
    int recompenseXP = [GestionnaireCaracteristiquesMission getRecompenseXPMissionWithLevel:level];
    
    int recompenseCoins = [GestionnaireCaracteristiquesMission getRecompenseCoinsMissionWithLevel:level];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", recompenseXP]
                   forKey:NSLocalizedString(@"KEY_NAME_RECOMPENSE_XP_MISSION", @"KEY_NAME_RECOMPENSE_XP_MISSION")];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", recompenseCoins]
                   forKey:NSLocalizedString(@"KEY_NAME_RECOMPENSE_COINS_MISSION", @"KEY_NAME_RECOMPENSE_COINS_MISSION")];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", (level % 3 == 0)]
                   forKey:NSLocalizedString(@"KEY_NAME_BOSS_MISSION", @"KEY_NAME_BOSS_MISSION")];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", level]
                   forKey:NSLocalizedString(@"KEY_NAME_LEVEL_CHOISI", @"KEY_NAME_LEVEL_CHOISI")];
    
    [sauvegarde synchronize];
}

+ (int)getRecompenseCoinsMissionWithLevel:(int)level
{
    return (25 * level);
}

+ (int)getRecompenseXPMissionWithLevel:(int)level
{
    return (100 * level);
}

@end
