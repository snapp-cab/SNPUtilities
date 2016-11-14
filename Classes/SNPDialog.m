//
//  InformationDialogViewController.m
//  Snapp
//
//  Created by Apple on 10/30/16.
//  Copyright © 2016 Snapp. All rights reserved.
//

#import "SNPDialog.h"
#import "Theme.h"
#import <UIControl+BlocksKit.h>
#import "UIImage+animatedGIF.h"
#import "UIViewController+MJPopupViewController.h"

#define DECISION_COLOR [UIColor colorWithRed:0 green:178/255.f blue:189/255.f alpha:1]
#define ERROR_COLOR [UIColor colorWithRed:227/255.f green:57/255.f blue:77/255.f alpha:1]
#define INFORMATION_COLOR PRIMARY_COLOR//[UIColor colorWithRed:109/255.f green:195/255.f blue:39/255.f alpha:1]


@interface SNPDialog ()

// outlets
@property (nonatomic,retain) IBOutlet UILabel* titleImageLabel;
@property (nonatomic,retain) IBOutlet UILabel* titleLabel;
@property (nonatomic,retain) IBOutlet UILabel* messageLabel;
@property (nonatomic,retain) IBOutlet UIView* buttonsView;
@property (nonatomic,retain) IBOutlet UIView* bottomView;
@property (nonatomic,retain) IBOutlet UIView* contentView;
@property (nonatomic,retain) IBOutlet NSLayoutConstraint* bottomViewHeightConstraint;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint* contentViewHeightConstraint;
@property (nonatomic,weak) IBOutlet UIImageView* loadingImageView;


// private properties
@property (nonatomic,retain) NSString* positiveButtonTitle;
@property (nonatomic,retain) NSString* negativeButtonTitle;
@property (nonatomic,retain) NSString* otherButtonTitle;
@property (nonatomic,retain) NSString* titleText;
@property (nonatomic,retain) NSString* message;
@property (nonatomic,retain) NSString* titleImageText;
@property (nonatomic,retain) UIColor* themeColor;
@property (nonatomic,retain) NSArray<NSString*>* options;
@property (nonatomic,retain) UIPickerView* pickerView;
@property (nonatomic,retain) NSMutableArray* seperators;
@property (nonatomic,retain) UIView* blurView;
@property (nonatomic,assign) CGFloat spaceBetweenElements;


@property (nonatomic,retain) UILabel* pickerViewLastSelectedLabel;
@property (nonatomic,retain) UILabel* pickerViewSelectedLabel;

@end

@implementation SNPDialog

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - allocation:

-(instancetype) initWithImage:(NSString *)imageText andTitle:(NSString  *)title andMessage:(NSString *)message andStyle:(SNPDialogStyle)style andButtonArrangement:(SNPDialogButtonArrangement)arrangement{
    
    self = [super init];
    self.titleImageText = imageText;
    self.titleText = title;
    self.message = message;
    self.style = style;
    switch (style) {
        case SNPDialogStyleError:
            self.themeColor = ERROR_COLOR;
            break;
        case SNPDialogStyleDecision:
            self.themeColor = DECISION_COLOR;
            break;
        case SNPDialogStyleInformation:
            self.themeColor = INFORMATION_COLOR;
            break;
            
        default:
            break;
    }
    self.buttonArrangement = arrangement;
    if (!imageText){
        return [self initWithTitle:title andMessage:message andStyle:style andButtonArrangement:arrangement];
    }
    
    if (self){
        self.view = [[[NSBundle mainBundle] loadNibNamed:@"SNPDialogWithTitleAndImage" owner:self options:nil] firstObject];
        self.spaceBetweenElements = 90;
        [self setupView];
        
    }
    return self;
}

-(instancetype) initWithTitle:(NSString  *)title andMessage:(NSString *)message andStyle:(SNPDialogStyle)style andButtonArrangement:(SNPDialogButtonArrangement)arrangement{
    if (!title || title.length  == 0){
        return  [self initWithMessage:message andStyle:style andButtonArrangement:arrangement];
    }
    if (self){
        self.view = [[[NSBundle mainBundle] loadNibNamed:@"SNPDialogWithTitle" owner:self options:nil] firstObject];
        self.spaceBetweenElements = 60;

        [self setupView];
        
    }
    return self;
}

-(instancetype) initWithMessage:(NSString *)message andStyle:(SNPDialogStyle)style andButtonArrangement:(SNPDialogButtonArrangement)arrangement{
    if (self){
        self.view = [[[NSBundle mainBundle] loadNibNamed:@"SNPDialog" owner:self options:nil] firstObject];
        self.spaceBetweenElements = 60;

        [self setupView];
        
    }
    return self;
}

-(void) addButtonWithTitle:(NSString*)title andCallback:(void (^)(void) )callback{
    if (!self.buttons){
        self.buttons = [NSMutableArray new];
    }
    UIButton* b = [[UIButton alloc]init];
    [b setTitle:title forState:UIControlStateNormal];
    [b bk_addEventHandler:^(id sender) {
        callback();
    } forControlEvents:UIControlEventTouchUpInside];
    [self.buttons addObject:b];
    [self setupButtons];
    
}



#pragma mark - Setters:
-(void) setLoadingMode:(BOOL)loadingMode{
    if (loadingMode){
        [self.buttonsView setHidden:YES];
        [self.loadingImageView setHidden:NO];
        NSURL *urlForGif = [[NSBundle mainBundle] URLForResource:@"snapp_loading_white" withExtension:@"gif"];
        [self.loadingImageView setImage:[UIImage animatedImageWithAnimatedGIFURL:urlForGif]];
    }else{
        [self.buttonsView setHidden:NO];
        [self.loadingImageView setHidden:YES];
    }
}

#pragma mark -
-(NSInteger) getOptionsSelectedIndex{
    if (!self.pickerView){
        NSLog(@"The dialog is not in option mode");
        return -1;
    }
    return [self.pickerView selectedRowInComponent:0];
}


#pragma mark - View setup methods:

-(void) setupView{
    self.view.layer.cornerRadius = 4;
    self.titleImageLabel.text = self.titleImageText;
    self.titleLabel.text = self.titleText;
    self.messageLabel.text = self.message;
    [self.titleImageLabel setTextColor:self.themeColor];
    CGRect rect = [self.message boundingRectWithSize:CGSizeMake((0.8 * [UIScreen mainScreen].bounds.size.width) - 32, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.messageLabel.font} context:nil];
    
    self.view.frame = CGRectMake(0, 0, 0.8 * [UIScreen mainScreen].bounds.size.width, rect.size.height + self.titleLabel.frame.size.height + self.titleImageLabel.frame.size.height + self.bottomView.frame.size.height + self.spaceBetweenElements );
    
    [self.bottomView setBackgroundColor:self.themeColor];
    [self.view layoutIfNeeded];
    
    
}

-(void) setupButtons{
    
    if (self.buttonArrangement == SNPDialogButtonArrangementVertical){
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + (self.bottomView.frame.size.height * ([self.buttons count] -1 )));
        self.bottomViewHeightConstraint.constant = self.bottomViewHeightConstraint.constant *  [self.buttons count] ;
        [self.view layoutIfNeeded];
    }
    
    // since frame of buttons changed , we must set the separators again
    for (UIView* s in self.seperators){
        [s removeFromSuperview];
    }
    [self.seperators removeAllObjects];
    
    for (UIButton* b in self.buttons){
        if (self.buttonArrangement == SNPDialogButtonArrangementHorizontal){
            b.frame  = CGRectMake([self.buttons indexOfObject:b] * self.buttonsView.frame.size.width / [self.buttons count], 0, self.buttonsView.frame.size.width / [self.buttons count], self.buttonsView.frame.size.height);
        }else {
            b.frame  = CGRectMake(0, [self.buttons indexOfObject:b] * self.buttonsView.frame.size.height / [self.buttons count] , self.buttonsView.frame.size.width, self.buttonsView.frame.size.height / [self.buttons count] );
        }
        
        [b.titleLabel setFont:normal_font_of(14)];
        [b setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [b setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
        [b setTitleColor:[UIColor colorWithWhite:1 alpha:0.3] forState:UIControlStateDisabled];
        [self.buttonsView addSubview:b];
        
        
        // setup seperators
        if([self.buttons count] > 1){
            UIView* seperator = [[UIView alloc]init];
            if (!self.seperators){
                self.seperators = [NSMutableArray new];
            }
            if (self.buttonArrangement == SNPDialogButtonArrangementHorizontal){
                seperator.frame = CGRectMake(b.frame.origin.x + b.frame.size.width, self.buttonsView.frame.size.height /4, 1, self.buttonsView.frame.size.height /2);
            }else{
                seperator.frame = CGRectMake( self.buttonsView.frame.size.width/4, b.frame.origin.y + b.frame.size.height, self.buttonsView.frame.size.width /2 , 1);
            }
            [seperator setBackgroundColor:WHITE_COLOR];
            seperator.alpha = 0.5;
            [self.seperators addObject:seperator];
            [self.buttonsView addSubview:seperator];
        }
    }
}

-(void) setupTextInputMode{
    self.contentViewHeightConstraint.constant = 50;
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(3, 0, self.contentView.frame.size.width - 6 , self.contentViewHeightConstraint.constant - 2)];

    self.textField.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.textField];
    
    // the line
    UIView* line = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentViewHeightConstraint.constant - 10, self.contentView.frame.size.width, 2)];
    [line setBackgroundColor:self.themeColor];
    [self.contentView addSubview:line];
    
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + self.contentViewHeightConstraint.constant + 16);
    [self.view layoutIfNeeded];
    
}

-(void) setupOptionsModeWithOptions:(NSArray<NSString *>*)options{
    self.options = options;
    self.contentViewHeightConstraint.constant = 100;
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentViewHeightConstraint.constant)];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self.contentView addSubview:self.pickerView];
    
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + self.contentViewHeightConstraint.constant + 16);
    [self.view layoutIfNeeded];
    [self.pickerView reloadAllComponents];
    
    
}

#pragma mark - UIPickerViewDataSource:

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.options count];
}

#pragma mark - UIPickerViewDelegate:

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
    UILabel* label = nil;
    if (view == nil) {
        view = [[UIView alloc] init];
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, pickerView.frame.size.height/3)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = PRIMARY_TEXT_COLOR;
        label.font = normal_font_of(16);
        [view addSubview:label];
    }
    if (row == [pickerView selectedRowInComponent:0]){
        label.textColor = self.themeColor;
    }
    if (label == nil) {
        label = view.subviews[0];
    }
    
    label.text = [self.options objectAtIndex:row];
    return view;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (self.pickerViewLastSelectedLabel != nil)
        self.pickerViewLastSelectedLabel.textColor = PRIMARY_TEXT_COLOR;
    
    self.pickerViewSelectedLabel =  [[(UILabel*)[pickerView viewForRow:row forComponent:component] subviews]firstObject];
    self.pickerViewSelectedLabel.textColor = self.themeColor;
    [self.pickerViewSelectedLabel setNeedsDisplay];
    self.pickerViewLastSelectedLabel = self.pickerViewSelectedLabel;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35;
}



#pragma mark - show
-(void) show{
    if (self.presentorViewController){
        [self.presentorViewController setShouldCloseOnOutsideTouch:self.shouldCloseOnOutsideTouch];
        [self.presentorViewController presentPopupViewController:self animationType:MJPopupViewAnimationFade];
    }else{
        self.blurView = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
        [self.blurView setBackgroundColor:[UIColor blackColor]];
        [self.blurView setAlpha:0];
        self.view.center = [UIApplication sharedApplication].keyWindow.center;
        self.view.alpha = 0 ;
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.blurView];
        [[UIApplication sharedApplication].keyWindow addSubview:self.view];
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.view setAlpha:1];
            [self.blurView setAlpha:0.5];
        }];
    }
}

-(void) dismiss{
    if (self.presentorViewController) {
        [self.presentorViewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    }else{
    [UIView animateWithDuration:0.5 animations:^{
        [self.view setAlpha:0];
        [self.blurView setAlpha:0];
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self.blurView removeFromSuperview];
    }];
    }
}

@end
