//
//  ViewController.m
//  JSONModel
//
//  Created by Александр on 31.05.2021.
//

#import "ViewController.h"
#import "Users.h"

@interface ViewController ()

@property (strong, nonatomic) NSString <User> *userModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self fetchUsers];
}

- (void)fetchUsers {
    NSURL *usersURL = [NSURL URLWithString:@"https://jsonplaceholder.typicode.com/users"];
     
    [[[NSURLSession sharedSession] dataTaskWithURL:usersURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSString *rawJSON = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //rawJSON = [rawJSON stringByReplacingOccurrencesOfString:@"\\'" withString:@"'"];
        
        NSError *err;
        self.userModel = [User arrayOfModelsFromData:data error:nil];
        
        if (err) {
            NSLog(@"%@",err.localizedDescription);
        }
        
        NSLog(@"%@",[self userModel]);
        
    }] resume];
}

@end
