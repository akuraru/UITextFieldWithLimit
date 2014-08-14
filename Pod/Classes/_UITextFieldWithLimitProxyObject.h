//
// Created by azu on 2014/08/14.
//


#import <Foundation/Foundation.h>

@protocol UITextFieldDelegate;


@interface _UITextFieldWithLimitProxyObject : NSObject <UITextFieldDelegate>
@property(nonatomic, weak) id <UITextFieldDelegate> delegate;
@end