import Flutter
import UIKit
import KakaoSDKCommon
import Firebase

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      // 파이어베이스 (맨 처음 선언해야 함.)
      FirebaseApp.configure()
      
      GeneratedPluginRegistrant.register(with: self)
      
      // 카카오
      KakaoSDK.initSDK(appKey: "${NATIVE_APP_KEY}")
      
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
