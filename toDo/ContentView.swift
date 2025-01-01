//
//  ContentView.swift
//  toDo
//
//  Created by Yair on 30/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var tasks: [Task] = []
    @State private var newTaskTitle: String = ""
    @State private var newTaskDate: Date = Date()
    
    
    func addTask() {
        guard !newTaskTitle.isEmpty else { return }
        let task = Task(title: newTaskTitle, status: .nueva, dueDate: newTaskDate)
        tasks.append(task)
        programarNotificacion(for: task)
        newTaskTitle = ""
    }
    
    func deleteTask(at offsets: IndexSet){
        tasks.remove(atOffsets: offsets) 
    }
    
    func loadTask(){
        if let data = UserDefaults.standard.data(forKey: "tasks"),
            let decodedTasks = try? JSONDecoder().decode([Task].self, from: data){
                tasks = decodedTasks
            }
    }
    func saveTask(){
        if let encodedTasks = try? JSONEncoder().encode(tasks){
            UserDefaults.standard.set(encodedTasks, forKey: "tasks")
        }
    }
    
    var body: some View {
        NavigationView{
            VStack {
                VStack {
                    HStack{
                        TextField("Escribe una tarea nueva", text: $newTaskTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button(action: addTask){
                            Image(systemName: "plus.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                            }
                    }
                    
                    DatePicker("Fecha y hora", selection: $newTaskDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                        .labelsHidden()
                        .padding(.bottom, 10)
                
                }
                List{
                    ForEach($tasks){
                        $task in HStack(){
                            Circle()
                                .fill(task.status.color)
                                .frame(width: 12, height: 12)
                            
                            Text(task.title)
                                .foregroundColor(task.status.color)
                            
                            Spacer()
                            
                            Picker(" ", selection: $task.status){
                                ForEach(TaskStatus.allCases, id: \.self){
                                    status in Text(status.rawValue).tag(status)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .navigationTitle("Mis Tareas")
            .onAppear{
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                        if let error = error {
                            print("Error al solicitar permisos: \(error.localizedDescription)")
                        }
                    }
                loadTask()
            }
            .onChange(of: tasks) { _ in saveTask()}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
