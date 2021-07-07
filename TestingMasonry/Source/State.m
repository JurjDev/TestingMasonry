//
//  State.m
//  TestingMasonry
//
//  Created by JurjDev on 6/07/21.
//

#import "State.h"

@implementation State

@synthesize questions;
@synthesize numberOfQuestions;
@synthesize currentQuestion;
@synthesize correctAnswers;

- (id)init:(NSArray<Question *> *)question {
    
    self.questions = question;
    self.numberOfQuestions = question.count;
    self.currentQuestion = 1;
    self.correctAnswers = 0;
    
    return self;
}

- (BOOL)isLastQuestion {
    
    return self.currentQuestion == self.numberOfQuestions;
}

- (Question *)question {
    
    return self.questions[self.currentQuestion - 1];
}

@end
