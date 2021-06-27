//
//  main.m
//  NSString
//
//  Created by Александр on 27.06.2021.
//

#import <Foundation/Foundation.h>

int main() {
    
    NSString *str1 = @"hello";
    NSString *str2 = @"world";
    NSString *str3;
    
    str1 = [str1 capitalizedString];
    str3 = [str1 stringByAppendingFormat: str2];
    str3 = [[NSString alloc] initWithFormat:@"%@ %@",str1,str2];
    
    NSLog(@"%@", str3);
    
    return 0;
}
