//
//  GestionnaireAnimationAsteroide.h
//  DarkAvenger
//
//  Created by Thomas Mac on 02/09/2015.
//  Copyright (c) 2015 ThomasNeyraut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AsteroideObject.h"

@interface GestionnaireAnimationAsteroide : NSObject

#pragma initialisation

- (void) initialisation;

#pragma gestion object

- (void) addAsteroide:(AsteroideObject *)asteroide;

- (void) removeAsteroide:(AsteroideObject *)asteroide;

- (void) removeGestionnaireAnimationAsteroide;

@end
