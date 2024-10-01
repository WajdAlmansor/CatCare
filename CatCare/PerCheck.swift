import SwiftUI

struct PerCheck: View {
    
    @State private var tasks: [Task] = [
        Task(time: "6:00 AM", name: "Feed", isCompleted: true, frequency: "Daily"),
        Task(time: "1:00 PM", name: "Feed", isCompleted: false, frequency: "Daily"),
        Task(time: "3:15 PM", name: "Water", isCompleted: false, frequency: "Daily"),
        Task(time: "10:00 PM", name: "LitterBox", isCompleted: false, frequency: "Weekly")
    ]
    //Here
    
    @State private var isEditing = false

    // Fixed date to start the week (September 30, 2024)
    let startDate = Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 30))!
    
    // Get the current week starting from the fixed startDate
    var daysOfWeek: [Date] {
        return (0..<7).compactMap { Calendar.current.date(byAdding: .day, value: $0, to: startDate) }
    }
    
    // Get the current day as a string (e.g., "Mon", "Tue", etc.)
    var currentDayName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE" // Short form of the day
        return formatter.string(from: Date()) // Get current date
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("backgroundGray")
                    .ignoresSafeArea()

                ZStack {
                    // Background image
                    Image("background")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 500)
                        .position(x: 280, y: 30)
                    
                    VStack {
                        VStack(alignment: .leading) {
                            Text("October")
                                .offset(x: -78, y: 20)
                                .font(.system(size: 20))
                                .foregroundColor(.gray)
                            Text("Today reminders")
                                .fontWeight(.light)
                                .offset(x: -82)
                                .font(.title)
                                .padding(4.0)
                        }

                        // Day Picker (Sun to Sat) without selection
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(daysOfWeek, id: \.self) { day in
                                    let dayName = getDayName(for: day)
                                    let dayOfMonth = getDayOfMonth(for: day)
                                    VStack {
                                        Text(dayName)
                                            .font(.caption)
                                            .offset(y: 10)
                                            .padding(.bottom, 10)

                                        Text(dayOfMonth)
                                            .font(.callout)
                                            .padding()
                                            .background(dayName == currentDayName ? Color.orange : Color.clear) // Highlight current day
                                            .clipShape(Circle()) // No tap gesture here
                                    }
                                }
                            }
                            .padding()
                        }

                        HStack {
                            Text("Time")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .frame(width: 80, alignment: .leading)
                                .padding(.trailing, 20)
                                .offset(y: -2)

                            Text("Task")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .offset(y: -2)

                            Spacer()
                        }
                        .padding(.horizontal)

                        
                        // Main content with white rectangle background
                        VStack {
                            
                                VStack(alignment: .leading, spacing: -20) {
                                    ForEach($tasks) { $task in
                                        TaskView(task: $task, tasks: $tasks)
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                //.frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                .cornerRadius(45)
                                .shadow(radius: 1)
                                .frame(maxHeight: .infinity)
                                .position(x: 180, y: 230)
                            }
                        .padding(.horizontal)
                        //.edgesIgnoringSafeArea(.bottom)
                    }
                }
            }
            .navigationBarItems(
                leading: HStack {
                    Image(systemName: "chevron.left")
                    Image(systemName: "pawprint.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    VStack(alignment:.leading) {
                        Text("CatName")
                            .font(.title)
                    }
                },
                trailing: Button("Edit") {
                    isEditing.toggle()
                }
                .foregroundColor(.gray)
            )
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: loadTasks)
            .sheet(isPresented: $isEditing) {
                Text("Edit Tasks")
            }
        }
    }
    
    // Function to get the day name (e.g., "Sun", "Mon", "Tue", etc.)
    func getDayName(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    // Function to get the day number (e.g., "26", "27", etc.)
    func getDayOfMonth(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
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
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(task.isCompleted ? .orange : .orange)
                        .onTapGesture {
                            task.isCompleted.toggle() // Toggle completion status
                            saveTasks() // Save all tasks when toggling
                        }
                }
            }
            .padding()
            .background(Color.orange.opacity(0.3))
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.orange, lineWidth: task.isCompleted ? 0 : 2)
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
    }
}
