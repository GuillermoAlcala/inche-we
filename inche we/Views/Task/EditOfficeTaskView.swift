//
//  EditOfficeTaskView.swift
//  inche we
//

import SwiftUI
import SwiftData

struct EditOfficeTaskView: View {
    let task: TaskItem
    @State private var title: String
    @State private var createDate: Date
    @State private var dueDate: Date
    @State private var isCompleted: Bool
    @State private var notified: Bool

    @Environment(\.modelContext) private var modelcontext
    @Environment(\.dismiss) private var dismiss

    init(task: TaskItem) {
        self.task = task
        _title = State(initialValue: task.title)
        _createDate = State(initialValue: task.createDate)
        _dueDate = State(initialValue: task.dueDate)
        _isCompleted = State(initialValue: task.isCompleted)
        _notified = State(initialValue: task.notify)
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Rename your task", text: $title)
                DatePicker("update creation date", selection: $createDate, in: Date()..., displayedComponents: .date)
                DatePicker("Update due date", selection: $dueDate,in: Date()...,displayedComponents: [.date,.hourAndMinute])
                Toggle("Notification", isOn: $notified)

            }
            .navigationTitle("Edit task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveChanges()
                    }
                    .tint(.pink)
                }
            }
            .navigationTitle("Edit your task")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func saveChanges() { // para editar la information
        task.title = title
        task.createDate = createDate
        task.dueDate = dueDate
        task.isCompleted = isCompleted
        task.notify = notified
        do {
            try modelcontext.save()
            dismiss()
        } catch {
            print("Error al guardar", error.localizedDescription)
        }
    }
}
