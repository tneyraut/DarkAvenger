//
//  AccueilViewController.m
//  DarkAvenger
//
//  Created by Thomas Mac on 06/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import "AccueilViewController.h"
#import "CreditsViewController.h"
#import "MenuVaisseauTableViewController.h"
#import "MenuMissionsTableViewController.h"

#import "SpecificTableViewCell.h"
#import "SpecificWithoutImageTableViewCell.h"

#import "GestionnaireCaracteristiquesVaisseau.h"

@interface AccueilViewController () <UIAlertViewDelegate>

@property(nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation AccueilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.scrollEnabled = NO;
    
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
    
    [self setTitle:@"Journal de bord"];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [self.activityIndicatorView setCenter:CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0)];
    
    [self.activityIndicatorView setColor:[UIColor whiteColor]];
    [self.activityIndicatorView setHidesWhenStopped:YES];
    
    [self.tableView addSubview:self.activityIndicatorView];
    
    self.sauvegarde = [NSUserDefaults standardUserDefaults];
    
    if (![self.sauvegarde objectForKey:@"profil"])
    {
        [GestionnaireCaracteristiquesVaisseau initialisationCaracteristiquesVaisseau:self.sauvegarde];
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        
        alertView.delegate = self;
        
        [alertView setAlertViewStyle:UIAlertViewStyleDefault];
        
        [alertView setTitle:@"Saluation Capitaine"];
        
        [alertView setMessage:@"Le conseil galactique a besoin de vos services. Le criminel de guerre connu sous le nom de Dark Avenger a été repéré près de votre position. Le conseil vous demande de procéder à l'interception de son vaisseau. Attention, n'oubliez pas que Dark Avenger est le criminel le plus dangereux de la galaxie. Pour vous préparer au mieux à l'affronter le conseil vous transmet quelques vivres qui vous seront fortes utiles."];
        
        [alertView addButtonWithTitle:@"Bien reçu. Terminé."];
        
        [alertView show];
    }
    
    // Do any additional setup after loading the view.
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
    
    int coins = [[self.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_COINS", @"KEY_NAME_COINS")] intValue];
    
    int xpNextLevel = [[self.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_XP_OBJECTIF", @"KEY_NAME_XP_OBJECTIF")] intValue];
    
    int xpAccumules = [[self.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_XP_ACCUMULES", @"KEY_NAME_XP_ACCUMULES")] intValue];
    
    int level = [[self.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_LEVEL", @"KEY_NAME_LEVEL")] intValue];
    
    UIBarButtonItem *buttonCoinsXPLevel = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%d coins    %dniv.    %dxp / %d", coins, level, xpAccumules, xpNextLevel]
                                                        style:UIBarButtonItemStylePlain
                                                       target:nil
                                                       action:nil];
    
    [buttonCoinsXPLevel setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName, shadow, NSShadowAttributeName, [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil
                                      action:nil];
    
    [self.navigationController.toolbar setItems:@[ flexibleSpace, buttonCoinsXPLevel, flexibleSpace ]];
    
    [super viewDidAppear:animated];
}

- (BOOL) prefersStatusBarHidden
{
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.activityIndicatorView startAnimating];
    
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Bien reçu. Terminé."])
    {
        UIAlertView *alertView = [[UIAlertView alloc] init];
        
        alertView.delegate = self;
        
        [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        
        [alertView setTitle:@"Pseudo"];
        
        [alertView setMessage:@"Veuillez rentrer un pseudo"];
        
        [[alertView textFieldAtIndex:0] setPlaceholder:@"Pseudo"];
        
        [alertView addButtonWithTitle:@"Valider"];
        
        [alertView show];
    }
    
    else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Valider"])
    {
        if ([[alertView textFieldAtIndex:0].text isEqualToString:@""])
        {
            [alertView show];
        }
        else
        {
            [self.sauvegarde setObject:[alertView buttonTitleAtIndex:buttonIndex] forKey:@"profil"];
            
            [self.sauvegarde synchronize];
        }
    }
    
    [self.activityIndicatorView stopAnimating];
}

- (void) setTextAndImageCell:(SpecificTableViewCell *)cell WithIndice:(int)indice
{
    NSString *imageName;
    
    NSString *text;
    
    if (indice == 0)
    {
        imageName = NSLocalizedString(@"IMAGE_NAME_BUTTON_MISSION", @"IMAGE_NAME_BUTTON_MISSION");
        
        text = @"Accéder aux missions";
    }
    
    else if (indice == 1)
    {
        imageName = NSLocalizedString(@"IMAGE_NAME_VAISSEAU", @"IMAGE_NAME_VAISSEAU");
        
        text = @"Accéder au vaisseau";
    }
    
    else if (indice == 2)
    {
        imageName = NSLocalizedString(@"IMAGE_NAME_BUTTON_CREDITS", @"IMAGE_NAME_BUTTON_CREDITS");
        
        text = @"Les crédits";
    }
    
    [cell.imageView setImage:[UIImage imageNamed:imageName]];
    
    [cell.textLabel setText:text];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpecificTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    [self setTextAndImageCell:cell WithIndice:(int)indexPath.row];
        
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
    cell.textLabel.numberOfLines = 0;
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.activityIndicatorView isAnimating])
    {
        return;
    }
    [self.activityIndicatorView startAnimating];
    
    if (indexPath.row == 0)
    {
        MenuMissionsTableViewController *menuMissionsTableViewController = [[MenuMissionsTableViewController alloc] initWithStyle:UITableViewStylePlain];
        
        menuMissionsTableViewController.accueilViewController = self;
        
        [self.navigationController pushViewController:menuMissionsTableViewController animated:YES];
    }
    
    else if (indexPath.row == 1)
    {
        MenuVaisseauTableViewController *menuVaisseauTableViewController = [[MenuVaisseauTableViewController alloc] initWithStyle:UITableViewStylePlain];
        
        menuVaisseauTableViewController.accueilViewController = self;
        
        [self.navigationController pushViewController:menuVaisseauTableViewController animated:YES];
    }
    
    else if (indexPath.row == 2)
    {
        CreditsViewController *creditsViewController = [[CreditsViewController alloc] initWithStyle:UITableViewStylePlain];
        
        [self.navigationController pushViewController:creditsViewController animated:YES];
    }
    
    [self.activityIndicatorView stopAnimating];
}

@end
