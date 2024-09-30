import SwiftUI

struct PerCheck: View {
    
    @State private var tasks: [Task] = [
        Task(time: "6:00 AM", name: "Feed", isCompleted: true, frequency: "Daily"),
        Task(time: "1:00 PM", name: "Feed", isCompleted: false, frequency: "Daily"),
        Task(time: "3:15 PM", name: "Water", isCompleted: false, frequency: "Daily"),
        Task(time: "10:00 PM", name: "LitterBox", isCompleted: false, frequency: "Weekly")
    ]
    
    @State private var isEditing = false
    @State private var selectedDay = "Thu" // Example selected day

    // Fixed date to start the week (September 30, 2024)
    let startDate = Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 30))!
    
    // Get the current week starting from the fixed startDate
    var daysOfWeek: [Date] {
        return (0..<7).compactMap { Calendar.current.date(byAdding: .day, value: $0, to: startDate) }
    }
    
    var body: some View {
        NavigationView {
           /* ZStack{
                Image("background")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 900)
                    .position(x: 200, y: 350)*/
                
                ZStack{
                    Color(.systemGray6) // Background color
                        .ignoresSafeArea()
                    
                    ZStack {
                        // Background image or color
                        Image("background")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 500)
                            .position(x: 280, y: 30)
                        
                        VStack {
                            // Day Picker (Sun to Sat)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 5) {
                                    ForEach(daysOfWeek, id: \.self) { day in
                                        let dayName = getDayName(for: day)
                                        let dayOfMonth = getDayOfMonth(for: day)
                                        VStack {
                                            Text(dayName)
                                                .font(.caption)
                                            Text(dayOfMonth)
                                                .font(.title)
                                                .padding()
                                                .background(dayName == selectedDay ? Color.orange : Color.clear)
                                                .clipShape(Circle())
                                        }
                                        .onTapGesture {
                                            selectedDay = dayName
                                        }
                                    }
                                }
                                .padding()
                            }
                            
                            // Main content with white rectangle background
                            VStack(alignment: .leading, spacing: 10) {
                                // Header for time and task
                                HStack {
                                    Text("Time")
                                        .font(.headline)
                                        .foregroundColor(.gray)
                                        .frame(width: 80, alignment: .leading) // Same width as time column
                                    
                                    Text("Task")
                                        .font(.headline)
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                
                                // Task List inside the white rounded rectangle
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach($tasks) { $task in
                                        TaskView(task: $task, tasks: $tasks)
                                    }
                                }
                                .padding()
                                .background(Color.white) // White background for the task list
                                .cornerRadius(20) // Rounded corners
                                .shadow(radius: 5) // Add shadow effect
                            }
                            .padding(.horizontal) // Padding for overall layout
                            
                            Spacer()
                        }
                        .padding(.vertical) // Padding for content area
                    }
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
            
        }}
    
    // Function to get the day name (e.g., "Sun", "Mon", "Tue", etc.)
    func getDayName(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE" // Day of the week in short form
        return formatter.string(from: date)
    }
    
    // Function to get the day number (e.g., "26", "27", etc.)
    func getDayOfMonth(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d" // Day of the month
        return formatter.string(from: date)
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
    @Binding var tasks: [Task] // Pass all tasks for saving

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
                            saveTasks() // Save all tasks when toggling
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
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "tasks")
        }
    }
}

// Task Model
struct Task: Identifiable, Codable {
    var id = UUID()
    var time: String
    var name: String
    var isCompleted: Bool
    var frequency: String // Daily or Weekly
}

// Preview for SwiftUI canvas
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PerCheck()
            .previewDevice("iPhone 15 Pro") // Simulate iPhone 15 Pro preview
    }
}

