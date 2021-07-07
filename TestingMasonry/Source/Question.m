//
//  Question.m
//  TestingMasonry
//
//  Created by JurjDev on 5/07/21.
//

#import "Question.h"

@implementation Question

@synthesize title;
@synthesize isTrue;

- (id)init:(NSString *) title isTrue:(NSNumber *)isTrue {
    
    self.title = title;
    self.isTrue = isTrue;
    return self;
}

@end

