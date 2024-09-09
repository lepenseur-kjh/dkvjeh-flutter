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
      
      // 카카오
      KakaoSDK.initSDK(appKey: "${NATIVE_APP_KEY}")
      
      // 로컬 푸시 알림
      if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
      }
      
      GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
