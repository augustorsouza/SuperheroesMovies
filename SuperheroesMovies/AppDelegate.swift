import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Override point for customization after application launch.
        window = UIWindow()
        window?.rootViewController = MoviesCollectionRouter.presentMoviesCollectionModule()
        window?.makeKeyAndVisible()

        return true
    }

}

