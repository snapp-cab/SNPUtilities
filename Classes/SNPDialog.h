//
//  InformationDialogViewController.h
//  Snapp
//
//  Created by Apple on 10/30/16.
//  Copyright © 2016 Snapp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SNPDialogStyle) {
    SNPDialogStyleInformation,
    SNPDialogStyleError,
    SNPDialogStyleDecision,
};

typedef NS_ENUM(NSUInteger, SNPDialogButtonArrangement) {
    SNPDialogButtonArrangementVertical,
    SNPDialogButtonArrangementHorizontal,
};



@interface SNPDialog : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,assign) BOOL loadingMode;
@property (nonatomic,assign) BOOL shouldCloseOnOutsideTouch;

@property (nonatomic,retain) UITextField* textField;
@property (nonatomic,retain) NSMutableArray* buttons;

@property (nonatomic,assign) SNPDialogStyle style;
@property (nonatomic,assign) SNPDialogButtonArrangement buttonArrangement;

@property (nonatomic,retain) UIViewController* presentorViewController;


-(instancetype) initWithImage:(NSString *)imageText andTitle:(NSString  *)title andMessage:(NSString *)message andStyle:(SNPDialogStyle)style andButtonArrangement:(SNPDialogButtonArrangement)arrangement;


-(void) addButtonWithTitle:(NSString*)title andCallback:(void (^)(void) )callback;


-(void) setupTextInputMode;
-(void) setupOptionsModeWithOptions:(NSArray<NSString *>*)options;

-(NSInteger) getOptionsSelectedIndex;


// if we set presentorViewController, the dialog will present through it , other wise the dialog will add to UIWindow  
-(void) show;
-(void) dismiss;

@end
