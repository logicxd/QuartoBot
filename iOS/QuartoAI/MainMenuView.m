//
//  MainMenuView.m
//  QuartoAI
//
//  Created by Aung Moe on 8/24/16.
//  Copyright © 2016 Aung Moe. All rights reserved.
//

#import "MainMenuView.h"
#import "UIColor+QuartoColor.h"
#import "Masonry.h"
#import "FBShimmeringView.h"

@interface MainMenuView()
@property (nonatomic, strong) FBShimmeringView *shimmeringTitle;
@property (nonatomic, strong) UIView *buttonContainer;
@property (nonatomic, strong) UIButton *playerVsPlayerButton;
@property (nonatomic, strong) UIButton *playerVsBotButton;
@property (nonatomic, strong) UIButton *howToButton;
@property (nonatomic, strong) UILabel *creditLabel;
@end

@implementation MainMenuView

- (instancetype)init {
    if (self = [super init]) {
        UILabel *title = [[UILabel alloc] init];
        title.text = @"QuartoAI";
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:40.f];
        title.textColor = [UIColor quartoWhite];
        
        self.shimmeringTitle = [[FBShimmeringView alloc] initWithFrame:CGRectZero];
        self.shimmeringTitle.contentView = title;
        self.shimmeringTitle.shimmeringSpeed = 80;
        self.shimmeringTitle.shimmeringPauseDuration = 1.5;
        self.shimmeringTitle.shimmering = YES;
        
        self.playerVsPlayerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playerVsPlayerButton.layer.shadowOpacity = .5f;
        self.playerVsPlayerButton.layer.shadowRadius = 1;
        self.playerVsPlayerButton.layer.shadowOffset = CGSizeMake(0, 6);
        [self.playerVsPlayerButton setTitle:@"Player vs Player" forState:UIControlStateNormal];
        [self.playerVsPlayerButton setTitleColor:[UIColor quartoBlack] forState:UIControlStateNormal];
        [self.playerVsPlayerButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [self.playerVsPlayerButton setBackgroundColor:[UIColor quartoWhite]];
        [self.playerVsPlayerButton addTarget:self action:@selector(buttonHit:) forControlEvents:UIControlEventTouchUpInside];
        
        self.playerVsBotButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playerVsBotButton.layer.shadowOpacity = .5f;
        self.playerVsBotButton.layer.shadowRadius = 1;
        self.playerVsBotButton.layer.shadowOffset = CGSizeMake(0, 6);
        [self.playerVsBotButton setTitle:@"Player vs Bot" forState:UIControlStateNormal];
        [self.playerVsBotButton setTitleColor:[UIColor quartoBlack] forState:UIControlStateNormal];
        [self.playerVsBotButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [self.playerVsBotButton setBackgroundColor:[UIColor quartoWhite]];
        [self.playerVsBotButton addTarget:self action:@selector(buttonHit:) forControlEvents:UIControlEventTouchUpInside];
        
        self.howToButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.howToButton.layer.shadowOpacity = .5f;
        self.howToButton.layer.shadowRadius = 1;
        self.howToButton.layer.shadowOffset = CGSizeMake(0, 6);
        [self.howToButton setTitle:@"How to Play" forState:UIControlStateNormal];
        [self.howToButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [self.howToButton setTitleColor:[UIColor quartoBlack] forState:UIControlStateNormal];
        [self.howToButton setBackgroundColor:[UIColor quartoWhite]];
        [self.howToButton addTarget:self action:@selector(buttonHit:) forControlEvents:UIControlEventTouchUpInside];
        
        self.buttonContainer = [[UIView alloc] init];
        [self.buttonContainer addSubview:self.playerVsPlayerButton];
        [self.buttonContainer addSubview:self.playerVsBotButton];
        [self.buttonContainer addSubview:self.howToButton];
        
        self.creditLabel = [[UILabel alloc] init];
        self.creditLabel.font = [UIFont systemFontOfSize:10];
        self.creditLabel.text = @"Naahh Inc. All Rights Reserved";
        self.creditLabel.textAlignment = NSTextAlignmentCenter;
        self.creditLabel.textColor = [UIColor quartoBlack];
        self.creditLabel.backgroundColor =  [UIColor colorWithRed:254/255.f green:246/255.f blue:235/255.f alpha:.4];
        
        self.backgroundColor = [UIColor quartoRed];
        [self addSubview:self.shimmeringTitle];
        [self addSubview:self.buttonContainer];
        [self addSubview:self.creditLabel];
    }
    return self;
}

- (void)buttonHit:(UIButton *)button {
    NSLog(@"\"%@\" is pressed", button.titleLabel.text);
    
    if (button == self.playerVsPlayerButton) {
        self.buttonHit(MainMenuButtonTypePlayerVsPlayer);
    } else if (button == self.playerVsBotButton) {
        self.buttonHit(MainMenuButtonTypePlayerVsBot);
    } else if (button == self.howToButton) {
        self.buttonHit(MainMenuButtonTypeHowTo);
    }
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    // Constraints based on iPhone 4s
    CGFloat kTitleHeight = (self.bounds.size.width)*(9.f/64.f);          // 45
    CGFloat kButtonContainerWidth = (self.bounds.size.width)*0.7f;       // 224
    CGFloat kButtonContainerHeight = (self.bounds.size.height)*0.4f;     // 192
    CGFloat kButtonHeight = (kButtonContainerHeight)/4.f;                // 56
    CGFloat kCreditHeight =  (self.bounds.size.width)*(1.f/20.f);        // 16
    
    [self.shimmeringTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.buttonContainer.mas_top).offset(-25.f);    // Fixed, one-time constant.
        make.width.equalTo(self.buttonContainer);
        make.height.equalTo(@(kTitleHeight));
    }];
    
    [self.buttonContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(@(kButtonContainerWidth));
        make.height.equalTo(@(kButtonContainerHeight));
        
        [self.playerVsPlayerButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.buttonContainer);
            make.right.equalTo(self.buttonContainer);
            make.top.equalTo(self.buttonContainer);
            make.height.equalTo(@(kButtonHeight));
        }];
        
        [self.playerVsBotButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.buttonContainer);
            make.right.equalTo(self.buttonContainer);
            make.top.equalTo(self.playerVsPlayerButton.mas_bottom).offset(10.f);    // Fixed constant for all.
            make.height.equalTo(@(kButtonHeight));
        }];
        
        [self.howToButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.buttonContainer);
            make.right.equalTo(self.buttonContainer);
            make.top.equalTo(self.playerVsBotButton.mas_bottom).offset(10.f);
            make.height.equalTo(@(kButtonHeight));
        }];
    }];

    [self.creditLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(@(kCreditHeight));
    }];
    
    [super updateConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.playerVsPlayerButton.layer.cornerRadius = self.playerVsPlayerButton.bounds.size.height * 1/8.f;
    self.playerVsBotButton.layer.cornerRadius = self.playerVsBotButton.bounds.size.height * 1/8.f;
    self.howToButton.layer.cornerRadius = self.howToButton.bounds.size.height * 1/8.f;
}

@end












