//
//  GameViewController.m
//  DarkAvenger
//
//  Created by Thomas Mac on 09/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import "GameViewController.h"

#import "VaisseauObject.h"
#import "AsteroideObject.h"
#import "MissileObject.h"
#import "LaserObject.h"

#import "GestionnaireCollision.h"
#import "GestionnaireCaracteristiquesVaisseau.h"
#import "GestionnaireAnimationAsteroide.h"

#import "SpecificLabelWithImage.h"

@interface GameViewController () <UIAlertViewDelegate>

@property(nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@property(nonatomic, strong) VaisseauObject *vaisseauPlayer;

@property(nonatomic, strong) VaisseauObject *vaisseauIA;

@property(nonatomic, strong) GestionnaireCollision *gestionnaireCollision;

@property(nonatomic, strong) GestionnaireAnimationAsteroide *gestionnaireAnimationAsteroide;

@property(nonatomic, strong) UIButton *buttonLaser;

@property(nonatomic, strong) UIButton *buttonMissile;

@property(nonatomic, strong) SpecificLabelWithImage *labelMissile;

@property(nonatomic, strong) SpecificLabelWithImage *labelBouclier;

@property(nonatomic, strong) SpecificLabelWithImage *labelPV;

@property(nonatomic) float tempsApparitionEnnemis;

@property(nonatomic, strong) NSTimer *timerApparitionEnnemis;

@property(nonatomic, strong) NSArray *probabilitesArray;

@property(nonatomic) int killEnnemisObjectif;

@property(nonatomic) BOOL boss;

@property(nonatomic) float poids;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1]];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [self.activityIndicatorView setCenter:CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0)];
    
    [self.activityIndicatorView setColor:[UIColor whiteColor]];
    [self.activityIndicatorView setHidesWhenStopped:YES];
    
    [self.view addSubview:self.activityIndicatorView];
    
    self.xpEnnemisKilled = 0;
    
    [self initialisationButtons];
    
    [self initialisationIndicateurs];
    
    self.gestionnaireAnimationAsteroide = [[GestionnaireAnimationAsteroide alloc] init];
    
    [self.gestionnaireAnimationAsteroide initialisation];
    
    self.gestionnaireCollision = [[GestionnaireCollision alloc] init];
    
    [self.gestionnaireCollision initialisationWithGestionnaireAnimationAsteroide:self.gestionnaireAnimationAsteroide];
    
    [self.gestionnaireCollision startGestionCollisions];
    
    self.vaisseauPlayer = [[VaisseauObject alloc] init];
    
    [self.vaisseauPlayer initVaisseauPlayer:self.menuMissionsTableViewController.accueilViewController.sauvegarde InView:self.view WithGestionnaireCollision:self.gestionnaireCollision WithViewController:self];
    
    [self setAllConfigurationsMissionWithLevel:[[self.menuMissionsTableViewController.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_LEVEL_CHOISI", @"KEY_NAME_LEVEL_CHOISI")] intValue]];
    
    self.timerApparitionEnnemis = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startMission) userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) prefersStatusBarHidden
{
    return YES;
}

- (void) startMission
{
    [self.timerApparitionEnnemis invalidate];
    
    self.timerApparitionEnnemis = [NSTimer scheduledTimerWithTimeInterval:self.tempsApparitionEnnemis target:self selector:@selector(ennemisAppear) userInfo:nil repeats:YES];
}

#pragma Gestion des indicateurs

- (void) initialisationIndicateurs
{
    int nombrePV = [[self.menuMissionsTableViewController.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COQUE_ACTUELLE", @"KEY_NAME_COQUE_ACTUELLE")] intValue];
    
    int nombreMissilesRestant = [[self.menuMissionsTableViewController.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_NOMBRE_MISSILE_RESTANT", @"KEY_NAME_NOMBRE_MISSILE_RESTANT")] intValue];
    
    int nombreBouclier = [[self.menuMissionsTableViewController.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_BOUCLIER_CAPACITE", @"KEY_NAME_BOUCLIER_CAPACITE")] intValue];
    
    self.labelPV = [[SpecificLabelWithImage alloc] init];
    
    [self.labelPV setFrame:CGRectMake(self.buttonLaser.frame.origin.x + self.buttonLaser.frame.size.width, self.view.frame.size.height - 30.0f - 5.0f, self.view.frame.size.width - self.buttonLaser.frame.origin.x - self.buttonLaser.frame.size.width, 30.0f)];
    
    [self.labelPV initialisationWithNameImage:NSLocalizedString(@"IMAGE_NAME_COEUR", @"IMAGE_NAME_COEUR")
                                      AndText:[NSString stringWithFormat:@"x%d", nombrePV]];
    
    [self.view addSubview:self.labelPV];
    
    self.labelBouclier = [[SpecificLabelWithImage alloc] init];
    
    [self.labelBouclier setFrame:CGRectMake(self.labelPV.frame.origin.x, self.labelPV.frame.origin.y - 30.0f, self.labelPV.frame.size.width, 30.0f)];
    
    [self.labelBouclier initialisationWithNameImage:NSLocalizedString(@"IMAGE_NAME_BOUCLIER", @"IMAGE_NAME_BOUCLIER")
                                            AndText:[NSString stringWithFormat:@"x%d", nombreBouclier]];
    
    [self.view addSubview:self.labelBouclier];
    
    if (nombreMissilesRestant > 0)
    {
        self.labelMissile = [[SpecificLabelWithImage alloc] init];
        
        [self.labelMissile setFrame:CGRectMake(0.0f, self.buttonMissile.frame.origin.y + (self.buttonMissile.frame.size.height / 2) - 15.0f, self.buttonMissile.frame.origin.x, 30.0f)];
        
        [self.labelMissile initialisationWithNameImage:NSLocalizedString(@"IMAGE_NAME_MISSILE_INDICATEUR", @"IMAGE_NAME_MISSILE_INDICATEUR")
                                               AndText:[NSString stringWithFormat:@"x%d", nombreMissilesRestant]];
        
        [self.view addSubview:self.labelMissile];
    }
}

- (void) reloadIndicateurPV
{
    int nombrePV = [[self.menuMissionsTableViewController.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COQUE_ACTUELLE", @"KEY_NAME_COQUE_ACTUELLE")] intValue];
    
    [self.labelPV setText:[NSString stringWithFormat:@"x%d", nombrePV]];
}

- (void) reloadIndicateurBouclier:(int)bouclierValue
{
    [self.labelBouclier setText:[NSString stringWithFormat:@"x%d", bouclierValue]];
}

- (void) reloadIndicateurMissile
{
    int nombreMissilesRestant = [[self.menuMissionsTableViewController.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_NOMBRE_MISSILE_RESTANT", @"KEY_NAME_NOMBRE_MISSILE_RESTANT")] intValue];
    
    [self.labelMissile setText:[NSString stringWithFormat:@"x%d", nombreMissilesRestant]];
}

#pragma Gestion des boutons

- (void) initialisationButtons
{
    int nombreMissilesRestant = [[self.menuMissionsTableViewController.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_NOMBRE_MISSILE_RESTANT", @"KEY_NAME_NOMBRE_MISSILE_RESTANT")] intValue];
    
    if (nombreMissilesRestant > 0)
    {
        self.buttonMissile = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 4) - 25.0f, self.view.frame.size.height - 50.0f - 15.0f, 50.0f, 50.0f)];
        
        [self.buttonMissile setImage:[UIImage imageNamed:NSLocalizedString(@"IMAGE_NAME_BUTTON_MISSILE", @"IMAGE_NAME_BUTTON_MISSILE")]
                            forState:UIControlStateNormal];
        
        [self.buttonMissile addTarget:self action:@selector(actionlistenerButtonMissile) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.buttonMissile];
    }
    
    self.buttonLaser = [[UIButton alloc] initWithFrame:CGRectMake((3 * self.view.frame.size.width / 4) - 25.0f, self.view.frame.size.height - 50.0f - 15.0f, 50.0f, 50.0f)];
    
    [self.buttonLaser setImage:[UIImage imageNamed:NSLocalizedString(@"IMAGE_NAME_BUTTON_LASER", @"IMAGE_NAME_BUTTON_LASER")]
                      forState:UIControlStateNormal];
    
    [self.buttonLaser addTarget:self action:@selector(actionlistenerButtonLaser) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.buttonLaser];
}

- (void) actionlistenerButtonLaser
{
    [self.vaisseauPlayer tirerLaserInView:self.view];
}

- (void) actionlistenerButtonMissile
{
    [self.vaisseauPlayer tirerMissileInView:self.view];
}

#pragma Gestion des ennemis

- (void) setAllConfigurationsMissionWithLevel:(int)missionLevel
{
    int zero = 0;
    
    int probabilitesFirstType = 100;
    
    int probabilitesSecondType = 100;
    
    int probabilitesThirdType = 100;
    
    int probabilitesFourthType = 100;
    
    int probabilitesFiveType = 100;
    
    if (missionLevel == 1 || missionLevel == 2)
    {
        probabilitesFirstType = 80 - (missionLevel - 1) * 15;
    }
    else if (missionLevel == 3)
    {
        probabilitesFirstType = 40;
        
        probabilitesSecondType = 90;
    }
    else if (missionLevel > 3)
    {
        probabilitesFirstType = 20;
        if (missionLevel == 4)
        {
            probabilitesSecondType = 75;
            
            probabilitesThirdType = 95;
        }
        else if (missionLevel == 5)
        {
            probabilitesSecondType = 55;
            
            probabilitesThirdType = 85;
            
            probabilitesFourthType = 95;
        }
        else if (missionLevel >= 6)
        {
            probabilitesSecondType = 40;
            
            probabilitesThirdType = 70;
            
            probabilitesFourthType = 85;
        }
    }
    
    self.probabilitesArray = [[NSArray alloc] initWithObjects:
                              [NSString stringWithFormat:@"%d", zero],
                              [NSString stringWithFormat:@"%d", probabilitesFirstType],
                              [NSString stringWithFormat:@"%d", probabilitesSecondType],
                              [NSString stringWithFormat:@"%d", probabilitesThirdType],
                              [NSString stringWithFormat:@"%d", probabilitesFourthType],
                              [NSString stringWithFormat:@"%d", probabilitesFiveType], nil];
    
    self.killEnnemisObjectif = (missionLevel - 1) * 10 + 20;
    
    self.tempsApparitionEnnemis = 3.0;
    
    self.poids = 5;
    
    self.boss = [[self.menuMissionsTableViewController.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_BOSS_MISSION", @"KEY_NAME_BOSS_MISSION")] boolValue];
}

- (void) ennemisAppear
{
    float poids = self.poids;
    
    float arrayPoids[5] = {1.0, 1.0, 1.5, 2.0, 2.5};
    
    // Taille AsteroideObject : 148x165 - 111x124 - 74x83 - 55.5x62 - 44.4x49.6
    float arrayAsteroideWidth[5] = {44.4, 55.5, 74.0, 111.0, 148.0};
    
    float arrayAsteroideHeigth[5] = {49.6, 62.0, 83.0, 124.0, 165.0};
    
    int sectionScreen = 1;
    
    int yDelta = 0;
    
    while (poids > 0)
    {
        int probabilite = arc4random_uniform(100);
        
        for (int i=1;i<self.probabilitesArray.count;i++)
        {
            if ([self.probabilitesArray[i - 1] intValue] <= probabilite && probabilite < [self.probabilitesArray[i] intValue])
            {
                AsteroideObject *asteroideObject = [[AsteroideObject alloc] init];
                
                float x = arc4random_uniform(sectionScreen * self.view.frame.size.width / 3 - arrayAsteroideWidth[i - 1]) + (sectionScreen - 1) * self.view.frame.size.width / 3;
                
                float y = -arrayAsteroideHeigth[i - 1] - arc4random_uniform(arrayAsteroideHeigth[i - 1] / 2) - yDelta * arrayAsteroideHeigth[i-1];
                
                [asteroideObject initWithType:i WithPositionX:x WithPositionY:y InView:self.view WithGestionnaireCollision:self.gestionnaireCollision WithViewController:self WithGestionnaireAnimationAsteroide:self.gestionnaireAnimationAsteroide];
                
                [self.gestionnaireAnimationAsteroide addAsteroide:asteroideObject];
                
                poids = poids - arrayPoids[i - 1];
                
                sectionScreen++;
                
                if (sectionScreen == 4)
                {
                    sectionScreen = 1;
                    
                    yDelta++;
                }
                
                break;
            }
        }
    }
}

#pragma Gestion fin de mission

- (void) ennemisKilled
{
    self.killEnnemisObjectif--;
    
    if (self.killEnnemisObjectif == 0 && self.boss)
    {
        self.vaisseauIA = [[VaisseauObject alloc] init];
        
        [self.vaisseauIA
         initIAWithLevel:[[self.menuMissionsTableViewController.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_LEVEL_CHOISI", @"KEY_NAME_LEVEL_CHOISI")] intValue]
         WithSauvegarde:self.menuMissionsTableViewController.accueilViewController.sauvegarde
         InView:self.view
         WithGestionnaireCollision:self.gestionnaireCollision
         WithViewController:self];
    }
    else if (self.killEnnemisObjectif == 0 && !self.boss && self.vaisseauPlayer.vieRestante > 0)
    {
        [self victoire];
    }
}

- (void) defaite
{
    [self.timerApparitionEnnemis invalidate];
    
    [self.gestionnaireCollision removeGestionnaireCollision];
    
    NSUserDefaults *sauvegarde = self.menuMissionsTableViewController.accueilViewController.sauvegarde;
    
    [sauvegarde setObject:@"1" forKey:NSLocalizedString(@"KEY_NAME_COQUE_ACTUELLE", @"KEY_NAME_COQUE_ACTUELLE")];
    
    int xpAccumules = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_XP_ACCUMULES", @"KEY_NAME_XP_ACCUMULES")] intValue];
    
    int xpObjectif = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_XP_OBJECTIF", @"KEY_NAME_XP_OBJECTIF")] intValue];
    
    xpAccumules = xpAccumules + self.xpEnnemisKilled;
    
    NSString *messageLevelUp = @"";
    
    if (xpAccumules >= xpObjectif)
    {
        messageLevelUp = @"Félicitation vous avez gagné un niveau.";
        
        xpAccumules = xpAccumules - xpObjectif;
        
        [GestionnaireCaracteristiquesVaisseau levelUP:sauvegarde];
    }
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", xpAccumules]
                   forKey:NSLocalizedString(@"KEY_NAME_XP_ACCUMULES", @"KEY_NAME_XP_ACCUMULES")];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Défaite" message:[@"Vous avez échoué capitaine... " stringByAppendingString:messageLevelUp] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
     [alertView show];
}

- (void) victoire
{
    [self.timerApparitionEnnemis invalidate];
    
    [self.gestionnaireCollision removeGestionnaireCollision];
    
    NSUserDefaults *sauvegarde = self.menuMissionsTableViewController.accueilViewController.sauvegarde;
    
    int missionMax = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_LAST_MISSION_NUMBER", @"KEY_NAME_LAST_MISSION_NUMBER")] intValue];
    
    int missionChoisi = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_LEVEL_CHOISI", @"KEY_NAME_LEVEL_CHOISI")] intValue];
    
    if (missionMax == missionChoisi)
    {
        [sauvegarde setObject:[NSString stringWithFormat:@"%d", (missionMax + 1)]
                            forKey:NSLocalizedString(@"KEY_NAME_LAST_MISSION_NUMBER", @"KEY_NAME_LAST_MISSION_NUMBER")];
    }
    
    int xpAccumules = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_XP_ACCUMULES", @"KEY_NAME_XP_ACCUMULES")] intValue];
    
    int xpObjectif = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_XP_OBJECTIF", @"KEY_NAME_XP_OBJECTIF")] intValue];
    
    int coins = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")] intValue];
    
    int xpRecompenseMission = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_RECOMPENSE_XP_MISSION", @"KEY_NAME_RECOMPENSE_XP_MISSION")] intValue];
    
    int coinsRecompenseMission = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_RECOMPENSE_COINS_MISSION", @"KEY_NAME_RECOMPENSE_COINS_MISSION")] intValue];
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", (coins + coinsRecompenseMission)]
                        forKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")];
    
    xpAccumules = xpAccumules + self.xpEnnemisKilled + xpRecompenseMission;
    
    NSString *messageLevelUp = @"";
    
    if (xpAccumules >= xpObjectif)
    {
        messageLevelUp = @"Félicitation vous avez gagné un niveau.";
        
        xpAccumules = xpAccumules - xpObjectif;
        
        [GestionnaireCaracteristiquesVaisseau levelUP:sauvegarde];
    }
    
    [sauvegarde setObject:[NSString stringWithFormat:@"%d", xpAccumules]
                        forKey:NSLocalizedString(@"KEY_NAME_XP_ACCUMULES", @"KEY_NAME_XP_ACCUMULES")];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Victoire" message:[@"Félicitation capitaine, vous avez infligé de lourds dégats au vaisseau de Dark Avenger. Cependant, Dark Avenger a réussi à prendre la fuite, poursuivez le ! " stringByAppendingString:messageLevelUp] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"])
    {
        [self.navigationController popToViewController:self.menuMissionsTableViewController animated:YES];
    }
}

@end
