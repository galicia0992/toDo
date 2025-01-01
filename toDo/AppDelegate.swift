//
//  AppDelegate.swift
//  toDo
//
//  Created by Yair on 31/12/24.
//

import SwiftUI
import UserNotifications


struct TareasApp: App {
    init() {
        // Solicitar permiso para notificaciones
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Error solicitando permiso para notificaciones: \(error.localizedDescription)")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
