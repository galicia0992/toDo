//
//  Task.swift
//  toDo
//
//  Created by Yair on 30/12/24.
//

import SwiftUI
import Foundation

enum TaskStatus: String, CaseIterable, Codable{
    case nueva = "Nueva"
    case enProceso = "En Proceso"
    case terminada = "Terminada" 
}
extension TaskStatus {
    var color: Color {
        switch self {
        case .nueva:
            return .blue
        case .enProceso:
            return .orange
        case .terminada:
            return .green
        }
    }
}


struct Task: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var status: TaskStatus
    
    init(title: String, status: TaskStatus = .nueva){
        self.id = UUID()
        self.title = title
        self.status = status
    }
}
