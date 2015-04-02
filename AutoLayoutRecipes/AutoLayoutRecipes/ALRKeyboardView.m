//
//  ALRKeyboardView.m
//  AutoLayoutRecipes
//
//  Created by Allen Cheung on 4/1/15.
//  Copyright (c) 2015 Allen Cheung. All rights reserved.
//

#import "ALRKeyboardView.h"

@interface ALRKeyboardView () <UITextViewDelegate>

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) NSLayoutConstraint *bottomConstraint;
@property (assign, nonatomic) CGFloat keyboardHeight;

@end

@implementation ALRKeyboardView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor whiteColor];
        
        _textView = [[UITextView alloc] init];
        _textView.delegate = self;
        _textView.returnKeyType = UIReturnKeyDone;
        _textView.layer.borderColor = [UIColor redColor].CGColor;
        _textView.layer.borderWidth = 1.0;
        [self addSubview:_textView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
        
        // Constraints
        
        for (UIView *view in [self _views].allValues) {
            view.translatesAutoresizingMaskIntoConstraints = NO;
        }
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_textView]-10-|" options:0 metrics:nil views:[self _views]]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_textView]" options:0 metrics:nil views:[self _views]]];
        _bottomConstraint = [NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.0];
        [self addConstraint:_bottomConstraint];
    }
    return self;
}

- (void)updateConstraints {
    self.bottomConstraint.constant = -self.keyboardHeight - 10;
    
    [super updateConstraints];
}

- (NSDictionary *)_views {
    return NSDictionaryOfVariableBindings(_textView);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"])  {
        [self.textView resignFirstResponder];
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - Notifications

- (void)_keyboardWillShowNotification:(NSNotification *)notification {
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardHeight = CGRectGetHeight(keyboardFrame);
    
    [self layoutIfNeeded];
    [self setNeedsUpdateConstraints];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    [UIView commitAnimations];
}

- (void)_keyboardWillHideNotification:(NSNotification *)notification {
    self.keyboardHeight = 0.0;
    
    [self layoutIfNeeded];
    [self setNeedsUpdateConstraints];

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    [UIView commitAnimations];
}

@end
