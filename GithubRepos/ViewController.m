//
//  ViewController.m
//  GithubRepos
//
//  Created by Rushan on 2017-05-22.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

#import "ViewController.h"
#import "GithubRepo.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *gitTableView;
@property (nonatomic) NSMutableArray *objects;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/lighthouse-labs/repos"]; //create new NSURL object
    NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:url];//make config speicific to the url
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration] ; //can set things like requests
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; //NSURL Session object created
    
    
    
//data: The data returned by the server, most of the time this will be JSON or XML.
//response: Response metadata such as HTTP headers and status codes.
//error: An NSError that indicates why the request failed, or nil when the request is successful.
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        //retrieves data from the server as an NSData Object
        
        if(jsonError) { //handle the error from JSON
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        NSMutableArray<GithubRepo *> *repoObjects = [[NSMutableArray alloc]init];
        
        for(NSDictionary *repo in repos) { //JSON data back from our request
            NSString *repoName = repo[@"name"];
            NSLog(@"repo: %@", repoName);
            
            GithubRepo *aRepo = [[GithubRepo alloc] initWithName:repo[@"name"] andURL:[NSURL URLWithString: repo[@"html_url"]]];
            [repoObjects addObject:aRepo];
        }
        self.objects = [repoObjects copy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.gitTableView reloadData];
        });//sets github table
        
    }]; //creates task that gets data from server, tasks makes the request
    
    [dataTask resume]; //resumes task (since its created in suspended state)
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.objects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    GithubRepo *object = self.objects[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", object.name, object.url];
    return cell;
}

@end
