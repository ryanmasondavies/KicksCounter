import WatchConnectivity
import UIKit

final class WatchSessionManager: NSObject, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        debugPrint("Session activated: \(activationState), error: \(String(describing: error))")
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
        debugPrint("Session became inactive.")
    }

    func sessionDidDeactivate(_ session: WCSession) {
        debugPrint("Session deactivated.")
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let watchSessionManager = WatchSessionManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        WCSession.default.delegate = watchSessionManager
        WCSession.default.activate()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

