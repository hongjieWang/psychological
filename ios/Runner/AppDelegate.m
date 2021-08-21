#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <UMCommon/UMCommon.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    [UMConfigure initWithAppkey:@"60c1af1ce044530ff09fe596" channel:@"App Store"];
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
