//
//  MenuMissionsTableViewController.m
//  DarkAvenger
//
//  Created by Thomas Mac on 08/08/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import "MenuMissionsTableViewController.h"
#import "GameViewController.h"

#import "SpecificTableViewCell.h"

#import "GestionnaireCaracteristiquesMission.h"

@interface MenuMissionsTableViewController ()

@property(nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation MenuMissionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:NO];
    
    [self.tableView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1]];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[SpecificTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self setTitle:@"Journal de bord"];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [self.activityIndicatorView setCenter:CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0)];
    
    [self.activityIndicatorView setColor:[UIColor whiteColor]];
    [self.activityIndicatorView setHidesWhenStopped:YES];
    
    [self.tableView addSubview:self.activityIndicatorView];
    
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
    [self.navigationController.navigationBar setHidden:NO];
    
    [self.tableView reloadData];
    
    [self.navigationController setToolbarHidden:YES animated:YES];
    
    [super viewDidAppear:animated];
}

- (BOOL) prefersStatusBarHidden
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [[self.accueilViewController.sauvegarde objectForKey:NSLocalizedString(@"KEY_NAME_LAST_MISSION_NUMBER", @"KEY_NAME_LAST_MISSION_NUMBER")] intValue];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Mission N°%d", (int)(section + 1)];
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
    
    sectionLabel.text = [NSString stringWithFormat:@"Mission N°%d", (int)(section + 1)];
    
    [sectionView addSubview:sectionLabel];
    
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SpecificTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row != 2)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    cell.textLabel.numberOfLines = 0;
    
    [self setImageAndTextCell:cell WithIndice:(int)indexPath.row AndLevel:(int)indexPath.section + 1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 2 || [self.activityIndicatorView isAnimating])
    {
        return;
    }
    [self.activityIndicatorView startAnimating];
    
    [self.accueilViewController.sauvegarde setObject:[NSString stringWithFormat:@"%d", [GestionnaireCaracteristiquesMission getRecompenseXPMissionWithLevel:(int)indexPath.section + 1]]
                                              forKey:NSLocalizedString(@"KEY_NAME_RECOMPENSE_XP_MISSION", @"KEY_NAME_RECOMPENSE_XP_MISSION")];
    
    [self.accueilViewController.sauvegarde setObject:[NSString stringWithFormat:@"%d", [GestionnaireCaracteristiquesMission getRecompenseCoinsMissionWithLevel:(int)indexPath.section + 1]]
                                              forKey:NSLocalizedString(@"KEY_NAME_RECOMPENSE_COINS_MISSION", @"KEY_NAME_RECOMPENSE_COINS_MISSION")];
    
    [self.accueilViewController.sauvegarde setObject:[NSString stringWithFormat:@"%d", (int)(indexPath.section + 1)]
                                              forKey:NSLocalizedString(@"KEY_NAME_LEVEL_CHOISI", @"KEY_NAME_LEVEL_CHOISI")];
    
    GameViewController *gameViewController = [[GameViewController alloc] init];
    
    gameViewController.menuMissionsTableViewController = self;
    
    [self.navigationController pushViewController:gameViewController animated:YES];
    
    [self.activityIndicatorView stopAnimating];
}

- (void) setImageAndTextCell:(SpecificTableViewCell *)cell WithIndice:(int)indice AndLevel:(int)level
{
    NSString *text;
    NSString *imageName;
    
    if (indice == 0)
    {
        text = [NSString stringWithFormat:@"Récompense : %d XP", [GestionnaireCaracteristiquesMission getRecompenseXPMissionWithLevel: level]];
        
        imageName = NSLocalizedString(@"IMAGE_NAME_ICON_XP", @"IMAGE_NAME_ICON_XP");
    }
    
    else if (indice == 1)
    {
        text = [NSString stringWithFormat:@"Récompense : %d coins", [GestionnaireCaracteristiquesMission getRecompenseCoinsMissionWithLevel: level]];
        
        imageName = NSLocalizedString(@"IMAGE_NAME_ICON_COINS", @"IMAGE_NAME_ICON_COINS");
    }
    
    else if (indice == 2)
    {
        text = @"Lancer la mission";
        
        imageName = NSLocalizedString(@"IMAGE_NAME_VAISSEAU", @"IMAGE_NAME_VAISSEAU");
    }
    
    [cell.textLabel setText:text];
    
    [cell.imageView setImage:[UIImage imageNamed:imageName]];
}

@end
