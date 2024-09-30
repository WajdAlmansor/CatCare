import SwiftUI

// Task model
struct Task: Identifiable, Codable {
    var id = UUID()
    var time: String
    var name: String
    var isCompleted: Bool
    var frequency: String // Daily or Weekly
}

// Main Content View
struct PerCheck: View {
    @State private var tasks: [Task] = [
        Task(time: "6:00 AM", name: "Feed", isCompleted: true, frequency: "Daily"),
        Task(time: "1:00 PM", name: "Feed", isCompleted: false, frequency: "Daily"),
        Task(time: "3:15 PM", name: "Water", isCompleted: false, frequency: "Daily"),
        Task(time: "10:00 PM", name: "LitterBox", isCompleted: false, frequency: "Weekly")
    ]
    
    @State private var isEditing = false
    @State private var selectedDay = "Thu" // Example selected day
    
    let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var body: some View {
        NavigationView {
            VStack {
                // Day Picker (Sun to Sat)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(daysOfWeek, id: \.self) { day in
                            VStack {
                                Text(day)
                                    .font(.caption)
                                Text(getDayOfMonth(for: day))
                                    .font(.title)
                                    .padding()
                                    .background(day == selectedDay ? Color.orange : Color.clear)
                                    .clipShape(Circle())
                            }
                            .onTapGesture {
                                selectedDay = day
                            }
                        }
                    }
                    .padding()
                }

                // Task List
                VStack(alignment: .leading, spacing: 10) {
                    ForEach($tasks) { $task in
                        TaskView(task: $task)
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationBarItems(
                leading: HStack {
                    Image(systemName: "pawprint.fill") // Replace with your asset or a static cat icon
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    Text("Pinky")
                        .font(.title)
                },
                trailing: Button("Edit") {
                    isEditing.toggle()
                }
            )
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: loadTasks)
            .sheet(isPresented: $isEditing) {
                // You can implement an edit view here if needed
                Text("Edit Tasks")
            }
        }
    }
    
    // Function to get the current date number for the day of the week (example logic)
    func getDayOfMonth(for day: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        if let date = formatter.date(from: day) {
            let dayOfMonthFormatter = DateFormatter()
            dayOfMonthFormatter.dateFormat = "d"
            return dayOfMonthFormatter.string(from: date)
        }
        return "26" // Return a default value
    }
    
    // Save tasks to UserDefaults
    func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "tasks")
        }
    }

    // Load tasks from UserDefaults
    func loadTasks() {
        if let savedData = UserDefaults.standard.data(forKey: "tasks"),
           let loadedTasks = try? JSONDecoder().decode([Task].self, from: savedData) {
            tasks = loadedTasks
        }
    }
}

// Task View (Row)
struct TaskView: View {
    @Binding var task: Task
    
    var body: some View {
        HStack(alignment: .top) {
            // Time Column
            VStack(alignment: .leading) {
                Text(task.time)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.gray)
                Spacer() // Push the time to the top
            }
            .frame(width: 80, alignment: .leading)
            
            // Vertical Divider
            Rectangle()
                .frame(width: 2)
                .foregroundColor(.blue)
                .padding(.vertical, 5)
            
            // Task Details Column
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(task.name)
                            .font(.system(size: 18, weight: .bold))
                            .strikethrough(task.isCompleted, color: .gray)
                        Text(task.frequency)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Image(systemName: task.isCompleted ? "pawprint.fill" : "pawprint")
                        .foregroundColor(task.isCompleted ? .gray : .orange)
                        .onTapGesture {
                            task.isCompleted.toggle() // Toggle completion status
                            saveTasks()
                        }
                }
            }
            .padding()
            .background(Color.orange.opacity(0.2))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.orange, lineWidth: task.isCompleted ? 0 : 2) // Adds the border for incomplete tasks
            )
        }
        .padding(.vertical, 5)
    }
    
    // Save updated task data
    func saveTasks() {
        if let encoded = try? JSONEncoder().encode([task]) {
            UserDefaults.standard.set(encoded, forKey: "tasks")
        }
    }
}

// Preview for SwiftUI canvas
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PerCheck()
    }
}
