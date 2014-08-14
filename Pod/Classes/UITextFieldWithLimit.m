//
//  UITextFieldWithLimit.m
//  UITextFieldWithLimit
//

#import "UITextFieldWithLimit.h"
#import "_UITextFieldWithLimitProxyObject.h"

@interface UITextFieldWithLimit ()
@property(nonatomic, copy) NSString *previousText;
@property(nonatomic) NSRange lastReplaceRange;
@property(nonatomic, copy) NSString *lastReplacementString;

@property(nonatomic, weak) id <UITextFieldDelegate> realDelegate;
@property(nonatomic, strong) _UITextFieldWithLimitProxyObject *proxyObject;
@end

@implementation UITextFieldWithLimit
- (id)initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.maxLength = [self defaultMaxLength];
        [self initializeLimit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *) inCoder {
    self = [super initWithCoder:inCoder];
    if (self) {
        self.maxLength = @10;
        [self initializeLimit];
    }
    return self;
}

- (void)setDelegate:(id <UITextFieldDelegate>) delegate {
    if (delegate != self) {
        self.realDelegate = delegate;
    }
}

- (NSNumber *)defaultMaxLength {
    return @10;
}

- (void)initializeLimit {
    self.proxyObject = [[_UITextFieldWithLimitProxyObject alloc] init];
    self.proxyObject.delegate = self;
    [super setDelegate:self.proxyObject];

    [self initializeLimitLabelWithFont:[UIFont fontWithName:@"AppleSDGothicNeo-Light" size:self.font.pointSize] andTextColor:[UIColor redColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textFieldBegin:) name:UITextFieldTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textFieldDidEnd:) name:UITextFieldTextDidEndEditingNotification object:self];

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)_textFieldDidChange:(NSNotification *) notification {
    UITextField *textField = (UITextField *)notification.object;
    [self updateLimitedTextField:textField];

}

- (void)updateLimitedTextField:(UITextField *) textField {
    if (textField.markedTextRange) {
        return;
    }

    if ([textField.text length] == self.maxLength.integerValue) {//Did reach limit
        if ([self.limitDelegate respondsToSelector:@selector(textFieldLimit:didReachLimitWithLastEnteredText:inRange:)]) {
            [self.limitDelegate textFieldLimit:self didReachLimitWithLastEnteredText:self.lastReplacementString inRange:NSMakeRange(self.lastReplaceRange.location, self.lastReplaceRange.length)];
        }
    }
    if ([textField.text length] > self.maxLength.integerValue) {
        [self shakeLabel];
        if ([self.limitDelegate respondsToSelector:@selector(textFieldLimit:didWentOverLimitWithDisallowedText:inDisallowedRange:)]) {
            [self.limitDelegate textFieldLimit:self didWentOverLimitWithDisallowedText:self.lastReplacementString inDisallowedRange:NSMakeRange(self.lastReplaceRange.location, self.lastReplaceRange.length)];
        }
        NSInteger offset = self.maxLength.integerValue - [textField.text length];
        NSString *replacementString;
        if ([self.lastReplacementString length] < ABS(offset)) {
            replacementString = @"";// to empty
        } else {
            replacementString = [self.lastReplacementString substringToIndex:([self.lastReplacementString length] + offset)];
        }
        NSString *text = [self.previousText stringByReplacingCharactersInRange:self.lastReplaceRange withString:replacementString];

        UITextPosition *position = [textField positionFromPosition:textField.selectedTextRange.start offset:offset];
        UITextRange *selectedTextRange = [textField textRangeFromPosition:position toPosition:position];
        textField.text = text;
        textField.selectedTextRange = selectedTextRange;

    }
    [self.limitLabel setText:[@(self.maxLength.integerValue - textField.text.length) stringValue]];
}

- (void)_textFieldBegin:(id) _textFieldDidEnd {
    if (self.limitLabel.isHidden) {
        self.limitLabel.hidden = NO;
    }
}

- (void)_textFieldDidEnd:(id) _textFieldDidEnd {
    self.limitLabel.hidden = YES;
}


- (void)initializeLimitLabelWithFont:(UIFont *) font andTextColor:(UIColor *) textColor {
    self.limitLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGFloat)(self.bounds.size.width - ([@(font.pointSize) doubleValue] * (2.285714))), 8, 30, self.bounds.size.height)];

    [self.limitLabel setTextColor:textColor];
    [self.limitLabel setFont:font];

    [self.limitLabel setBackgroundColor:[UIColor clearColor]];
    [self.limitLabel setTextAlignment:NSTextAlignmentLeft];
    [self.limitLabel setNumberOfLines:1];
    [self.limitLabel setText:@""];
    [self setRightView:self.limitLabel];
    [self setRightViewMode:UITextFieldViewModeWhileEditing];
    [self textField:self shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@""];

    self.limitLabel.hidden = YES;
}


- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange) range replacementString:(NSString *) string {
    self.previousText = textField.text;
    self.lastReplaceRange = range;
    self.lastReplacementString = string;
    if (self.realDelegate && [self.realDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        [self.realDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (void)shakeLabel {
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.1];
    [shake setRepeatCount:2];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:CGPointMake(self.limitLabel.center.x - 5, self.limitLabel.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:CGPointMake(self.limitLabel.center.x + 5, self.limitLabel.center.y)]];
    [self.limitLabel.layer addAnimation:shake forKey:@"position"];
}


@end
