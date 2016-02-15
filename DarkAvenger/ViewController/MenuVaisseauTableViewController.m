//
//  MenuVaisseauTableViewController.m
//  DarkAvenger
//
//  Created by Thomas Mac on 07/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import "MenuVaisseauTableViewController.h"

#import "SpecificTableViewCell.h"
#import "SpecificWithoutImageTableViewCell.h"

#import "GestionnaireCaracteristiquesVaisseau.h"

@interface MenuVaisseauTableViewController () <UIAlertViewDelegate>

@property(nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@property(nonatomic, strong) NSMutableArray *typesCellArray;

@property(nonatomic, strong) NSArray *sectionArray;

@property(nonatomic, strong) NSString *typeCellSelected;

@property(nonatomic, strong) UIBarButtonItem *buttonCoins;

@end

@implementation MenuVaisseauTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    
    shadow.shadowOffset = CGSizeMake(0, 1);
    
    UIBarButtonItem *buttonPrevious = [[UIBarButtonItem alloc] initWithTitle:@"Retour" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [buttonPrevious setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName, shadow, NSShadowAttributeName,[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    self.navigationItem.backBarButtonItem = buttonPrevious;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    
    [self.tableView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1]];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[SpecificTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[SpecificWithoutImageTableViewCell class] forCellReuseIdentifier:@"cellWithoutImage"];
    
    [self setTitle:@"Votre Vaisseau"];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [self.activityIndicatorView setCenter:CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0)];
    
    [self.activityIndicatorView setColor:[UIColor whiteColor]];
    [self.activityIndicatorView setHidesWhenStopped:YES];
    
    [self.tableView addSubview:self.activityIndicatorView];
    
    int coqueActuelle = [[self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COQUE_ACTUELLE", @"KEY_NAME_COQUE_ACTUELLE")] intValue];
    
    int coqueCapacite = [[self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COQUE_CAPACITE", @"KEY_NAME_COQUE_CAPACITE")] intValue];
    
    int nombreMissileRestant = [[self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_NOMBRE_MISSILE_RESTANT", @"KEY_NAME_NOMBRE_MISSILE_RESTANT")] intValue];
    
    int missileCapacite = [[self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_MISSILE_CAPACITE", @"KEY_NAME_MISSILE_CAPACITE")] intValue];
    
    float tempsRechargementBouclier = [[self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_BOUCLIER", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_BOUCLIER")] floatValue];
    
    float tempsRechargementMissile = [[self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_MISSILE", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_MISSILE")] floatValue];
    
    float tempsRechargementLaser = [[self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_LASER", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_LASER")] floatValue];
    
    self.sectionArray = [[NSArray alloc] initWithObjects:@"Coque", @"Boucliers", @"Missile", @"Laser", nil];
    
    self.typesCellArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *arrayFirstSection = [[NSMutableArray alloc] init];
    
    NSMutableArray *arraySecondSection = [[NSMutableArray alloc] init];
    
    NSMutableArray *arrayThirdSection = [[NSMutableArray alloc] init];
    
    NSMutableArray *arrayFourthSection = [[NSMutableArray alloc] init];
    
    [arrayFirstSection addObject:@"EtatCoque"];
    
    if (coqueActuelle != coqueCapacite)
    {
        [arrayFirstSection addObject:@"ReparerCoque"];
    }
    
    [arrayFirstSection addObject:@"AmeliorerCoque"];
    
    [arraySecondSection addObject:@"Bouclier"];
    
    [arraySecondSection addObject:@"AmeliorerBouclier"];
    
    [arraySecondSection addObject:@"TempsRechargementBouclier"];
    
    if (tempsRechargementBouclier > 0.1)
    {
        [arraySecondSection addObject:@"AmeliorerTempsRechargementBouclier"];
    }
    
    [arrayThirdSection addObject:@"CapaciteMissile"];
    
    if (nombreMissileRestant != missileCapacite)
    {
        [arrayThirdSection addObject:@"RacheterMissile"];
    }
    
    [arrayThirdSection addObject:@"AmeliorerCapaciteMissile"];
    
    [arrayThirdSection addObject:@"TempsRechargementMissile"];
    
    if (tempsRechargementMissile > 0.1)
    {
        [arrayThirdSection addObject:@"AmeliorerTempsRechargementMissile"];
    }
        
    [arrayThirdSection addObject:@"DegatsMissile"];
    
    [arrayThirdSection addObject:@"AmeliorerDegatsMissile"];
    
    [arrayFourthSection addObject:@"TempsRechargementLaser"];
    
    if (tempsRechargementLaser > 0.1)
    {
        [arrayFourthSection addObject:@"AmeliorerTempsRechargementLaser"];
    }
    
    [arrayFourthSection addObject:@"DegatsLaser"];
    
    [arrayFourthSection addObject:@"AmeliorerDegatsLaser"];
    
    [self.typesCellArray addObject:arrayFirstSection];
    
    [self.typesCellArray addObject:arraySecondSection];
    
    [self.typesCellArray addObject:arrayThirdSection];
    
    [self.typesCellArray addObject:arrayFourthSection];
    
    [GestionnaireCaracteristiquesVaisseau setAllAmeliorations:self.accueilViewController.sauvegarde];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:YES];
    
    [self.navigationController.toolbar setBarTintColor:[UIColor colorWithRed:0.188 green:0.188 blue:0.188 alpha:1]];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    
    shadow.shadowOffset = CGSizeMake(0, 1);
    
    int coins = [[self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")] intValue];
    
    self.buttonCoins = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%d coins", coins]
                                                        style:UIBarButtonItemStylePlain
                                                       target:nil
                                                       action:nil];
    
    [self.buttonCoins setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName, shadow, NSShadowAttributeName, [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil
                                      action:nil];
    
    [self.navigationController.toolbar setItems:@[ flexibleSpace, self.buttonCoins, flexibleSpace ]];
    
    [super viewDidAppear:animated];
}

- (BOOL) prefersStatusBarHidden
{
    return YES;
}

- (void) setTextAndImageCell:(SpecificTableViewCell *)cell WithType:(NSString *)type
{
    NSString *text;
    NSString *imageName;
    
    if ([type isEqualToString:@"EtatCoque"])
    {
        text = [NSString stringWithFormat:@"Etat du vaisseau : %@ / %@ PV", [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COQUE_ACTUELLE", @"KEY_NAME_COQUE_ACTUELLE")], [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COQUE_CAPACITE", @"KEY_NAME_COQUE_CAPACITE")]];
        
        imageName = NSLocalizedString(@"IMAGE_NAME_COQUE", @"IMAGE_NAME_COQUE");
    }
    
    else if ([type isEqualToString:@"Bouclier"])
    {
        text = [NSString stringWithFormat:@"Puissance des boucliers : %@", [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_BOUCLIER_CAPACITE", @"KEY_NAME_BOUCLIER_CAPACITE")]];
        
        imageName = NSLocalizedString(@"IMAGE_NAME_ICON_BOUCLIER", @"IMAGE_NAME_ICON_BOUCLIER");
    }
    
    else if ([type isEqualToString:@"TempsRechargementBouclier"])
    {
        text = [NSString stringWithFormat:@"Temps de rechargement des boucliers : %@ secondes", [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_BOUCLIER", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_BOUCLIER")]];
        
        imageName = NSLocalizedString(@"IMAGE_NAME_TIMER", @"IMAGE_NAME_TIMER");
    }
    
    else if ([type isEqualToString:@"CapaciteMissile"])
    {
        text = [NSString stringWithFormat:@"Nombre de missiles : %@ / %@", [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_NOMBRE_MISSILE_RESTANT", @"KEY_NAME_NOMBRE_MISSILE_RESTANT")], [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_MISSILE_CAPACITE", @"KEY_NAME_MISSILE_CAPACITE")]];
        
        imageName = NSLocalizedString(@"IMAGE_NAME_MISSILE_INDICATEUR", @"IMAGE_NAME_MISSILE_INDICATEUR");
    }
    
    else if ([type isEqualToString:@"TempsRechargementMissile"])
    {
        text = [NSString stringWithFormat:@"Temps de rechargement des missiles : %@ secondes", [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_MISSILE", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_MISSILE")]];
        
        imageName = NSLocalizedString(@"IMAGE_NAME_TIMER", @"IMAGE_NAME_TIMER");
    }
    
    else if ([type isEqualToString:@"DegatsMissile"])
    {
        text = [NSString stringWithFormat:@"Dégats des missiles : %@ dégats", [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_MISSILE_DEGATS", @"KEY_NAME_MISSILE_DEGATS")]];
        
        imageName = NSLocalizedString(@"IMAGE_NAME_DEGATS", @"IMAGE_NAME_DEGATS");
    }
    
    else if ([type isEqualToString:@"TempsRechargementLaser"])
    {
        text = [NSString stringWithFormat:@"Temps de rechargement des lasers : %@ seconde", [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_TEMPS_DE_RECHARGEMENT_LASER", @"KEY_NAME_TEMPS_DE_RECHARGEMENT_LASER")]];
        
        imageName = NSLocalizedString(@"IMAGE_NAME_TIMER", @"IMAGE_NAME_TIMER");
    }
    
    else if ([type isEqualToString:@"DegatsLaser"])
    {
        text = [NSString stringWithFormat:@"Dégats des lasers : %@ dégats", [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_LASER_DEGATS", @"KEY_NAME_LASER_DEGATS")]];
        
        imageName = NSLocalizedString(@"IMAGE_NAME_DEGATS", @"IMAGE_NAME_DEGATS");
    }
    
    [cell.textLabel setText:text];
    
    [cell.imageView setImage:[UIImage imageNamed:imageName]];
}

- (void) setTextCell:(SpecificWithoutImageTableViewCell *)cell WithType:(NSString *)type
{
    NSString *text;
    
    if ([type isEqualToString:@"ReparerCoque"])
    {
        text = [NSString stringWithFormat:@"Réparer le vaisseau : %@ coins",
                [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_REPARATION_VAISSEAU", @"KEY_NAME_COUT_REPARATION_VAISSEAU")]];
    }
    
    else if ([type isEqualToString:@"AmeliorerCoque"])
    {
        text = [NSString stringWithFormat:@"Améliorer la résistance du vaisseau : +%@ pv / %@ coins",
                [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_COQUE", @"KEY_NAME_AMELIORATION_COQUE")],
                [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_COQUE", @"KEY_NAME_COUT_AMELIORATION_COQUE")]];
    }
    
    else if ([type isEqualToString:@"AmeliorerBouclier"])
    {
        text = [NSString stringWithFormat:@"Améliorer les boucliers : +1 level / %@ coins",
                [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_BOUCLIER", @"KEY_NAME_COUT_AMELIORATION_BOUCLIER")]];
    }
    
    else if ([type isEqualToString:@"RacheterMissile"])
    {
        text = [NSString stringWithFormat:@"Acheter un missile : %@ coins",
                [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_ACHAT_MISSILE", @"KEY_NAME_COUT_ACHAT_MISSILE")]];
    }
    
    else if ([type isEqualToString:@"AmeliorerCapaciteMissile"])
    {
        text = [NSString stringWithFormat:@"Ameliorer le nombre de missiles transportés : +%@ missile(s) / %@ coins",
                [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_CAPACITE_MISSILE", @"KEY_NAME_AMELIORATION_CAPACITE_MISSILE")],
                [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_CAPACITE_MISSILE", @"KEY_NAME_COUT_AMELIORATION_CAPACITE_MISSILE")]];
    }
    
    else if ([type isEqualToString:@"AmeliorerTempsRechargementMissile"])
    {
        text = [NSString stringWithFormat:@"Améliorer le temps de rechargement des missiles : -%@ seconde / %@ coins",
                [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_TEMPS_DE_RECHARGEMENT_MISSILE", @"KEY_NAME_AMELIORATION_TEMPS_DE_RECHARGEMENT_MISSILE")],
                [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_MISSILE", @"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_MISSILE")]];
    }
    
    else if ([type isEqualToString:@"AmeliorerDegatsMissile"])
    {
        text = [NSString stringWithFormat:@"Améliorer les dégats infligés par les missiles : +%@ dégat(s) / %@ coins",
                [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_DEGATS_MISSILE", @"KEY_NAME_AMELIORATION_DEGATS_MISSILE")],
                [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_DEGATS_MISSILE", @"KEY_NAME_COUT_AMELIORATION_DEGATS_MISSILE")]];
    }
    
    else if ([type isEqualToString:@"AmeliorerTempsRechargementLaser"])
    {
        text = [NSString stringWithFormat:@"Améliorer le temps de rechargement des lasers : -%@ seconde / %@ coins",
                [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_TEMPS_DE_RECHARGEMENT_LASER", @"KEY_NAME_AMELIORATION_TEMPS_DE_RECHARGEMENT_LASER")],
                [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_LASER", @"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_LASER")]];
    }
    
    else if ([type isEqualToString:@"AmeliorerDegatsLaser"])
    {
        text = [NSString stringWithFormat:@"Améliorer les dégats infligés par les lasers : +%@ dégats / %@ coins",
                [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_DEGATS_LASER", @"KEY_NAME_AMELIORATION_DEGATS_LASER")],
                [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_DEGATS_LASER", @"KEY_NAME_COUT_AMELIORATION_DEGATS_LASER")]];
    }
    
    else if ([type isEqualToString:@"AmeliorerTempsRechargementBouclier"])
    {
        text = [NSString stringWithFormat:@"Amélioration le temps de rechargement des boucliers : -%@ seconde / %@ coins",
                [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_AMELIORATION_TEMPS_DE_RECHARGEMENT_BOUCLIER", @"KEY_NAME_AMELIORATION_TEMPS_DE_RECHARGEMENT_BOUCLIER")],
                [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_BOUCLIER", @"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_BOUCLIER")]];
    }
    
    [cell.textLabel setText:text];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.typesCellArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    NSArray *array = self.typesCellArray[section];
    
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   return self.sectionArray[section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] init];
    
    sectionView.backgroundColor = [UIColor grayColor];
    
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 2.5f, self.view.frame.size.width, 20.0f)];
    
    sectionLabel.shadowColor = [UIColor blackColor];
    
    sectionLabel.shadowOffset = CGSizeMake(0, 2);
    
    sectionLabel.textColor = [UIColor whiteColor];
    
    sectionLabel.textAlignment = NSTextAlignmentCenter;
    
    sectionLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    
    sectionLabel.text = self.sectionArray[section];
    
    [sectionView addSubview:sectionLabel];
    
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.typesCellArray[indexPath.section][indexPath.row] isEqualToString:@"EtatCoque"]
        || [self.typesCellArray[indexPath.section][indexPath.row] isEqualToString:@"Bouclier"]
        || [self.typesCellArray[indexPath.section][indexPath.row] isEqualToString:@"CapaciteMissile"]
        || [self.typesCellArray[indexPath.section][indexPath.row] isEqualToString:@"TempsRechargementMissile"]
        || [self.typesCellArray[indexPath.section][indexPath.row] isEqualToString:@"DegatsMissile"]
        || [self.typesCellArray[indexPath.section][indexPath.row] isEqualToString:@"TempsRechargementLaser"]
        || [self.typesCellArray[indexPath.section][indexPath.row] isEqualToString:@"DegatsLaser"]
        || [self.typesCellArray[indexPath.section][indexPath.row] isEqualToString:@"TempsRechargementBouclier"])
    {
        SpecificTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        cell.textLabel.numberOfLines = 0;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setTextAndImageCell:cell WithType:self.typesCellArray[indexPath.section][indexPath.row]];
        
        return cell;
    }
    
    else
    {
        SpecificWithoutImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellWithoutImage" forIndexPath:indexPath];
        
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        cell.textLabel.numberOfLines = 0;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        [self setTextCell:cell WithType:self.typesCellArray[indexPath.section][indexPath.row]];
        
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.typesCellArray[indexPath.section][indexPath.row] isEqualToString:@"EtatCoque"]
        || [self.typesCellArray[indexPath.section][indexPath.row] isEqualToString:@"Bouclier"]
        || [self.typesCellArray[indexPath.section][indexPath.row] isEqualToString:@"CapaciteMissile"]
        || [self.typesCellArray[indexPath.section][indexPath.row] isEqualToString:@"TempsRechargementMissile"]
        || [self.typesCellArray[indexPath.section][indexPath.row] isEqualToString:@"DegatsMissile"]
        || [self.typesCellArray[indexPath.section][indexPath.row] isEqualToString:@"TempsRechargementLaser"]
        || [self.typesCellArray[indexPath.section][indexPath.row] isEqualToString:@"DegatsLaser"]
        || [self.typesCellArray[indexPath.section][indexPath.row] isEqualToString:@"TempsRechargementBouclier"]
        || [self.activityIndicatorView isAnimating])
    {
        return;
    }
    [self.activityIndicatorView startAnimating];
    
    self.typeCellSelected = self.typesCellArray[indexPath.section][indexPath.row];
    
    UIAlertView *alertView = [[UIAlertView alloc] init];
    
    alertView.delegate = self;
    
    [alertView setAlertViewStyle:UIAlertViewStyleDefault];
    
    [alertView addButtonWithTitle:@"Confirmer"];
    
    [alertView addButtonWithTitle:@"Annuler"];
    
    [alertView setTitle:@"Confirmation"];
    
    if ([self.typeCellSelected isEqualToString:@"ReparerCoque"])
    {
        [alertView setMessage:[NSString stringWithFormat:@"Réparation du vaisseau : %@ coins",
                               [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_REPARATION_VAISSEAU", @"KEY_NAME_COUT_REPARATION_VAISSEAU")]]];
    }
    
    else if ([self.typeCellSelected isEqualToString:@"AmeliorerCoque"])
    {
        [alertView setMessage:[NSString stringWithFormat:@"Amélioration de la coque du vaisseau : %@ coins",
                               [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_COQUE", @"KEY_NAME_COUT_AMELIORATION_COQUE")]]];
    }
    
    else if ([self.typeCellSelected isEqualToString:@"AmeliorerBouclier"])
    {
        [alertView setMessage:[NSString stringWithFormat:@"Amélioration des boucliers : %@ coins",
                               [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_BOUCLIER", @"KEY_NAME_COUT_AMELIORATION_BOUCLIER")]]];
    }
    
    else if ([self.typeCellSelected isEqualToString:@"RacheterMissile"])
    {
        [alertView setMessage:[NSString stringWithFormat:@"Achat d'un missile : %@ coins",
                               [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_ACHAT_MISSILE", @"KEY_NAME_COUT_ACHAT_MISSILE")]]];
    }
    
    else if ([self.typeCellSelected isEqualToString:@"AmeliorerCapaciteMissile"])
    {
        [alertView setMessage:[NSString stringWithFormat:@"Amélioration du stockage des missiles : %@ coins",
                               [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_CAPACITE_MISSILE", @"KEY_NAME_COUT_AMELIORATION_CAPACITE_MISSILE")]]];
    }
    
    else if ([self.typeCellSelected isEqualToString:@"AmeliorerTempsRechargementMissile"])
    {
        [alertView setMessage:[NSString stringWithFormat:@"Amélioration du temps de rechargement des missiles : %@ coins",
                               [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_MISSILE", @"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_MISSILE")]]];
    }
    
    else if ([self.typeCellSelected isEqualToString:@"AmeliorerDegatsMissile"])
    {
        [alertView setMessage:[NSString stringWithFormat:@"Amélioration des dégats des missiles : %@ coins",
                               [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_DEGATS_MISSILE", @"KEY_NAME_COUT_AMELIORATION_DEGATS_MISSILE")]]];
    }
    
    else if ([self.typeCellSelected isEqualToString:@"AmeliorerTempsRechargementLaser"])
    {
        [alertView setMessage:[NSString stringWithFormat:@"Amélioration du temps de rechargement des lasers : %@ coins",
                               [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_LASER", @"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_LASER")]]];
    }
    
    else if ([self.typeCellSelected isEqualToString:@"AmeliorerDegatsLaser"])
    {
        [alertView setMessage:[NSString stringWithFormat:@"Amélioraion des dégats des lasers : %@ coins",
                               [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_DEGATS_LASER", @"KEY_NAME_COUT_AMELIORATION_DEGATS_LASER")]]];
    }
    
    else if ([self.typeCellSelected isEqualToString:@"AmeliorerTempsRechargementBouclier"])
    {
        [alertView setMessage:[NSString stringWithFormat:@"Amélioration du temps de rechargement des boucliers : %@ coins",
                               [self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_BOUCLIER", @"KEY_NAME_COUT_AMELIORATION_TEMPS_DE_RECHARGEMENT_BOUCLIER")]]];
    }
    
    [alertView show];
    
    [self.activityIndicatorView stopAnimating];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.activityIndicatorView startAnimating];
    
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Confirmer"])
    {
        UIAlertView *alertError = [[UIAlertView alloc] initWithTitle:@"Erreur de transaction" message:@"Capitaine, la transaction demandée n'a pas pu être effectuée. Nous manquons d'argents." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        BOOL achatDone = NO;
        
        if ([self.typeCellSelected isEqualToString:@"ReparerCoque"])
        {
            achatDone = [GestionnaireCaracteristiquesVaisseau reparationVaisseau:self.accueilViewController.sauvegarde];
            if (!achatDone)
            {
                [alertError show];
            }
        }
        
        else if ([self.typeCellSelected isEqualToString:@"AmeliorerCoque"])
        {
            achatDone = [GestionnaireCaracteristiquesVaisseau ameliorationCoque:self.accueilViewController.sauvegarde];
            if (!achatDone)
            {
                [alertError show];
            }
        }
        
        else if ([self.typeCellSelected isEqualToString:@"AmeliorerBouclier"])
        {
            achatDone = [GestionnaireCaracteristiquesVaisseau ameliorationBouclier:self.accueilViewController.sauvegarde];
            if (!achatDone)
            {
                [alertError show];
            }
        }
        
        else if ([self.typeCellSelected isEqualToString:@"RacheterMissile"])
        {
            BOOL achatDone = [GestionnaireCaracteristiquesVaisseau achatMissile:self.accueilViewController.sauvegarde];
            if (!achatDone)
            {
                [alertError show];
            }
        }
        
        else if ([self.typeCellSelected isEqualToString:@"AmeliorerCapaciteMissile"])
        {
            achatDone = [GestionnaireCaracteristiquesVaisseau ameliorationCapaciteMissile:self.accueilViewController.sauvegarde];
            if (!achatDone)
            {
                [alertError show];
            }
        }
        
        else if ([self.typeCellSelected isEqualToString:@"AmeliorerTempsRechargementMissile"])
        {
            achatDone = [GestionnaireCaracteristiquesVaisseau ameliorationTempsRechargementMissile:self.accueilViewController.sauvegarde];
            if (!achatDone)
            {
                [alertError show];
            }
        }
        
        else if ([self.typeCellSelected isEqualToString:@"AmeliorerDegatsMissile"])
        {
            achatDone = [GestionnaireCaracteristiquesVaisseau ameliorationDegatsMissile:self.accueilViewController.sauvegarde];
            if (!achatDone)
            {
                [alertError show];
            }
        }
        
        else if ([self.typeCellSelected isEqualToString:@"AmeliorerTempsRechargementLaser"])
        {
            achatDone = [GestionnaireCaracteristiquesVaisseau ameliorationTempsRechargementLaser:self.accueilViewController.sauvegarde];
            if (!achatDone)
            {
                [alertError show];
            }
        }
        
        else if ([self.typeCellSelected isEqualToString:@"AmeliorerDegatsLaser"])
        {
            achatDone = [GestionnaireCaracteristiquesVaisseau ameliorationDegatsLaser:self.accueilViewController.sauvegarde];
            if (!achatDone)
            {
                [alertError show];
            }
        }
        
        else if ([self.typeCellSelected isEqualToString:@"AmeliorerTempsRechargementBouclier"])
        {
            achatDone = [GestionnaireCaracteristiquesVaisseau ameliorationTempsRechargementBouclier:self.accueilViewController.sauvegarde];
            if (!achatDone)
            {
                [alertError show];
            }
        }
        
        if (achatDone)
        {
            [GestionnaireCaracteristiquesVaisseau setAllAmeliorations:self.accueilViewController.sauvegarde];
            
            [self.tableView reloadData];
            
            int coins = [[self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")] intValue];
            
            [self.buttonCoins setTitle:[NSString stringWithFormat:@"%d coins", coins]];
        }
    }
    
    [self.activityIndicatorView stopAnimating];
}

@end
