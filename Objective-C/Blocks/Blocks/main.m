//
//  main.m
//  Blocks
//
//  Created by Alexander Rubtsov on 18.06.2021.
//

#import <Foundation/Foundation.h>

typedef void (^CompletionBlock)(void);

@interface SomeClass: NSObject
- (void) performActionWithCompletion: (CompletionBlock)completionBlock;
@end

@implementation SomeClass
- (void) performActionWithCompletion: (CompletionBlock)completionBlock {
    NSLog(@"Action performed");
    completionBlock();
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //Simple block
        void (^simpleBlock)(void) = ^{
           NSLog(@"This is a block");
        };
        
        simpleBlock();
        
        //Block with retturn parameter
        double (^multiplyTwoValues)(double,double) = ^(double firstValue, double secondValue) {
            return firstValue * secondValue;
        };
        
        NSLog(@"%f",multiplyTwoValues(5,5));
        
        //Use block as a completionHandler
        SomeClass* someObject = [[SomeClass alloc] init];
        void (^customCompletion)(void) = ^{
            NSLog(@"Custom completion performed");
        };
        
        [someObject performActionWithCompletion:customCompletion];
        
    }
    return 0;
}
