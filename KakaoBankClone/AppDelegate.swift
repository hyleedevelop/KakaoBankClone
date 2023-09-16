//
//  AppDelegate.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/03.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseMessaging
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Firebase 초기화
        FirebaseApp.configure()
        
        //sleep(1)
        
        // 앱 실행 후 계좌 화면의 테이블뷰 셀 애니메이션이 최초 1회만 시작되도록 설정
        UserDefaults.standard.showCellAnimation = true
        
        // 푸시 알림 관련 설정
        Messaging.messaging().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, _ in
            if granted {
                print("알림 등록이 완료되었습니다.")
            }
        }
        application.registerForRemoteNotifications()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
    
    // registerForRemoteNotifications() 메서드 성공 시 호출
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        // 수신된 deviceToken을 String으로 변환하기
//        // 푸시 알림을 보낼 때 서버는 이 토큰을 “주소”로 사용하여 올바른 목적지 기기에 전달함
//        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
//        let token = tokenParts.joined()
//        print("Device Token: \(token)")
        
        // FirebaseMessaging - 토큰
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // registerForRemoteNotifications() 메서드 실패 시 호출
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {

    // foreground에서도 알림이 보이도록 설정
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    // 알림을 받았을 때의 처리 로직
    func application(_ application: UIApplication, didReceive notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // completionHandler를 통해 알림을 어떻게 표시할지 설정
        completionHandler([.banner, .sound, .badge])
    }
    
}

extension AppDelegate: MessagingDelegate {

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        // 원래는 서버로 다시 fcm 토큰을 보내줘야 하지만 서버가 없기 때문에 token을 출력
        if let fcmToken = fcmToken {
            print("FCM Token: \(fcmToken)")
        }
    }
    
}
