//
//  NSAttributedString+AddAttribute.m
//  Snapp
//
//  Created by Arash Z.Jahangiri on 12/9/17.
//  Copyright © 2017 Snapp. All rights reserved.
//

#import "NSAttributedString+AddAttribute.h"
#import "Theme.h"
@implementation NSAttributedString (AddAttribute)
- (NSAttributedString *)addAttribute:(NSString *)inputString withColor:(UIColor *)color startPosition:(NSRange)range {
    printf("%ld", (unsigned long)inputString.length);
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:inputString];
    if (range.length + range.location > [inputString length]) {
        return self;
    }
    [string addAttribute:NSForegroundColorAttributeName value:color range:range];
    [string addAttribute:NSFontAttributeName value:medium_font_of(15) range:range];
    return string;
}
@end
