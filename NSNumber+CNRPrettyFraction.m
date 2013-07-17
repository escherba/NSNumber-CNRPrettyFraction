//
//  NSNumber+CNRPrettyFraction.m
//  Juicify
//
//  Created by Eugene Scherba on 5/10/13.
//
//  Category on NSNumber to display remainders using "pretty"
//  fractions: 1/4, 1/3, 1/2, 2/3, 3/4

#import "NSNumber+CNRPrettyFraction.h"

#define TO_B(x,a,b) ((x) - (a) > (b) - (x))

@implementation NSNumber (CNRPrettyFraction)

-(NSString*)prettyDisplayFraction
{
    // round to fractions at 1/4, 1/3, 1/2, 2/3, and 3/4 marks
    double fraction = [self doubleValue];
    int whole = floor(fraction);
    double remainder = fraction - (double)whole;
    
    // common situation -- if smaller than or equal to 1/8, set to zero
    
    NSString *wholeString = [NSString stringWithFormat:@"%d", whole];
    if (remainder <= 0.125f) {
        return wholeString;
    }
    
    // vulgar fractions (Unicode)
    const static NSString *one_fourth     = @"\u00bc";
    const static NSString *one_half       = @"\u00bd";
    const static NSString *three_quarters = @"\u00be";
    const static NSString *one_third      = @"\u2153";
    const static NSString *two_thirds     = @"\u2154";
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    if (whole != 0) {
        [result addObject:wholeString];
    } else if (fraction < 0.0f) {
        [result addObject:@"-"];
    }
    if (remainder > 0.5f) {
        // larger than 1/2
        if (remainder > 0.75f) {
            // larger than 3/4
            if (TO_B(remainder, 0.75f, 1.0f)) {
                return [NSString stringWithFormat:@"%d", whole + 1];
            } else {
                [result addObject:three_quarters];
            }
        } else {
            // smaller or equal to 3/4
            if (remainder > (2.0f/3.0f)) {
                // larger than 2/3, smaller than or equal to 3/4
                if (TO_B(remainder, (2.0f/3.0f), 0.75f)) {
                    [result addObject:three_quarters];
                } else {
                    [result addObject:two_thirds];
                }
            } else {
                // smaller than or equal to 2/3, larger than 1/2
                if (TO_B(remainder, 0.5f, (2.0f/3.0f))) {
                    [result addObject:two_thirds];
                } else {
                    [result addObject:one_half];
                }
            }
        }
    } else {
        // smaller ot equal to 1/2
        if (remainder < 0.25f) {
            // smaller than 1/4
            if (TO_B(remainder, 0.0f, 0.25f)) {
                [result addObject:one_fourth];
            } else {
                return [NSString stringWithFormat:@"%d", whole + 1];
            }
        } else {
            // larger than or equal to 1/4
            if (remainder < (1.0f/3.0f)) {
                // smaller than 1/3, larger than or equal to 1/4
                if (TO_B(remainder, 0.25f, (1.0f/3.0f))) {
                    [result addObject:one_third];
                } else {
                    [result addObject:one_fourth];
                }
            } else {
                // larger than or equal to 1/3, smaller than or equal to 1/2
                if (TO_B(remainder, (1.0f/3.0f), 0.5f)) {
                    [result addObject:one_half];
                } else {
                    [result addObject:one_third];
                }
            }
        }
    }
    NSString *finalResult = [result componentsJoinedByString:@""];
    return finalResult;
}


@end
