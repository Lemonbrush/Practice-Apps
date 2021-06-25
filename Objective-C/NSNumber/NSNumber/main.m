//
//  main.m
//  NSNumber
//
//  Created by Alexander Rubtsov on 24.06.2021.
//

#import <Foundation/Foundation.h>

@interface Calculator: NSObject
- (NSNumber *)multiplyA: (NSNumber *)a withB: (NSNumber *)b;
@end

@implementation Calculator

- (NSNumber *)multiplyA:(NSNumber *)a withB:(NSNumber *)b {
    float number1 = [a floatValue];
    float number2 = [b floatValue];
    float product = number1 * number2;
    NSNumber *result = [NSNumber numberWithFloat:product];
    
    return result;
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Calculator *multiplyer = [[Calculator alloc] init];
        
        NSNumber *a = [NSNumber numberWithFloat: 5.f];
        NSNumber *b = [NSNumber numberWithFloat: 10.f];
        NSNumber *result = [multiplyer multiplyA:a withB:b];
        
        NSString *resultString = [result stringValue];
        
        NSLog(@"%@",resultString);
        
    }
    return 0;
}
