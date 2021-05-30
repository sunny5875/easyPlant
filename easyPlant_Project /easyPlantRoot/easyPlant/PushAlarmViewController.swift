//
//  PushAlarmViewController.swift
//  easyPlant
//
//  Created by 현수빈 on 2021/05/30.
//

import UIKit
import UserNotifications

class PushAlarmViewController: UIViewController {
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        requestNotificationAuthorization()
           sendNotification(seconds: 10)
    }
    
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

            userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
                if let error = error {
                    print("Error: \(error)")
                }
            }

    }

    func sendNotification(seconds: Double) {
        let notificationContent = UNMutableNotificationContent()

           notificationContent.title = "알림 테스트"
           notificationContent.body = "이것은 알림을 테스트 하는 것이다"

           let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
           let request = UNNotificationRequest(identifier: "testNotification",
                                               content: notificationContent,
                                               trigger: trigger)

           userNotificationCenter.add(request) { error in
               if let error = error {
                   print("Notification Error: ", error)
               }
           }

    }

  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PushAlarmViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}
