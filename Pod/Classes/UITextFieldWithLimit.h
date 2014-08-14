//
//  UITextFieldWithLimit.h
//  UITextFieldWithLimit
//
// Base on theses
// https://github.com/JonathanGurebo/UITextFieldWithLimit
// http://blog.niw.at/post/92806309874
#import <UIKit/UIKit.h>

@class UITextFieldWithLimit;
@class _UITextFieldWithLimitProxyObject;

@protocol UITextFieldWithLimitDelegate <UITextFieldDelegate>

@optional
- (void)textFieldLimit:(UITextFieldWithLimit *) textFieldLimit didWentOverLimitWithDisallowedText:(NSString *) text inDisallowedRange:(NSRange) range;

- (void)textFieldLimit:(UITextFieldWithLimit *) textFieldLimit didReachLimitWithLastEnteredText:(NSString *) text inRange:(NSRange) range;
@end

@interface UITextFieldWithLimit : UITextField <UITextFieldDelegate>
@property(nonatomic, strong) id <UITextFieldWithLimitDelegate> limitDelegate;
// Default : @10
@property(readwrite, nonatomic) NSNumber *maxLength;
@property(strong, nonatomic) UILabel *limitLabel;
@end
