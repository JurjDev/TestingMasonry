//
//  QuizViewController.m
//  TestingMasonry
//
//  Created by JurjDev on 5/07/21.
//

#import "QuizViewController.h"

@interface QuizViewController ()
@end

@implementation QuizViewController

NSArray<Question *> *questions = nil;

- (NSArray<Question *> *) getQuestion {
    
    if (questions == nil) questions = @[
        [[Question alloc] init:@"As far as has ever been reported, no-one has ever seen an ostrich bury its head in the sand." isTrue:0],
        [[Question alloc] init:@"Approximately one quarter of human bones are in the feet." isTrue:0],
        [[Question alloc] init:@"Popeye’s nephews were called Peepeye, Poopeye, Pipeye and Pupeye." isTrue:0],
        [[Question alloc] init:@"In ancient Rome, a special room called a vomitorium was available for diners to purge food in during meals." isTrue:@1],
        [[Question alloc] init:@"The Great Wall Of China is visible from the moon." isTrue:@1],
        [[Question alloc] init:@"Virtually all Las Vegas gambling casinos ensure that they have no clocks." isTrue:@1],
        [[Question alloc] init:@"Risotto is a common Italian rice dish." isTrue:0],
        [[Question alloc] init:@"The prefix \"mega-\" represents one million." isTrue:0],
        [[Question alloc] init:@"The \"Forbidden City\" is in Beijing." isTrue:0],
        [[Question alloc] init:@"Hurricanes and typhoons are the same thing." isTrue:0],
        [[Question alloc] init:@"In Shakespeare's play, Hamlet commits suicide." isTrue:@1],
        [[Question alloc] init:@"An American was the first man in space." isTrue:@1],
        [[Question alloc] init:@"The \"China Syndrome\" is what hostages experience when they begin to feel empathy for their captors." isTrue:@1],
        [[Question alloc] init:@"Other than water, coffee is the world's most popular drink." isTrue:0]
    ];
    return questions;
}

State *state = nil;

- (State *) getState {
    
    if (state == nil) {
        
        state = [[State alloc] init: [self getQuestion]];
        
    }
    return state;
}

NSTimer *timer = nil;

NSLayoutConstraint *progressConstraint = nil;

UIView *viewProgress = nil;

UILabel *lblTimer = nil;

UILabel *lblQuestion = nil;

UIButton *btnTrue = nil;

UIButton *btnFalse = nil;

UIStackView *svButtons = nil;

UILabel *lblMessage = nil;

- (UIView *) progressView {
    
    if (viewProgress == nil) {
        viewProgress = [[UIView alloc] init];
        viewProgress.frame = CGRectMake(0, 0, 0, 0);
        viewProgress.backgroundColor = [UIColor greenColor];
        
        [self.view addSubview:viewProgress];
    }
    return viewProgress;
}


- (UILabel *) timerLabel {
    
    if (lblTimer == nil) {
        lblTimer = [[UILabel alloc] init];
        lblTimer.frame = CGRectMake(0, 0, 0, 0);
        lblTimer.layer.cornerRadius = 8.0;
        lblTimer.layer.borderColor = [[UIColor blackColor] CGColor];
        lblTimer.layer.borderWidth = 2;
        lblTimer.textAlignment = NSTextAlignmentCenter;
        lblTimer.font = [UIFont systemFontOfSize:20 weight: UIFontWeightLight];
        lblTimer.text = @"00:10";
        
        [self.view addSubview:lblTimer];
    }
    
    return lblTimer;
}

- (UILabel *) questionLabel {
    
    if (lblQuestion == nil) {
        
        lblQuestion = [[UILabel alloc] init];
        lblQuestion.frame = CGRectMake(0, 0, 0, 0);
        lblQuestion.textAlignment = NSTextAlignmentCenter;
        lblQuestion.font = [UIFont systemFontOfSize:24 weight: UIFontWeightSemibold];
        lblQuestion.numberOfLines = 0;
        
        [self.view addSubview:lblQuestion];
    }
    return lblQuestion;
}


- (UIButton *) trueButton {
    
    if (btnTrue == nil) {
        
        btnTrue = [[UIButton alloc] init];
        btnTrue.layer.cornerRadius = 12;
        btnTrue.backgroundColor = [UIColor greenColor];
        [btnTrue setTitle:@"👍 True" forState: UIControlStateNormal];
        [btnTrue setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
        btnTrue.titleLabel.font = [UIFont systemFontOfSize:22 weight: UIFontWeightSemibold];
        btnTrue.showsTouchWhenHighlighted = YES;
        [btnTrue addTarget:self action: @selector(handleAnswer:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return btnTrue;
}

- (UIButton *) falseButton {
    
    if (btnFalse == nil) {
        
        btnFalse = [[UIButton alloc] init];
        btnFalse.layer.cornerRadius = 12;
        btnFalse.backgroundColor = [UIColor redColor];
        [btnFalse setTitle:@"👎 False" forState: UIControlStateNormal];
        [btnFalse setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
        btnFalse.titleLabel.font = [UIFont systemFontOfSize:22 weight: UIFontWeightSemibold];
        btnFalse.showsTouchWhenHighlighted = YES;
        [btnFalse addTarget:self action: @selector(handleAnswer:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return btnTrue;
}

- (UIStackView *) buttonsStackView {
    
    if (svButtons == nil) {
        
        svButtons = [[UIStackView alloc] init];
        [svButtons addArrangedSubview: btnTrue];
        [svButtons addArrangedSubview: btnFalse];
        
        svButtons.alignment = UIStackViewAlignmentCenter;
        svButtons.spacing = 16;
        svButtons.axis = UILayoutConstraintAxisHorizontal;
        svButtons.distribution = UIStackViewDistributionFillEqually;
        
        [self.view addSubview:svButtons];
    }
    return svButtons;
}

- (UILabel *) messageLabel {
    
    if (lblMessage == nil) {
        
        lblMessage = [[UILabel alloc] init];
        lblMessage.numberOfLines = 0;
        
        lblMessage.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        lblMessage.textAlignment = NSTextAlignmentCenter;
        lblMessage.font = [UIFont systemFontOfSize: 48 weight: UIFontWeightSemibold];
        lblMessage.alpha = 0;
        
        [self.navigationController.view addSubview:lblMessage];
    }
    return lblMessage;
}

// MARK: ViewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setLargeTitleDisplayMode: UINavigationItemLargeTitleDisplayModeAlways];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    [self setupConstrains];
    [self startGame];
}


- (void) handleAnswer:(UIButton *)sender {
    
    BOOL userSelection = sender == [self trueButton];
    BOOL isCorrect = state.question.isTrue.boolValue == userSelection;
    
    if (isCorrect) {
        state.correctAnswers += 1;
    }
    
    [self showMessage:&isCorrect];
}

- (void) showMessage:(BOOL *)isCorrect {
    
    lblMessage.text = isCorrect ? @"That's correct!\n👍🎉😄" : @"Sorry, that's wrong!\n\n👎☠️😢";
    lblMessage.textColor = isCorrect ? [UIColor greenColor] : [UIColor redColor];
    lblMessage.transform = CGAffineTransformMakeScale(0.1, 0.1);
    lblMessage.alpha = 0;
    
    [timer invalidate];
    
    [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.8 options: UIViewAnimationOptionCurveEaseIn animations:^{
        
        lblMessage.alpha = 1;
        lblMessage.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.15 animations:^{
            
            lblMessage.alpha = 0;
        } completion:^(BOOL finished) {
           
            [self goToNextQuestion];
        }];
    }];
}

- (void) goToNextQuestion {
    
    if (state.isLastQuestion == false) {
        
        [self goToQuestionAt:state.currentQuestion + 1];
    } else {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Start Over" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self startGame];
        }];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Good job!" message: [NSString stringWithFormat:@"You got %ld out of %ld ", state.correctAnswers, state.numberOfQuestions] preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction: action];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void) goToQuestionAt:(NSInteger)position {

    state.currentQuestion = position;
    
    lblQuestion.text = state.question.title;
    
    [self navigationItem].title = [NSString stringWithFormat: @"SnappyQuiz %ld / %ld", position, state.numberOfQuestions];
    
    double progress = [NSNumber numberWithLong:position].doubleValue / [NSNumber numberWithLong:state.numberOfQuestions].doubleValue;
    
    [self updateProgress:progress];
    [self startCountdown];
}

- (void) startGame {
    
    state = [self getState];
    [self goToQuestionAt:1];
}

- (void) startCountdown {
    
    lblTimer.text = @"00:10";
    
    [timer invalidate];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        NSString *timerSecconds = lblTimer.text.length == 0 ? @"0" : [lblTimer.text stringByReplacingOccurrencesOfString:@":" withString:@""];
        
        NSInteger currentSeconds = timerSecconds.length == 0 ? 1 : [timerSecconds integerValue];
        
        if (currentSeconds > 1) {
            
            lblTimer.text = [NSString stringWithFormat:@"00:0%ld", currentSeconds - 1];
        } else {
            
            [timer invalidate];
            [self goToNextQuestion];
        }
    }];
}

// MARK: - Constraint

- (void) updateProgress:(double)progress {
    
    UIView *superview = self.view;

    [viewProgress mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.width.equalTo(superview).multipliedBy(progress);
        make.height.equalTo(@32);
        make.leading.equalTo(superview);
    }];
}

- (void) setupConstrains {
    
    UIView *navView = [self navigationController].view;
    
    UIView *superview = self.view;
    
    if (navView == nil) { return; }
    
    [self progressView];
    [self updateProgress: 0];
    
    [self timerLabel];

    [lblTimer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(superview.mas_width).multipliedBy(0.45);
        make.height.equalTo(@45);
        make.top.equalTo(viewProgress.mas_bottom).with.offset(32);
        make.centerX.equalTo(superview.mas_centerX);
    }];
    
    [self questionLabel];
    [lblQuestion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblTimer.mas_bottom).with.offset(24);
        make.right.equalTo(superview.mas_safeAreaLayoutGuideRight).with.offset(-16);
        make.left.equalTo(superview.mas_safeAreaLayoutGuideLeft).with.offset(16);
    }];
    
    [self messageLabel];
    [lblMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(navView);
    }];
    
    [self trueButton];
    [self falseButton];
    
    [self buttonsStackView];
    [svButtons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(lblQuestion.mas_leading);
        make.trailing.equalTo(lblQuestion.mas_trailing);
        make.top.equalTo(lblQuestion.mas_bottom).with.offset(16);
        make.height.equalTo(@80);
    }];
}

@end
