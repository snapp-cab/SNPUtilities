//
//  NSAttributedString+AddAttribute.h
//  Snapp
//
//  Created by Arash Z.Jahangiri on 12/9/17.
//  Copyright © 2017 Snapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (AddAttribute)
- (NSAttributedString *)addAttribute:(NSString *)inputString withColor:(UIColor *)color startPosition:(NSRange)range;
@end
