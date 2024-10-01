import SwiftUI

struct PerCheck: View {
    
    @State private var tasks: [Task] = [
        Task(time: "6:00 AM", name: "Feed", isCompleted: true, frequency: "Daily"),
        Task(time: "1:00 PM", name: "Feed", isCompleted: false, frequency: "Daily"),
        Task(time: "3:15 PM", name: "Water", isCompleted: false, frequency: "Daily"),
        Task(time: "10:00 PM", name: "LitterBox", isCompleted: false, frequency: "Weekly")
    ]
    
    @State private var isEditing = false
    @State private var selectedDay = "Mon" // Example selected day

    // Fixed date to start the week (September 30, 2024)
    let startDate = Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 30))!
    
    // Get the current week starting from the fixed startDate
    var daysOfWeek: [Date] {
        return (0..<7).compactMap { Calendar.current.date(byAdding: .day, value: $0, to: startDate) }
        
    }
    
    var body: some View {
       
        
        NavigationView {
            
            ZStack{
                
                Color("backgroundGray") // Background color
            .ignoresSafeArea()
                    
                    
                    ZStack {
                        
                        // Background image
                        Image("background")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 500)
                            .position(x: 280, y: 30)
                        
                        VStack {
                            // Day Picker (Sun to Sat)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(daysOfWeek, id: \.self) { day in
                                        let dayName = getDayName(for: day)
                                        let dayOfMonth = getDayOfMonth(for: day)
                                        VStack {
                                            
                                            Text(dayName)
                                                .font(.caption)
                                                .offset(y: 100)
                                                .padding(.bottom, 100)
                                                

                                            Text(dayOfMonth)
                                                .font(.callout)
                                                .padding()
                                                .background(dayName == selectedDay ? Color.orange : Color.clear)
                                                .clipShape(Circle())//orange circle on the current day
                                              
                                        }
                                        
                                        .onTapGesture {
                                            selectedDay = dayName
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
                                    .padding(.trailing, 20)// Add space between Time and Task
                                    .offset(y: 70 ) // 120 Move text down without affecting other elements

                                Text("Task")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                    .offset(y: 70) // 120 Move text down without affecting other elements

                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            
                            
                            
                            
                            
                            // Main content with white rectangle background
                            VStack {
                                VStack(alignment: .leading, spacing: -20/*يسوي المسافه بين التاسكز*/) {
                                    ForEach($tasks) { $task in
                                        TaskView(task: $task, tasks: $tasks)
                                    }
                                }
                                .padding()
                                .background{
                                    Color.white
                                        .ignoresSafeArea()
                                    
                                } // White background for the task list
                                .cornerRadius(45) // Rounded corners
                                .shadow(radius: 1) // Add shadow effect
                                .frame(maxHeight: .infinity)
                                .position(x:180,y:200)
                            }
                            .padding(.horizontal)
                            //.padding(.vertical)// Padding for overall layout
                            //.padding(.bottom, -50)
                          //  Spacer()
                        }
                    }
                }
            
            
            
            
            
            
            
                .navigationBarItems(
                    leading: HStack {
                        Image(systemName: "chevron.left")
                        Image(systemName: "pawprint.fill")
                            .resizable()
                            .frame(width: 40, height: 40)//size of the paw check
                            .clipShape(Circle())
                        VStack(alignment:.leading){
                            Text("CatName")
                                .font(.title)
//                            Text("October")
//                                .font(.subheadline)
//                                .fontWeight(.light)
//                                .frame(width: 30.0, height: 30.0)//ليش الاسم والشهر نقاط
//                                .foregroundStyle(.gray)
                           }
                    },
                    trailing: Button("Edit")
                    {
                        isEditing.toggle()
                    }
                        .foregroundColor(.gray)
                )
            
              
            
            
            
            
                .navigationBarTitleDisplayMode(.inline)
                .onAppear(perform: loadTasks)//means that when this view appears on the screen, the loadTasks function will be called, which likely loads saved tasks (from UserDefaults or any other storage) when the view is presented.
                .sheet(isPresented: $isEditing) {
                    Text("Edit Tasks")//When isEditing is set to true (e.g., by pressing the "Edit" button), a sheet is presented with the text "Edit Tasks." This could later be expanded to allow the user to edit tasks.
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
                        .resizable() // Make the image resizable
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
            .cornerRadius(25)//حدود زاوية التاسك
            .overlay(
                RoundedRectangle(cornerRadius: 25)//حدود ايطار التاسك البرتقالي
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
           
    }
}

