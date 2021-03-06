//
//  HomeViewController.m
//  Instagram-Clone
//
//  Created by Rashad Philizaire on 6/27/22.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import "LoginViewController.h"
#import "SceneDelegate.h"
#import "ComposeViewController.h"
#import "PostCell.h"
#import "Post.h"
#import "PostDetailViewController.h"
#import "ProfileViewController.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, PostCellDelegate>

@property (strong, nonatomic) UIButton *logoutButton;
@property (strong, nonatomic) UIButton *composeButton;
@property (strong, nonatomic) UINavigationController *myNav;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *postArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    [self.view addSubview:self.tableView];
    
    self.myNav = self.navigationController;
    [self setupNavbar];
    
    [self fetchPosts];
}

- (void) initProperties {
    self.logoutButton = [self createLogoutButton];
    self.composeButton = [self createComposeButton];
    self.tableView = [self createTableView];
}

- (void)postCell:(nonnull PostCell *)postCell didTap:(nonnull PFUser *)user {
    [self presentProfileViewForUser:user];
}

- (void) fetchPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * posts, NSError * error) {
        if (posts != nil) {
            self.postArray = [posts mutableCopy];
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        
    }];
}
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self fetchPosts];
    [refreshControl endRefreshing];
}

- (void) setupNavbar {
    CGFloat barHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    
    UINavigationBar *navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, barHeight, self.myNav.view.frame.size.width, 44)];
    [navbar setBarTintColor:[UIColor blackColor]];
    
    navbar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"Home Feed"];
    
    UIBarButtonItem *logoutButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.logoutButton];
    UIBarButtonItem *postButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.composeButton];
    
    [navItem setLeftBarButtonItem:logoutButtonItem];
    [navItem setRightBarButtonItem:postButtonItem];
    [navbar setItems:@[navItem]];
    [navbar setTranslucent:NO];
    [self.myNav.view addSubview:navbar];
}

- (void) logoutUser:(UIButton *)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        myDelegate.window.rootViewController = loginVC;
    }];
}

- (void) onComposePress:(UIButton *)sender {
    [self presentComposeVC];
    
}

- (void) presentProfileViewForUser:(PFUser *)user {
    UINavigationController *nav = [[UINavigationController alloc] init];
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    profileVC.user = user;
    
    [nav setViewControllers:@[profileVC]];
    [self.myNav showViewController:nav sender:self];
}

- (void) presentComposeVC {
    UINavigationController *nav = [[UINavigationController alloc] init];
    ComposeViewController *composeVC = [[ComposeViewController alloc] init];
    
    [nav setViewControllers:@[composeVC]];
    [nav setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:nav animated:true completion:nil];
}

- (UIButton*)createLogoutButton {
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(logoutUser:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Logout" forState:UIControlStateNormal];
    return button;
}

- (UIButton*)createComposeButton {
    UIButton *button = [[UIButton alloc] init];
    
    [button setBackgroundImage:[UIImage systemImageNamed:@"camera"] forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(onComposePress:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}
- (UITableView*)createTableView {
    CGFloat barHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    CGFloat displayWidth = self.view.frame.size.width;
    CGFloat displayHeight = self.view.frame.size.height;
    
    UITableView *view = [[UITableView alloc] initWithFrame:CGRectMake(0, barHeight, displayWidth, displayHeight-barHeight)];
    
    view.rowHeight = UITableViewAutomaticDimension;
    [view registerClass:PostCell.self forCellReuseIdentifier:@"PostCell"];
    view.dataSource = self;
    view.delegate = self;
    
    return view;
}

- (void)presentDetailViewForPost:(Post*)post {
    
    PostDetailViewController *postDetailVC = [[PostDetailViewController alloc] init];
    postDetailVC.post = post;
    [self presentViewController:postDetailVC animated:true completion:nil];
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    Post *currentPost = self.postArray[indexPath.row];
    cell.backgroundColor = [UIColor blackColor];
    [cell setPost:currentPost];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.delegate = self;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Post *currentPost = self.postArray[indexPath.row];
    [self presentDetailViewForPost:currentPost];

}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    Post *currentPost = self.postArray[indexPath.row];
//    PFUser *postUser = currentPost[@"author"];
//    [self presentProfileViewForUser:postUser];
//    
//}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postArray.count;
}


@end
