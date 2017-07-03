//
//  ViewController.m
//  Test_Attribute
//
//  Created by 鹏 刘 on 2017/6/23.
//  Copyright © 2017年 鹏 刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIStepper *stepper;
@property (nonatomic, strong) UILabel *selectedLabel;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIButton *colorBt;
@property (nonatomic, strong) UIButton *fontBt;
@property (nonatomic, strong) UIButton *lineBt;
@property (nonatomic, strong) UIButton *noLineBt;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createStepper];
    [self createLabel];
    [self createTextLabel];
    [self changeColorButton];
    [self changeFontButton];
    [self changeLineButton];
    [self deleteLine];
}

- (void)createStepper
{
    self.stepper = [[UIStepper alloc] initWithFrame:CGRectMake(10, 30, 100, 70)];
    self.stepper.backgroundColor = [UIColor whiteColor];
    [self.stepper addTarget:self action:@selector(updateSelected:) forControlEvents:UIControlEventValueChanged];
    // self.stepper.minimumValue = 0;
   // self.stepper.maximumValue = [self selectedWorld].length;
    
    [self.view addSubview:self.stepper];
}

- (IBAction)updateSelected:(id)sender
{
    self.stepper.maximumValue = [self worldList].count - 1;
    self.selectedLabel.text = [self selectedWorld];
    
    [self addTextLabelAttribute:@{NSBackgroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, [self.textLabel.attributedText length])];
    [self addSelectedLabelAttribute:@{NSBackgroundColorAttributeName:[UIColor yellowColor]}];
}

- (void)addTextLabelAttribute:(NSDictionary *)attribute range:(NSRange)range
{
    NSMutableAttributedString *ms = [self.textLabel.attributedText mutableCopy];
    if (ms) {
        [ms addAttributes:attribute range:range];
    }
    self.textLabel.attributedText = ms;
}

- (void)addSelectedLabelAttribute:(NSDictionary *)attribute
{
    NSRange range = [[self.textLabel.attributedText string] rangeOfString:[self selectedWorld]];
    [self addTextLabelAttribute:attribute range:range];
}

- (void)createLabel
{
    self.selectedLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 7, 160, 70)];
    //self.textLabel.text = [self selectedWorld];
    self.selectedLabel.backgroundColor = [UIColor whiteColor];
    self.selectedLabel.text = @"Selected World";
    self.selectedLabel.font = [UIFont fontWithName:@"Helvetica" size:19];
    self.textLabel.textColor = [UIColor blackColor];
    self.selectedLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.selectedLabel];
}

- (void)createTextLabel
{
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, self.view.bounds.size.width, 300)];
    self.textLabel.backgroundColor = [UIColor whiteColor];
    self.textLabel.numberOfLines = 0;
    
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    ps.lineSpacing = 9.0;
   // ps.lineBreakMode = NSLineBreakByClipping;
    ps.paragraphSpacing = 12.0;
    ps.headIndent = 9;
   
    NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:@"CS193p is the most awesome class at Stanford!"];
    [as addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:40] range:NSMakeRange(0, as.length)];
    [as addAttribute:NSParagraphStyleAttributeName value:ps range:NSMakeRange(0, as.length)];
    
    self.textLabel.attributedText = as;
    [self.view addSubview:self.textLabel];
}

- (NSArray *)worldList
{
    NSArray *list = [[self.textLabel.attributedText string] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([list count]) {
        return list;
    }
    else {
        return @[@""];
    }
}

- (NSString *)selectedWorld
{
    return [self worldList][(int)self.stepper.value];
}

#define x_button 25
- (void)changeColorButton
{
    NSArray *title = [[NSArray alloc] initWithObjects:@"Orange",@"Blue",@"Green",@"Black", nil];
    NSArray *color = [[NSArray alloc] initWithObjects:[UIColor orangeColor],[UIColor blueColor],[UIColor greenColor],[UIColor blackColor], nil];

    for (int i = 0; i < 4; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x_button + (55 + x_button) * i, 320, 70, 70)];
        btn.titleLabel.font = [UIFont fontWithName:@"Bold" size:18.5];
        [btn setTitle:[title objectAtIndex:i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[color objectAtIndex:i]];
        [btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:btn];
    }

}

- (IBAction)tap:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Orange"]) {
        [self addSelectedLabelAttribute:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    }
    else if ([sender.titleLabel.text isEqualToString:@"Blue"]) {
        [self addSelectedLabelAttribute:@{NSForegroundColorAttributeName:[UIColor blueColor]}];
    }
    else if ([sender.titleLabel.text isEqualToString:@"Green"]) {
        [self addSelectedLabelAttribute:@{NSForegroundColorAttributeName:[UIColor greenColor]}];
    }
    else if ([sender.titleLabel.text isEqualToString:@"Black"]) {
        [self addSelectedLabelAttribute:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    }

}

#define X_Button 55
- (void)changeFontButton
{
    NSArray *fontTitle = [[NSArray alloc] initWithObjects:@"Bold", @"Normal",@"Italic",nil];
  //  NSArray *fontArray = [[NSArray alloc] initWithObjects:[UIFont fontWithName:@"Bold" size:12.5],[UIFont fontWithName:@"Normal" size:12.5],[UIFont fontWithName:@"Italic" size:12.5], nil];
    
    for (int i = 0; i < fontTitle.count; i ++) {
        UIButton *fontBt = [[UIButton alloc] initWithFrame:CGRectMake(X_Button + (X_Button + 30) * i, 430, 75, 55)];
        fontBt.titleLabel.font = [UIFont fontWithName:@"bold" size:18.5];
        [fontBt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [fontBt setTitle:[fontTitle objectAtIndex:i] forState:UIControlStateNormal];
        [fontBt addTarget:self action:@selector(changeFont:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:fontBt];
    }
}

- (IBAction)changeFont:(UIButton *)sender
{
   /* CGFloat fontSize = [UIFont systemFontSize];
    
    // next two lines added after lecture
    
    NSRange range = [[self.textLabel.attributedText string] rangeOfString:[self selectedWorld]];
    if (range.location != NSNotFound) {
        NSDictionary *attributes = [self.textLabel.attributedText attributesAtIndex:range.location // was 0 in lecture
                                                                 effectiveRange:NULL];
        UIFont *existingFont = attributes[NSFontAttributeName];
        if (existingFont) fontSize = existingFont.pointSize;
    }
    
    UIFont *font = [sender.titleLabel.font fontWithSize:fontSize];
    [self addSelectedLabelAttribute:@{NSFontAttributeName : font}];
   */

    if ([sender.titleLabel.text isEqualToString:@"Bold"]) {
        [self addSelectedLabelAttribute:@{NSFontAttributeName : [UIFont fontWithName:@"Bold" size:40]}];
    }
    else if ([sender.titleLabel.text isEqualToString:@"Normal"]) {
        [self addSelectedLabelAttribute:@{NSFontAttributeName : [UIFont fontWithName:@"Normal" size:40]}];
    }
    else if ([sender.titleLabel.text isEqualToString:@"Italic"]) {
        [self addSelectedLabelAttribute:@{NSFontAttributeName : [UIFont fontWithName:@"Italic" size:40]}];
    }

}

#define X_Space 60
- (void)changeLineButton
{
    NSArray *titleArr = [[NSArray alloc] initWithObjects:@"Underline",@"Outline", nil];
    
    for (int i = 0; i < titleArr.count; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(X_Space + (X_Space + 45) * i, 485, 85, 55)];
        [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changeLine:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:btn];
    }
}

- (IBAction)changeLine:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Underline"]) {
        [self addSelectedLabelAttribute:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
    }
    else {
        [self addSelectedLabelAttribute:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone)}];
    }
}

#define button_space 60
- (void)deleteLine
{
    NSArray *titleArr = [[NSArray alloc] initWithObjects:@"No Underline",@"No Outline", nil];
    
    for (int i = 0; i < titleArr.count; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(button_space + (button_space + 75) * i, 555, 120, 55)];
        [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(delLine:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:btn];
    }
}

- (IBAction)delLine:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"No Underline"]) {
        [self addSelectedLabelAttribute:@{NSStrokeWidthAttributeName:@5}];
    }
    else {
        [self addSelectedLabelAttribute:@{NSStrokeWidthAttributeName:@0}];
    }
}


@end
