//
//  NSNumber+CNRPrettyFraction.h
//  Juicify
//
//  Created by Eugene Scherba on 5/10/13.
//
//  Category on NSNumber to display remainders using "pretty"
//  fractions: 1/4, 1/3, 1/2, 2/3, 3/4

#import <Foundation/Foundation.h>

@interface NSNumber (CNRPrettyFraction)

-(NSString*)prettyDisplayFraction;

@end
