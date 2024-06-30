import UIKit
import Flutter
import googleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyCCENuAY7GAd3kUUfqS4zqpTqn6mLW8uRE")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
