//
//  Question.h
//  TestingMasonry
//
//  Created by JurjDev on 5/07/21.
//

#import <Foundation/Foundation.h>

@interface Question: NSObject;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *isTrue;

- (id)init:(NSString *) title isTrue:(NSNumber *)isTrue;

@end
