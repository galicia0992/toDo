//
//  Notification.swift
//  toDo
//
//  Created by Yair on 31/12/24.
//

import UserNotifications

func programarNotificacion(for task: Task) {
    guard let dueDate = task.dueDate else { return }
    
    let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
    
    let content = UNMutableNotificationContent()
    content.title = "Recordatorio"
    content.body = "Recuerda \(task.title)."
    content.sound = .default
    
    let request = UNNotificationRequest(identifier: task.id.uuidString, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request){ error in
        if let error = error {
            print("Error al programar notificación: \(error.localizedDescription)")
        } else {
            print("Notificación programada para \(dueDate)")
        }
    }
}

func programarNotificacionQuince(for task: Task) {
    guard let dueDate = task.dueDate else { return }
    guard let triggerDate = Calendar.current.date(byAdding: .minute, value: -15, to: dueDate) else {
            print("No se pudo calcular la fecha de notificación.")
            return
        }
    
    let triggerComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)
    
    let content = UNMutableNotificationContent()
    content.title = "Recordatorio"
    content.body = "Tu tarea \(task.title) esta programada para que la termines en 15 minutos."
    content.sound = .default
    
    let request = UNNotificationRequest(identifier: task.id.uuidString, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request){ error in
        if let error = error {
            print("Error al programar notificación: \(error.localizedDescription)")
        } else {
            print("Notificación programada para \(dueDate)")
        }
    }
}
