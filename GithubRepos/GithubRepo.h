//
//  GithubRepo.h
//  GithubRepos
//
//  Created by Rushan on 2017-05-22.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GithubRepo : NSObject

@property (nonatomic) NSURL *url;
@property (nonatomic) NSString *name;

-(instancetype)initWithName:(NSString *)name andURL:(NSURL *)url;

@end
