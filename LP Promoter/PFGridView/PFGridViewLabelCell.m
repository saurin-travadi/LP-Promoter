//
//  PFGridViewLabelCell.m
//  PFGridView
//
//  Created by YJ Park on 3/11/11.
//  Copyright 2011 PettyFun.com All rights reserved.
//

#import "PFGridViewLabelCell.h"


@implementation PFGridViewLabelCell
@synthesize textLabel;
@synthesize margin;

- (id)initWithReuseIdentifier:(NSString *)identifier {
    if ((self = [super initWithReuseIdentifier:identifier])) {
        textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:textLabel];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    CGRect labelFrame = CGRectMake(margin, 0,
                                   frame.size.width - margin * 2,
                                   frame.size.height);
    textLabel.frame = labelFrame;
}

-(void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext(); //get the graphics context
    
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint( ctx, 0,100);
    CGContextStrokePath(ctx);


    CGContextMoveToPoint(ctx, 0, textLabel.frame.size.height);
    CGContextAddRect(ctx, CGRectMake(0, textLabel.frame.size.height, textLabel.frame.size.width, 1));
    CGContextStrokePath(ctx);


}

@end
