//
//  ALRKeyboardViewController.m
//  AutoLayoutRecipes
//
//  Created by Allen Cheung on 4/1/15.
//  Copyright (c) 2015 Allen Cheung. All rights reserved.
//

#import "ALRKeyboardViewController.h"

#import "ALRKeyboardView.h"

@interface ALRKeyboardViewController ()

@end

@implementation ALRKeyboardViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nil bundle:nil])) {
        self.title = NSLocalizedString(@"Keyboard Animations", nil);
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)loadView {
    self.view = [[ALRKeyboardView alloc] init];
}

@end
