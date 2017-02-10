//
//  ViewController.swift
//  LocalNotifications
//
//  Created by Abraham Barcenas M on 2/9/17.
//  Copyright © 2017 barcennas. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. Request Permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Notification Acess Granted")
            }else{
                print(error?.localizedDescription ?? "No error description")
            }
        }
    }
    
    @IBAction func notifyButtonPressed(sender: UIButton){
        scheduleNotification(inSeconds: 5) { (success) in
            if success{
                print("Successfully schedule notification")
            }else{
                print("Error scheduling notification")
            }
        }
    }
    
    func scheduleNotification(inSeconds : TimeInterval, completion : @escaping (_ Success : Bool) -> ()){
        
        // Create an attachment
        let myImage = "rick_grimes"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
            completion(false)
            return
        }
        
        var attachment : UNNotificationAttachment
        
        //force try because i know i have the gif used.
        attachment = try! UNNotificationAttachment(identifier: "MyNotification", url: imageUrl, options: .none)
        
        //2. Create Notification
        let notif = UNMutableNotificationContent()
        
        
        //3. Configure Notification
        notif.title = "New Notification"
        notif.subtitle = "This are great"
        notif.body = "Creating Local Notifications in iOS is so easy"
        notif.attachments = [attachment]
        
        //4. Create a Notification Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        //5. Create a Notification request to link notification and trigger
        let request = UNNotificationRequest(identifier: "MyNotification", content: notif, trigger: notificationTrigger)
        
        //6. Add the notification created to the UNUserNotificationCenter
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print(error?.localizedDescription ?? "No description")
                completion(false)
            }else{
                completion(true)
            }
        }
        
    }

}

