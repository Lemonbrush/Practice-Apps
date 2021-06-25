//
//  main.m
//  Pointers
//
//  Created by Alexander Rubtsov on 25.06.2021.
//

#import <Foundation/Foundation.h>

int main() {
    
    int var = 20;
    int *ip;
    ip = &var;
    
    NSLog(@"Address of var variable: %x\n", &var);
    NSLog(@"Address stored in ip variable: %x\n", ip);
    NSLog(@"Value of ip variable: %d\n", *ip);
    
    NSLog(@"\n\n");
    
    int arr[] = {10, 100, 200};
    int i, *ptr;
    
    ptr = &arr[2];
    for(i = 3; i > 0; i--) {
        NSLog(@"Address of arr[%d] = %x\n",i,ptr);
        NSLog(@"Value of var[%d] = %d\n",i,*ptr);
        
        ptr--;
    }
    
    return 0;
}
