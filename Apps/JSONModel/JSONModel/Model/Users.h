//
//  Users.h
//  JSONModel
//
//  Created by Александр on 31.05.2021.
//

#import "JSONModel.h"

@protocol User @end

@interface User : JSONModel
@property (assign, nonatomic) NSString* name;
@end

@implementation User
@end

