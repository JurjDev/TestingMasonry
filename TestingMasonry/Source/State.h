//
//  State.h
//  TestingMasonry
//
//  Created by JurjDev on 6/07/21.
//

#import <Foundation/Foundation.h>
#import "Question.h"

@interface State: NSObject;

@property (nonatomic, strong) NSArray<Question *> *questions;
@property (nonatomic) NSInteger numberOfQuestions;
@property (nonatomic) NSInteger currentQuestion;
@property (nonatomic) NSInteger correctAnswers;


- (id)init:(NSArray<Question *> *)question;
- (BOOL)isLastQuestion;
- (Question *)question;
@end
