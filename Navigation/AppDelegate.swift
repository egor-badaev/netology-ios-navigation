//
//  AppDelegate.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let backgroundTaskTimer = BackgroundTaskTimer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        print(type(of: self), #function)

        setupWindow()
        
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        print(type(of: self), #function)

        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print(type(of: self), #function)
        
        // End background task
        backgroundTaskTimer.stopCalculations()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print(type(of: self), #function)
        
        // Start background task
        backgroundTaskTimer.startBackgroundTask()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print(type(of: self), #function)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print(type(of: self), #function)
        
        /**
         # Результаты замера времени исполнения приложения в фоне
         
         Я произвёл замеры на нескольких устройствах и разных операционных системах. Я не выявил какой-либо зависимости от устройства, но вот на разных версиях операционной системы поведение достаточно сильно отличается.
         
         ## До iOS 13
         
         Измерения проводились на симуляторах
         
         * iPhone 7 (iOS 11.4)
         * iPhone 6 (iOS 12.4)
         
         Приложение первоначально сообщает примерно 180 секунд (в консоль выводилось ~179.6)
         За 5 секунд до окончания система вызывает `expirationHandler` и выполнение задачи прекращается
         
         Итоговый результат - **175 секунд**
         
         ## iOS 13 и выше
         
         Измерения проводилось на следующих устройствах:
         
         * iPhone 12 Pro (iOS 14.3)
         * iPad Pro 9.7 inch (iOS 14.3)
         * iPhone X (iOS 14.2)
         * iPhone SE 1st gen (iOS 14.2)
         * iPhone SE 2nd gen (iOS 13.7)
         
         На всех устройствах приложение даёт на выполнение задания 30 секунд (первый вывод в консоль ~29.6 секунд)
         
          *Примечание: в некоторых случаях изначально сообщается бесконечное время, например 1.7976931348623157e+308 секунд, но после пары выводов таких чисел в консоль пересчитывается на 30 секунд*
         
         За 5 секунд до окончания система вызывает `expirationHandler`, он отрабатывает, но выполнение фонового задания **не прекращается**. Задание завершается только когда остаётся 0 секунд.
         
         Итоговый результат - **30 секунд**
 
         */
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print(type(of: self), #function)
    }

    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootTabBarController()
        window?.makeKeyAndVisible()
    }

}

