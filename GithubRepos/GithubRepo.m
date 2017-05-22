//
//  GithubRepo.m
//  GithubRepos
//
//  Created by Rushan on 2017-05-22.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "GithubRepo.h"

@implementation GithubRepo

-(instancetype)initWithName:(NSString *)name andURL:(NSURL *)url{
    if(self = [super init]){
        _name = name;
        _url = url;
    }
    return self;
}

@end
