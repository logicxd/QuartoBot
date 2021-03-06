//
//  QuartoBoardView.h
//  QuartoAI
//
//  Created by Aung Moe on 8/25/16.
//  Copyright © 2016 Aung Moe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuartoBoardViewCell;

@interface QuartoBoardView : UIView

// Each index represents each cell in the board like this:
// 0  1  2  3
// 4  5  6  7
// 8  9  10 11
// 12 13 14 15
//
@property (nonatomic, strong, readonly) NSMutableArray<QuartoBoardViewCell *> *boardCells;

- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height;
- (NSDictionary *)getBoard;           // This is used for AI bot.
- (void)resetBoard;

@end
