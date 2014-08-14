# UITextFieldWithLimit

[![CI Status](http://img.shields.io/travis/azu/UITextFieldWithLimit.svg?style=flat)](https://travis-ci.org/azu/UITextFieldWithLimit)
[![Version](https://img.shields.io/cocoapods/v/UITextFieldWithLimit.svg?style=flat)](http://cocoadocs.org/docsets/UITextFieldWithLimit)
[![License](https://img.shields.io/cocoapods/l/UITextFieldWithLimit.svg?style=flat)](http://cocoadocs.org/docsets/UITextFieldWithLimit)
[![Platform](https://img.shields.io/cocoapods/p/UITextFieldWithLimit.svg?style=flat)](http://cocoadocs.org/docsets/UITextFieldWithLimit)

This subclass of the UITextField,  adds a text length limit.

![gif](http://gyazo.com/469ee2f88953cda723db1ea9744d8ff8.gif)

## Feature

- Set text length limit
- Text length counter
- IME support(japanese keyboard support)

## Installation

UITextFieldWithLimit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "UITextFieldWithLimit"

## Usage

You can try this : `pod try UITextFieldWithLimit`


``` objc
- (void)viewDidLoad {
    [super viewDidLoad];
    self.limitedTextField = [[UITextFieldWithLimit alloc] init];
    self.limitedTextField.maxLength = @15;
    // optional
    self.limitedTextField.limitDelegate = self;
}
- (void)textFieldLimit:(UITextFieldWithLimit *) textFieldLimit didReachLimitWithLastEnteredText:(NSString *) text inRange:(NSRange) range {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)textFieldLimit:(UITextFieldWithLimit *) textFieldLimit didWentOverLimitWithDisallowedText:(NSString *) text inDisallowedRange:(NSRange) range {
    NSLog(@"%s", sel_getName(_cmd));
}

```

## API

``` objc
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
```

## Author

azu, azuciao@gmail.com

## License

UITextFieldWithLimit is available under the MIT license. See the LICENSE file for more info.

## acknowledgment

- [iOS で文字数制限つきのテキストフィールドをちゃんと作るのは難しいという話 - blog.niw.at](http://blog.niw.at/post/92806309874 "iOS で文字数制限つきのテキストフィールドをちゃんと作るのは難しいという話 - blog.niw.at")
- [JonathanGurebo/UITextFieldLimit](https://github.com/JonathanGurebo/UITextFieldLimit "JonathanGurebo/UITextFieldLimit")