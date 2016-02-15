//
//  VaisseauObject.m
//  DarkAvenger
//
//  Created by Thomas Mac on 06/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import "VaisseauObject.h"

#import "LaserObject.h"
#import "MissileObject.h"

#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>

@interface VaisseauObject ()

@property(nonatomic) float tempsRechargementLaser;

@property(nonatomic) float tempsRechargementMissile;

@property(nonatomic) int capaciteMissile;

@property(nonatomic) int capaciteVie;

@property(nonatomic) int puissanceBouclier;

@property(nonatomic) float bouclierRestant;

@property(nonatomic) float tempsRechargementBouclier;

@property(nonatomic) BOOL missileDisponible;

@property(nonatomic) BOOL laserDisponible;

@property(nonatomic, strong) NSTimer *timerRechargementBouclier;

@property(nonatomic, strong) NSTimer *timerRechargementLaser;

@property(nonatomic, strong) NSTimer *timerRechargementMissile;

@property(nonatomic, strong) GestionnaireCollision *gestionnaireCollision;

@property(nonatomic, strong) UIView *view;

@property(nonatomic, strong) GameViewController *gameViewController;

@property(nonatomic, strong) NSUserDefaults *sauvegarde;

@property(nonatomic) float vitesseIA;

@property(nonatomic) int directionDeplacementIA;

@property(nonatomic, strong) CMMotionManager *accelerometre;

@property(nonatomic, strong) CLLocationManager *location;

@property(nonatomic, strong) NSTimer *timerAnimationVaisseau;

@end

@implementation VaisseauObject

#pragma init

- (void) initVaisseauPlayer:(NSUserDefaults *)sauvegarde InView:(UIView *)view WithGestionnaireCollision:(GestionnaireCollision *)gestionnaireCollision WithViewController:(GameViewController *)gameViewController
{
    self.gestionnaireCollision = gestionnaireCollision;
    
    self.gameViewController = gameViewController;
    
    self.sauvegarde = sauvegarde;
    
    self.view = view;
    
    self.IA = NO;
    
    self.className = @"VaisseauObject";
    
    self.degatsLaser = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_LASER_DEGATS", @"KEY_NAME_LASER_DEGATS")] floatValue];
    
    self.tempsRechargementLaser = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_LASER", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_LASER")] floatValue];
    
    self.degatsMissile = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_MISSILE_DEGATS", @"KEY_NAME_MISSILE_DEGATS")] floatValue];
    
    self.tempsRechargementMissile = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_MISSILE", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_MISSILE")] floatValue];
    
    self.capaciteMissile = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_MISSILE_CAPACITE", @"KEY_NAME_MISSILE_CAPACITE")] intValue];
    
    self.nombreMissilesrestant = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_NOMBRE_MISSILE_RESTANT", @"KEY_NAME_NOMBRE_MISSILE_RESTANT")] intValue];
    
    self.capaciteVie = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COQUE_CAPACITE", @"KEY_NAME_COQUE_CAPACITE")] intValue];
    
    self.vieRestante = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COQUE_ACTUELLE", @"KEY_NAME_COQUE_ACTUELLE")] floatValue];
    
    self.puissanceBouclier = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_BOUCLIER_CAPACITE", @"KEY_NAME_BOUCLIER_CAPACITE")] intValue];
    
    self.bouclierRestant = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_BOUCLIER_CAPACITE", @"KEY_NAME_BOUCLIER_CAPACITE")] floatValue];
    
    self.tempsRechargementBouclier = [[sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_BOUCLIER", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_BOUCLIER")] floatValue];
    
    if (self.nombreMissilesrestant != 0)
    {
        self.missileDisponible = YES;
    }
    else
    {
        self.missileDisponible = NO;
    }
    
    self.laserDisponible = YES;
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"IMAGE_NAME_VAISSEAU", @"IMAGE_NAME_VAISSEAU")]];
    
    //275x183 - 183x122 - 137.5x91.5 - 110x73.2
    //[self.imageView setFrame:CGRectMake((view.frame.size.width - 137.5) / 2, 3 * (view.frame.size.height - 91.5) / 4, 137.5f, 91.5f)];
    [self.imageView setFrame:CGRectMake((view.frame.size.width - 110.0) / 2, 3 * (view.frame.size.height - 73.2) / 4, 110.0f, 73.2f)];
    
    [view addSubview:self.imageView];
    
    [self.gestionnaireCollision addObject:self WithClassName:self.className WithImageView:self.imageView];
    
    [self initialisationAccelerometre];
}

- (void) initIAWithLevel:(int)level WithSauvegarde:(NSUserDefaults *)sauvegarde InView:(UIView *)view WithGestionnaireCollision:(GestionnaireCollision *)gestionnaireCollision WithViewController:(GameViewController *)gameViewController
{
    self.gestionnaireCollision = gestionnaireCollision;
    
    //self.sauvegarde = sauvegarde;
    
    self.view = view;
    
    //self.gameViewController = gameViewController;
    
    self.IA = YES;
    
    self.directionDeplacementIA = arc4random_uniform(1);
    if (self.directionDeplacementIA == 0)
    {
        self.directionDeplacementIA = -1;
    }
    
    self.className = @"VaisseauObject";
    
    self.puissanceBouclier = level;
    
    self.degatsLaser = 1 + (level - 3) * 0.1;
    
    self.degatsMissile = 3 + (level - 3) * 0.5;
    
    self.tempsRechargementLaser = 1 - (level - 3) + 0.05;
    
    self.tempsRechargementMissile = 1 - (level - 3) * 0.1;
    
    self.tempsRechargementBouclier = 3 - (level - 3) * 0.1;
    
    self.vieRestante = 5 + (level - 3) * 1;
    
    if (self.tempsRechargementLaser < 0.1)
    {
        self.tempsRechargementLaser = 0.1;
    }
    
    if (self.tempsRechargementMissile < 0.1)
    {
        self.tempsRechargementMissile = 0.1;
    }
    
    if (self.tempsRechargementBouclier < 0.1)
    {
        self.tempsRechargementBouclier = 0.1;
    }
    
    self.missileDisponible = YES;
    
    self.laserDisponible = YES;
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedString(@"IMAGE_NAME_VAISSEAU_IA", @"IMAGE_NAME_VAISSEAU_IA")]];
    
    //275x183 - 183x122 - 137.5x91.5 - 110x73.2
    [self.imageView setFrame:CGRectMake((view.frame.size.width - 110.0) / 2, 73.2 + 30.0, 110.0f, 73.2f)];
    
    /*[UIView animateWithDuration:1.0 animations:^{
        [self.imageView setFrame:CGRectMake((view.frame.size.width - 110.0) / 2, 73.2 + 30.0, 110.0f, 73.2f)];
    }];*/
    
    [view addSubview:self.imageView];
    
    [self.gestionnaireCollision addObject:self WithClassName:self.className WithImageView:self.imageView];
    
    self.timerAnimationVaisseau = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(animationIA) userInfo:nil repeats:YES];
    
    [self tirerLaserInView:self.view];
    
    [self tirerMissileInView:self.view];
}

#pragma gestion laser et missile

- (void) tirerLaserInView:(UIView *)view
{
    if (!self.laserDisponible)
    {
        return;
    }
    
    self.laserDisponible = NO;
    
    LaserObject *laserObject = [[LaserObject alloc] init];
    
    if (self.IA)
    {
        [laserObject initialisationLaserWithDegats:self.degatsLaser
                                     WithPositionX:((self.imageView.frame.size.width / 2) + self.imageView.frame.origin.x - (5.0 / 2))
                                     WithPositionY:(self.imageView.frame.origin.y + self.imageView.frame.size.height)
                                            InView:view
                                            FromIA:YES
                         WithGestionnaireCollision:self.gestionnaireCollision];
    }
    else
    {
        [laserObject initialisationLaserWithDegats:self.degatsLaser
                                     WithPositionX:((self.imageView.frame.size.width / 2) + self.imageView.frame.origin.x - (5.0 / 2))
                                     WithPositionY:self.imageView.frame.origin.y
                                            InView:view
                                            FromIA:NO
                         WithGestionnaireCollision:self.gestionnaireCollision];
    }
    
    self.timerRechargementLaser = [NSTimer scheduledTimerWithTimeInterval:self.tempsRechargementLaser target:self selector:@selector(rechargementLaser) userInfo:nil repeats:YES];
}

- (void) tirerMissileInView:(UIView *)view
{
    if (!self.missileDisponible || (!self.IA && self.nombreMissilesrestant == 0))
    {
        return;
    }
    
    self.missileDisponible = NO;
    
    self.nombreMissilesrestant--;
    
    if (!self.IA)
    {
        [self.sauvegarde setObject:[NSString stringWithFormat:@"%d", self.nombreMissilesrestant]
                            forKey:NSLocalizedString(@"KEY_NAME_NOMBRE_MISSILE_RESTANT", @"KEY_NAME_NOMBRE_MISSILE_RESTANT")];
        
        [self.gameViewController reloadIndicateurMissile];
    }
    
    MissileObject *missileObject = [[MissileObject alloc] init];
    
    if (self.IA)
    {
        [missileObject initialisationMissileWithDegats:self.degatsMissile
                                         WithPositionX:(self.imageView.frame.origin.x + (self.imageView.frame.size.width / 2) - (22.0 / 2))
                                         WithPositionY:(self.imageView.frame.size.height + self.imageView.frame.origin.y)
                                                FromIA:YES
                                                InView:view
                             WithGestionnaireCollision:self.gestionnaireCollision];
    }
    else
    {
        [missileObject initialisationMissileWithDegats:self.degatsMissile
                                         WithPositionX:(self.imageView.frame.origin.x + (self.imageView.frame.size.width / 2) - (22.0 / 2))
                                         WithPositionY:self.imageView.frame.origin.y
                                                FromIA:NO
                                                InView:view
                             WithGestionnaireCollision:self.gestionnaireCollision];
    }
    
    self.timerRechargementMissile = [NSTimer scheduledTimerWithTimeInterval:self.tempsRechargementMissile target:self selector:@selector(rechargementMissile) userInfo:nil repeats:YES];
}

- (void) rechargementLaser
{
    [self.timerRechargementLaser invalidate];
    
    self.laserDisponible = YES;
    
    if (self.IA)
    {
        [self tirerLaserInView:self.view];
    }
}

- (void) rechargementMissile
{
    [self.timerRechargementMissile invalidate];
    
    self.missileDisponible = YES;
    
    if (self.IA)
    {
        [self tirerMissileInView:self.view];
    }
}

#pragma gestion du vaisseau

- (void) subitDesDegats:(float)degats
{
    self.bouclierRestant = self.bouclierRestant - degats;
    
    if (self.bouclierRestant < 0)
    {
        self.vieRestante = self.vieRestante + self.bouclierRestant;
        
        if (!self.IA)
        {
            [self.sauvegarde setObject:[NSString stringWithFormat:@"%d", (int)self.vieRestante]
                                forKey:NSLocalizedString(@"KEY_NAME_COQUE_ACTUELLE", @"KEY_NAME_COQUE_ACTUELLE")];
        }
        
        self.bouclierRestant = 0;
    }
    
    if (!self.IA)
    {
        [self.gameViewController reloadIndicateurPV];
        
        [self.gameViewController reloadIndicateurBouclier:(int)self.bouclierRestant];
    }
    
    if (self.vieRestante <= 0 && !self.IA)
    {
        [self.gameViewController defaite];
    }
    else if (self.vieRestante <= 0 && self.IA)
    {
        [self.gameViewController victoire];
    }
    else if (self.vieRestante > 0 && ![self.timerRechargementBouclier isValid])
    {
        self.timerRechargementBouclier = [NSTimer scheduledTimerWithTimeInterval:self.tempsRechargementBouclier target:self selector:@selector(rechargementBouclier) userInfo:nil repeats:YES];
    }
}

- (void) allDegats
{
    self.bouclierRestant = 0;
    
    self.vieRestante = 0;
    
    if (!self.IA)
    {
        [self.sauvegarde setObject:@"0"
                            forKey:NSLocalizedString(@"KEY_NAME_COQUE_ACTUELLE", @"KEY_NAME_COQUE_ACTUELLE")];
        
        [self.gameViewController reloadIndicateurPV];
        
        [self.gameViewController reloadIndicateurBouclier:(int)self.bouclierRestant];
        
        [self.gameViewController defaite];
    }
}

- (void) rechargementBouclier
{
    self.bouclierRestant++;
    
    if (self.bouclierRestant >= self.puissanceBouclier)
    {
        [self.timerRechargementBouclier invalidate];
        
        self.bouclierRestant = self.puissanceBouclier;
    }
}

- (void) deallocVaisseau
{
    //[self.gestionnaireCollision removeObject:self];
    
    [self stopAllTimers];
    
    self.className = nil;
    
    self.gestionnaireCollision = nil;
    
    //self.view = nil;
    
    //self.imageView = nil;
    
    //self.sauvegarde = nil;
}

#pragma gestion capteur accelerometre

- (void) initialisationAccelerometre
{
    self.accelerometre = [[CMMotionManager alloc] init];
    
    self.location = [[CLLocationManager alloc] init];
    
    self.location.delegate = nil;
    
    self.location.headingFilter = kCLHeadingFilterNone;
    
    self.location.distanceFilter = kCLDistanceFilterNone;
    
    self.location.desiredAccuracy = kCLLocationAccuracyBest;
    
    self.accelerometre.accelerometerUpdateInterval = 0.1;
    
    [self.accelerometre startAccelerometerUpdates];
    
    self.timerAnimationVaisseau = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(animationVaisseauPlayer) userInfo:nil repeats:YES];
}

- (void) animationVaisseauPlayer
{
    /*NSLog(@"TEST X : %lf", self.accelerometre.accelerometerData.acceleration.x);
    
    NSLog(@"TEST Y : %lf", self.accelerometre.accelerometerData.acceleration.y);
    
    NSLog(@"TEST Z : %lf", self.accelerometre.accelerometerData.acceleration.z);*/
    
    // y : en arrière => -0.9 / stabilité => -0.75 / en avant => -0.03
    // z : en arrière => -0.4 / stabilité => -0.65 / en avant => -1.0
    
    float x = self.imageView.frame.origin.x + 10 * self.accelerometre.accelerometerData.acceleration.x;
    
    //float y = self.imageView.frame.origin.y + 10 * (self.accelerometre.accelerometerData.acceleration.z + 0.65);
    float y;
    
    if (self.accelerometre.accelerometerData.acceleration.z > -0.65)
    {
        y = self.imageView.frame.origin.y + 10 * (self.accelerometre.accelerometerData.acceleration.z + 0.65 + 0.1);
    }
    else
    {
        y = self.imageView.frame.origin.y + 10 * (self.accelerometre.accelerometerData.acceleration.z + 0.65);
    }
    
    if (x <= 0)
    {
        x = 0.0;
    }
    else if (x >= (self.view.frame.size.width - self.imageView.frame.size.width))
    {
        x = self.view.frame.size.width - self.imageView.frame.size.width;
    }
    
    if (y <= 0)
    {
        y = 0.0;
    }
    else if (y >= (self.view.frame.size.height - self.imageView.frame.size.height))
    {
        y = self.view.frame.size.height - self.imageView.frame.size.height;
    }
    
    [self.imageView setFrame:CGRectMake(x, y, self.imageView.frame.size.width, self.imageView.frame.size.height)];
}

#pragma gestion des timers

- (void) stopAllTimers
{
    [self.timerRechargementMissile invalidate];
    
    [self.timerRechargementLaser invalidate];
    
    [self.timerRechargementBouclier invalidate];
    
    [self.timerAnimationVaisseau invalidate];
}

#pragma gestion IA

- (void) animationIA
{
    if (self.imageView.frame.origin.x <= 0)
    {
        self.directionDeplacementIA = 1;
    }
    else if (self.imageView.frame.origin.x + self.imageView.frame.size.width)
    {
        self.directionDeplacementIA = -1;
    }
    
    [self.imageView setFrame:CGRectMake(self.imageView.frame.origin.x + self.directionDeplacementIA * self.vitesseIA, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height)];
}

@end
