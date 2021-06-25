//
//  main.m
//  ObjC
//
//  Created by Alexander Rubtsov on 14.06.2021.
//

#import <Foundation/Foundation.h>

@interface Node: NSObject

@property Node* nextNode;
@property NSString* string;

- (void)setValue: (NSString*) string;
- (void)printValue;
- (void)printAllNextValues;

- (Node*)init: (NSString*) string;

@end

@implementation Node

- (Node*)init: (NSString*) string {
    self = [super init];
    
    if (self != nil) {
        _string = string;
    }
    
    return self;
}

- (void)setValue: (NSString*) string {
    self.string = string;
}

- (void)printValue {
    NSLog(@"%@",_string);
}

- (void)printAllNextValues {
    Node* currentNode = self;
    
    while (currentNode) {
        [currentNode printValue];
        currentNode = currentNode.nextNode;
    }
}

@end

//MARK: - Main

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Node* firstNode = [[Node alloc] init: @"0"];
        
        Node* iterNode = firstNode;
        for(int i = 1; i<=10; i++) {
            Node* newNode = [[Node alloc] init: [NSString stringWithFormat:@"%d", i]];
            iterNode.nextNode = newNode;
            iterNode = newNode;
        }
        
        [firstNode printAllNextValues];
    }
    return 0;
}
