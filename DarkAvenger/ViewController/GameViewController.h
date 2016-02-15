//
//  GameViewController.h
//  DarkAvenger
//
//  Created by Thomas Mac on 09/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MenuMissionsTableViewController.h"

@interface GameViewController : UIViewController

@property(nonatomic, weak) MenuMissionsTableViewController *menuMissionsTableViewController;

@property(nonatomic) int xpEnnemisKilled;

# pragma Gestion des indicateurs

- (void) reloadIndicateurPV;

- (void) reloadIndicateurBouclier:(int)bouclierValue;

- (void) reloadIndicateurMissile;

# pragma Gestion fin de mission

- (void) ennemisKilled;

- (void) victoire;

- (void) defaite;

@end
