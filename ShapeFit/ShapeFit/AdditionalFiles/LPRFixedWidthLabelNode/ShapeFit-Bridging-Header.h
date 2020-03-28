//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

// Created by suggestion of SKUtils github to fix some UI stuff

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, LPRFixedWidthLabelNodeTruncationMode) {
    LPRFixedWidthLabelNodeTruncationModeSuspensionPoints,
    LPRFixedWidthLabelNodeTruncationModeScale,
};

@interface LPRFixedWidthLabelNode : SKLabelNode

@property (nonatomic) CGFloat maxWidth;
@property (nonatomic) LPRFixedWidthLabelNodeTruncationMode truncationMode;
@property (nonatomic) BOOL keepPunctuation;

- (instancetype)initWithMaxWidth:(CGFloat)maxWidth truncationMode:(LPRFixedWidthLabelNodeTruncationMode)truncationMode;
- (void)syncScale:(LPRFixedWidthLabelNode *)label2;
@end
